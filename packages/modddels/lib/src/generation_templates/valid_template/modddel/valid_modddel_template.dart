import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/class_members/property.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/to_string_method_template.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';

/// The template for the valid union-case class of a modddel.
///
class ValidModddelTemplate extends ModddelGenerationTemplate {
  ValidModddelTemplate({
    required this.modddelInfo,
    required this.sSealedInfo,
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

      $membersProperties

      $maybeMapValidnessMethod

      ${isCaseModddel ? maybeMapModddelsMethod : ''}

      $propsGetter

      $toStringMethod
    }
    ''';
  }

  /// The declaration of the valid union-case class.
  ///
  /// For example :
  ///
  /// - If the modddel is solo : `class ValidPerson extends Person implements
  ///   ValidEntity`
  /// - If the modddel is a case-modddel : `class ValidSunny extends Weather
  ///   with ValidWeather, Sunny`.
  ///
  String get classDeclaration {
    if (isCaseModddel) {
      final declaration = ClassDeclarationTemplate(
          className: _validClassName,
          isAbstract: false,
          extendsClasses: [
            sSealedClassIdentifiers!.className
          ],
          withClasses: [
            sSealedClassIdentifiers!.validClassName,
            modddelClassIdentifiers.className,
          ]);

      return declaration.toString();
    }

    final declaration = ClassDeclarationTemplate(
      className: _validClassName,
      isAbstract: false,
      extendsClasses: [modddelClassIdentifiers.className],
      implementsClasses: [_validBaseInterfaceName],
    );

    return declaration.toString();
  }

  /// The constructor of the valid union-case class.
  ///
  String get constructor {
    final constructorParams = modddelInfo
        .modddelValidationInfo.validParametersTemplate
        .asNamed(optionality: Optionality.makeAllRequired)
        .asLocal();

    return '$_validClassName._($constructorParams) : super._();';
  }

  /// The properties for the member parameters.
  ///
  String get membersProperties {
    final parametersTemplate =
        modddelInfo.modddelValidationInfo.validParametersTemplate;

    final properties = parametersTemplate.allParameters.map((param) {
      final property = Property.fromParameter(param);

      final hasOverride =
          param.hasWithGetterAnnotation || isSharedParam(param.name);

      // The doc should only be removed if the parameter has a withGetter
      // annotation, in which case the doc will be copied in the base modddel
      // template.
      final removeDoc = param.hasWithGetterAnnotation;

      return property.copyWithModifiers(
          addOverrideAnnotation: hasOverride, removeDoc: removeDoc);
    }).toList();

    return properties.join('\n');
  }

  String get maybeMapValidnessMethod {
    final method = MaybeMapValidnessMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
      unionCaseParamName: GlobalIdentifiers.validCallbackParamName,
    );

    return '''
    @override
    $method
    ''';
  }

  String get maybeMapModddelsMethod {
    assert(isCaseModddel);

    final unionCaseParamName =
        modddelInfo.modddelClassInfo.constructor.callbackName;

    final method = MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo!.sSealedClassInfo,
      getCaseModddelParam: (caseModddel) => CaseModddelParam.fromParameter(
          caseModddel.classIdentifiers.validParameter),
      bodyKind: MethodBodyKind.withImplementation,
      unionCaseParamName: unionCaseParamName,
    );

    return '''
    @override
    $method
    ''';
  }

  /// The "props" getter of the Equatable package, correctly implemented.
  ///
  String get propsGetter {
    final props =
        modddelInfo.modddelValidationInfo.validParametersTemplate.allParameters;

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
    final fields =
        modddelInfo.modddelValidationInfo.validParametersTemplate.allParameters;

    return ToStringMethodTemplate(
      concreteClassName: _validClassName,
      fields: fields,
    ).toString();
  }

  /// The name of the valid union-case class.
  ///
  String get _validClassName => modddelClassIdentifiers.validClassName;

  /// The name of the implemented "valid" base interface.
  ///
  String get _validBaseInterfaceName =>
      GlobalIdentifiers.validnessInterfacesIdentifiers
          .getValidBaseInterfaceName(modddelKind);
}
