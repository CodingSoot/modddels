import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/utils.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';

/// The template for the super-sealed ModddelParams class.
///
/// It's an abstract class with factory constructors that allow the developer to
/// create the ModddelParams of each case-modddel.
///
class ModddelParamsSSealedTemplate extends SSealedGenerationTemplate {
  ModddelParamsSSealedTemplate({
    required this.sSealedInfo,
  });

  @override
  final SSealedInfo sSealedInfo;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $factoryConstructors

      $sharedParametersGetters
    }
    ''';
  }

  /// The declaration of the ssealed ModddelParams class.
  ///
  /// For example : `abstract class WeatherParams extends
  /// ModddelParams<Weather>`
  ///
  String get classDeclaration {
    final modddelParamsBaseClassName = GlobalIdentifiers
        .modddelParamsBaseIdentifiers.modddelParamsBaseClassName;

    final declaration = ClassDeclarationTemplate(
        className: sSealedClassIdentifiers.modddelParamsClassName,
        isAbstract: true,
        extendsClasses: [
          '$modddelParamsBaseClassName<${sSealedClassIdentifiers.className}>'
        ]);

    return declaration.toString();
  }

  /// The constructor of the ssealed ModddelParams class.
  ///
  String get constructor {
    final constructorParams = ParametersTemplate(namedParameters: [
      GlobalIdentifiers.modddelParamsBaseIdentifiers.classNameParameter
    ]).asNamed(optionality: Optionality.makeAllRequired);

    final classNameParameter =
        GlobalIdentifiers.modddelParamsBaseIdentifiers.classNameParameter;
    final modddelKindParameter =
        GlobalIdentifiers.modddelParamsBaseIdentifiers.modddelKindParameter;

    final superArguments = ArgumentsTemplate(
      namedArguments: [
        classNameParameter.toArgument(),
        modddelKindParameter.toArgument(
            argument: "'${modddelKind.name.escaped()}'"),
      ],
    );

    return 'const $_sSealedModddelParamsClassName._($constructorParams)'
        ' : super($superArguments);';
  }

  /// The factory constructors for the ModddelParams of the different
  /// case-modddels.
  ///
  String get factoryConstructors {
    return caseModddelsInfos.map(_makeFactoryConstructor).join('\n');
  }

  /// The getters for the shared parameters.
  ///
  String get sharedParametersGetters {
    final parameters = sSealedInfo.sSealedParametersInfo.sharedParameters
        .map((sharedParam) => sharedParam.toExpandedParameter())
        .toList();

    final getters = parameters.asGetters(implementation: null);

    return getters.join('\n');
  }

  /// The name of the ssealed ModddelParams class.
  ///
  String get _sSealedModddelParamsClassName =>
      sSealedClassIdentifiers.modddelParamsClassName;

  String _makeFactoryConstructor(ModddelInfo modddelInfo) {
    final modddelConstructor = modddelInfo.modddelClassInfo.constructor;

    final constructorName = modddelConstructor.isDefault
        ? _sSealedModddelParamsClassName
        : '$_sSealedModddelParamsClassName.${modddelConstructor.name}';

    final factoryParams = modddelInfo
        .modddelParametersInfo.constructorParametersTemplate
        .asExpanded(showDefaultValue: true);

    final modddelParamsClassName =
        modddelInfo.modddelClassInfo.classIdentifiers.modddelParamsClassName;

    final arguments =
        ArgumentsTemplate.fromParametersTemplate(factoryParams).asNamed();

    return '''
    factory $constructorName($factoryParams) {
      return $modddelParamsClassName($arguments);
    }
    ''';
  }
}
