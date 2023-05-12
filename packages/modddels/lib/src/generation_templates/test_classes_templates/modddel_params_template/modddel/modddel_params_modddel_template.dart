import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_prototypes.dart';
import 'package:modddels/src/core/templates/to_string_method_template.dart';
import 'package:modddels/src/core/utils.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/modddel/base_class_modddel_template.dart';

/// The template for the ModddelParams class of a modddel.
///
/// It's a class that represents the parameter of a modddel.
///
class ModddelParamsModddelTemplate extends ModddelGenerationTemplate {
  ModddelParamsModddelTemplate({
    required this.sSealedInfo,
    required this.modddelInfo,
  });

  @override
  final ModddelInfo modddelInfo;

  @override
  final SSealedInfo? sSealedInfo;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $properties

      $sanitizedParamsGetter

      $toModddelMethod

      $propsGetter

      $toStringMethod
    }
    ''';
  }

  /// The declaration of the ModddelParams class.
  ///
  /// For example :
  ///
  /// - If the modddel is solo : `class PersonParams extends
  ///   ModddelParams<Person>`
  /// - If the modddel is a case-modddel : `class _SunnyParams extends
  ///   WeatherParams`
  ///
  String get classDeclaration {
    final modddelParamsBaseClassName = GlobalIdentifiers
        .modddelParamsBaseIdentifiers.modddelParamsBaseClassName;

    final declaration = ClassDeclarationTemplate(
      className: modddelClassIdentifiers.modddelParamsClassName,
      isAbstract: false,
      extendsClasses: [
        isCaseModddel
            ? sSealedClassIdentifiers!.modddelParamsClassName
            : '$modddelParamsBaseClassName<${modddelClassIdentifiers.className}>'
      ],
    );

    return declaration.toString();
  }

  /// The constructor of the ModddelParams class.
  ///
  String get constructor {
    String getSuperCall() {
      final superKeyword = isCaseModddel ? 'super._' : 'super';

      final classNameParameter =
          GlobalIdentifiers.modddelParamsBaseIdentifiers.classNameParameter;
      final modddelKindParameter =
          GlobalIdentifiers.modddelParamsBaseIdentifiers.modddelKindParameter;

      final superArguments = ArgumentsTemplate(
        namedArguments: [
          classNameParameter.toArgument(
              argument: "'${modddelClassIdentifiers.className.escaped()}'"),
          if (!isCaseModddel)
            modddelKindParameter.toArgument(
                argument: "'${modddelKind.name.escaped()}'")
        ],
      );

      return '$superKeyword($superArguments)';
    }

    final modddelParamsClassName =
        modddelClassIdentifiers.modddelParamsClassName;

    var constructorParams = modddelInfo
        .modddelParametersInfo.constructorParametersTemplate
        .asLocal();

    constructorParams = isCaseModddel
        ? constructorParams.asNamed(optionality: Optionality.makeAllRequired)
        : constructorParams;

    return 'const $modddelParamsClassName($constructorParams) : ${getSuperCall()};';
  }

  /// The properties of the ModddelParams class. These include all the
  /// parameters of the modddel, both members and dependencies.
  ///
  String get properties {
    final properties = modddelInfo
        .modddelParametersInfo.constructorParametersTemplate.allParameters
        .asPropreties()
        .map((property) => property.copyWith(doc: ''))
        .toList();

    return properties.join('\n');
  }

  /// The "sanitizedParams" getter.
  ///
  /// It calls `toModddel` to instantiate a modddel, and then returns the
  /// ModddelParams which represents the parameters that are actually held
  /// inside the modddel (i.e after the parameters have potentially been
  /// transformed/sanitized in the modddel's factory constructor).
  ///
  String get sanitizedParamsGetter {
    final modddelParamsClassName =
        modddelClassIdentifiers.modddelParamsClassName;

    final modddelLocalVarName =
        GlobalIdentifiers.modddelParamsBaseIdentifiers.modddelLocalVarName;

    final toModddelMethodName =
        GlobalIdentifiers.modddelParamsBaseIdentifiers.toModddelMethodName;

    String getImplementation() {
      final mapValidityPrototype = MapValidityPrototype(
          classInfo: modddelInfo.modddelClassInfo,
          validationSteps:
              modddelInfo.modddelValidationInfo.allValidationSteps);

      final mapValidityMethodName = mapValidityPrototype.methodName;

      var arguments = ArgumentsTemplate.fromParametersTemplate(
              modddelInfo.modddelParametersInfo.constructorParametersTemplate)
          .asAssignedWith((parameter) {
        final isDeclaredInBaseModddelClass =
            BaseClassModddelTemplate.isDeclaredInBaseModddelClass(
          parameter,
          modddelInfo: modddelInfo,
        );

        if (isDeclaredInBaseModddelClass) {
          return '$modddelLocalVarName.${parameter.name}';
        }

        final mapValidityArgs = ArgumentsTemplate.fromParametersTemplate(
                mapValidityPrototype.parametersTemplate)
            .asAssignedWith((callbackParam) {
          final callbackVar = callbackParam.name;
          return '($callbackVar) => $callbackVar.${parameter.name}';
        });

        return '$modddelLocalVarName.$mapValidityMethodName($mapValidityArgs)';
      });

      arguments = isCaseModddel ? arguments.asNamed() : arguments;

      return '''
      final $modddelLocalVarName = $toModddelMethodName();

      return $modddelParamsClassName($arguments);
      ''';
    }

    return Getter(
      name: GlobalIdentifiers
          .modddelParamsBaseIdentifiers.sanitizedParamsGetterName,
      type: modddelParamsClassName,
      implementationKind: ImplementationKind.regular,
      implementation: getImplementation(),
    ).copyWithModifiers(addOverrideAnnotation: true).toString();
  }

  /// The "toModddel" method.
  ///
  /// It instantiates a modddel with the parameters of the ModddelParams.
  ///
  String get toModddelMethod {
    final toModddelMethodName =
        GlobalIdentifiers.modddelParamsBaseIdentifiers.toModddelMethodName;

    final constructorFullName =
        modddelInfo.modddelClassInfo.constructor.fullName;

    final modddelClassName = modddelClassIdentifiers.className;

    final arguments = ArgumentsTemplate.fromParametersTemplate(
        modddelInfo.modddelParametersInfo.constructorParametersTemplate);

    final result = isCaseModddel
        ? '$constructorFullName($arguments) as $modddelClassName'
        : '$modddelClassName($arguments)';

    return '''
    @override
    $modddelClassName $toModddelMethodName() {
      return $result;
    }
    ''';
  }

  /// The "props" getter of the Equatable package.
  ///
  String get propsGetter {
    final props = modddelInfo
        .modddelParametersInfo.memberParametersTemplate.allParameters;

    final implementation = '[${props.map((p) => p.name).join(', ')}]';

    return Getter(
      name: GlobalIdentifiers.propsGetterName,
      type: 'List<Object?>',
      implementation: implementation,
    ).copyWithModifiers(addOverrideAnnotation: true).toString();
  }

  /// The "toString" method.
  ///
  String get toStringMethod {
    final fields = modddelInfo
        .modddelParametersInfo.memberParametersTemplate.allParameters;

    return ToStringMethodTemplate(
      concreteClassName: null,
      fields: fields,
    ).toString();
  }
}
