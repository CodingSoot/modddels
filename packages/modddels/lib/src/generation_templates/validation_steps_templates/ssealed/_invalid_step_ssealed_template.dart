import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/fields_interface_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// The template for the "invalid-step" super-sealed class of the
/// [validationStep].
///
class InvalidStepSSealedTemplate extends SSealedGenerationTemplate {
  InvalidStepSSealedTemplate({
    required this.sSealedInfo,
    required this.validationStep,
  });

  @override
  final SSealedInfo sSealedInfo;

  final ValidationStepInfo validationStep;

  @override
  String toString() {
    return '''
    $classDeclaration {
      ${validationStep.hasOneValidation ? '' : hasFailureGetters}

      $failuresGetter

      $mapModddelsMethod

      $maybeMapModddelsMethod

      $mapOrNullModddelsMethod
    }
    ''';
  }

  /// The declaration of the invalid-step ssealed class.
  ///
  /// For example : `mixin InvalidWeatherValue implements InvalidWeather` ± the
  /// [FieldsInterfaceTemplate].
  ///
  String get classDeclaration {
    final invalidStepClassName =
        sSealedClassIdentifiers.getInvalidStepClassName(validationStep);

    final declaration = MixinDeclarationTemplate(
      className: invalidStepClassName,
      implementsClasses: [
        sSealedClassIdentifiers.invalidClassName,
      ],
    );

    return FieldsInterfaceTemplate.wrapDeclaration(
      mixinDeclaration: declaration,
      fields: getters,
    ).toString();
  }

  /// The getters for the member parameters and the failures of the invalid-step
  /// ssealed class.
  ///
  String get getters {
    final membersGetters = validationStep.parametersTemplate.allParameters
        .asGetters(implementation: null);

    final failuresGetters = _failuresParameters.asGetters(implementation: null);

    return [...membersGetters, ...failuresGetters].join('\n');
  }

  /// The "hasFailure" getters. These check whether the invalid-step ssealed
  /// class has a particular failure.
  ///
  String get hasFailureGetters {
    assert(!validationStep.hasOneValidation,
        '''The "hasFailure" getters are only generated when a validationStep 
        contains more than one validation. If the validationStep contains only
        one validation, the matching invalid-step ssealed class always holds the
        failure of the validation and thus there is no need for a "hasFailure" 
        getter.''');

    final hasFailureGetters = validationStep.validations.map((validation) {
      final hasFailureGetterName =
          generalIdentifiers.getHasFailureGetterName(validation);

      return Getter(
        name: hasFailureGetterName,
        type: 'bool',
        implementation: null,
      );
    }).toList();

    return hasFailureGetters.join('\n');
  }

  /// The general "failures" getter, overridden from [InvalidModddel.failures].
  ///
  String get failuresGetter {
    final failuresGetterParam =
        GlobalIdentifiers.invalidModddelBaseIdentifiers.getFailuresGetterParam(
      failureBaseClassName: _failureBaseClassName,
    );

    return Getter.fromParameter(failuresGetterParam, implementation: null)
        .copyWithModifiers(addOverrideAnnotation: true)
        .toString();
  }

  String get mapModddelsMethod {
    final method = MapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    @override
    $method
    ''';
  }

  String get maybeMapModddelsMethod {
    final method = MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.abstract,
      unionCaseParamName: null,
    );

    return '''
    @override
    $method
    ''';
  }

  String get mapOrNullModddelsMethod {
    final method = MapOrNullModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
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

  /// The parameters that represent the failures of the [validationStep].
  ///
  List<Parameter> get _failuresParameters => validationStep.validations
      .map((validation) => generalIdentifiers.getFailureParameter(validation,
          hasNullableType: !validationStep.hasOneValidation))
      .toList();

  CaseModddelParam _getCaseModddelParam(ModddelClassInfo caseModddel) {
    return CaseModddelParam.fromParameter(
        caseModddel.classIdentifiers.getInvalidStepParameter(validationStep));
  }
}
