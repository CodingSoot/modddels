import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/class_members/property.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/to_string_method_template.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// The template for the "invalid-step" union-case class of the
/// [validationStep].
///
class InvalidStepModddelTemplate extends ModddelGenerationTemplate {
  InvalidStepModddelTemplate({
    required this.sSealedInfo,
    required this.modddelInfo,
    required this.validationStep,
  });

  @override
  final ModddelInfo modddelInfo;

  @override
  final SSealedInfo? sSealedInfo;

  final ValidationStepInfo validationStep;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $properties

      ${validationStep.hasOneValidation ? '' : hasFailureGetters}

      $failuresGetter

      $propsGetter

      $maybeMapValidnessMethod

      ${isCaseModddel ? maybeMapModddelsMethod : ''}

      $toStringMethod

    }
    ''';
  }

  /// The declaration of the invalid-step union-case class.
  ///
  /// For example :
  ///
  /// - If the modddel is solo : `class InvalidPersonMid extends Person with
  ///   InvalidPerson`
  /// - If the modddel is a case-modddel : `class InvalidSunnyValue extends
  ///   Weather with InvalidWeather, Sunny, InvalidSunny, InvalidWeatherValue`.
  ///
  String get classDeclaration {
    if (isCaseModddel) {
      final sSealedInvalidStepClassName =
          sSealedClassIdentifiers!.getInvalidStepClassName(validationStep);

      return ClassDeclarationTemplate(
        className: _invalidStepClassName,
        isAbstract: false,
        extendsClasses: [
          sSealedClassIdentifiers!.className,
        ],
        withClasses: [
          sSealedClassIdentifiers!.invalidClassName,
          modddelClassIdentifiers.className,
          modddelClassIdentifiers.invalidClassName,
          sSealedInvalidStepClassName,
        ],
      ).toString();
    } else {
      return ClassDeclarationTemplate(
        className: _invalidStepClassName,
        isAbstract: false,
        extendsClasses: [
          modddelClassIdentifiers.className,
        ],
        withClasses: [
          modddelClassIdentifiers.invalidClassName,
        ],
      ).toString();
    }
  }

  /// The constructor of the invalid-step union-case class.
  ///
  String get constructor {
    final constructorParams = validationStep.parametersTemplate
        .appendParameters(namedParameters: _failuresParameters)
        .asNamed(optionality: Optionality.makeAllRequired)
        .asLocal();

    return '$_invalidStepClassName._($constructorParams) : super._();';
  }

  /// The properties for the member parameters and the failures of the
  /// invalid-step union-case class.
  ///
  String get properties {
    final membersProperties = validationStep.parametersTemplate.allParameters
        .asPropreties()
        .copyWithModifiers(addOverrideAnnotation: true, removeDoc: true);

    final failuresProperties = _failuresParameters
        .asPropreties()
        .copyWithModifiers(addOverrideAnnotation: isCaseModddel);

    return [...membersProperties, ...failuresProperties].join('\n');
  }

  /// The "hasFailure" getters. These check whether the invalid-step union-case
  /// has a particular failure.
  ///
  String get hasFailureGetters {
    assert(!validationStep.hasOneValidation,
        '''The "hasFailure" getters are only generated when a validationStep 
        contains more than one validation. If the validationStep contains only
        one validation, the matching invalid-step union-case always holds the
        failure of the validation and thus there is no need for a "hasFailure" 
        getter.''');

    final hasFailureGetters = validationStep.validations.map((validation) {
      final hasFailureGetterName =
          generalIdentifiers.getHasFailureGetterName(validation);

      final failureVariableName =
          generalIdentifiers.getFailureVariableName(validation);

      return Getter(
        name: hasFailureGetterName,
        type: 'bool',
        implementation: '$failureVariableName != null',
      );
    }).toList();

    return hasFailureGetters
        .copyWithModifiers(addOverrideAnnotation: isCaseModddel)
        .join('\n');
  }

  /// The general "failures" getter, overridden from [InvalidModddel.failures].
  ///
  String get failuresGetter {
    final failuresList = validationStep.hasOneValidation
        ? _failuresParameters.single.name
        : _failuresParameters
            .map((param) => 'if (${param.name} != null) ${param.name}!')
            .join(', ');

    return Getter.fromParameter(
      GlobalIdentifiers.invalidModddelBaseIdentifiers.getFailuresGetterParam(
        failureBaseClassName: _failureBaseClassName,
      ),
      implementation: '[$failuresList]',
    ).copyWithModifiers(addOverrideAnnotation: true).toString();
  }

  /// The "props" getter of the Equatable package, correctly implemented.
  ///
  String get propsGetter {
    final props = [
      ...validationStep.parametersTemplate.allParameters,
      ..._failuresParameters,
    ];

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
    final fields = [
      GlobalIdentifiers.invalidModddelBaseIdentifiers.getFailuresGetterParam(
        failureBaseClassName: _failureBaseClassName,
      ),
      ...validationStep.parametersTemplate.allParameters,
    ];

    return ToStringMethodTemplate(
      concreteClassName: _invalidStepClassName,
      fields: fields,
    ).toString();
  }

  String get maybeMapValidnessMethod {
    final unionCaseParamName =
        generalIdentifiers.getInvalidStepCallbackParamName(validationStep);

    final method = MaybeMapValidnessMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
      unionCaseParamName: unionCaseParamName,
    );

    return '''
    @override
    $method
    ''';
  }

  String get maybeMapModddelsMethod {
    assert(sSealedInfo != null);

    final unionCaseParamName =
        modddelInfo.modddelClassInfo.constructor.callbackName;

    final method = MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo!.sSealedClassInfo,
      getCaseModddelParam: (caseModddel) => CaseModddelParam.fromParameter(
          caseModddel.classIdentifiers.getInvalidStepParameter(validationStep)),
      bodyKind: MethodBodyKind.withImplementation,
      unionCaseParamName: unionCaseParamName,
    );

    return '''
    @override
    $method
    ''';
  }

  /// The name of the base class of the failures of the modddel.
  ///
  String get _failureBaseClassName => GlobalIdentifiers.failuresBaseIdentifiers
      .getFailureBaseClassName(modddelKind);

  /// The name of the invalid-step union-case class.
  ///
  String get _invalidStepClassName =>
      modddelClassIdentifiers.getInvalidStepClassName(validationStep);

  /// The parameters that represent the failures of the [validationStep].
  ///
  List<Parameter> get _failuresParameters => validationStep.validations
      .map((validation) => generalIdentifiers.getFailureParameter(
            validation,
            hasNullableType: !validationStep.hasOneValidation,
          ))
      .toList();
}
