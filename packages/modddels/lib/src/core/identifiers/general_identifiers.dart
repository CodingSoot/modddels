// ignore_for_file: library_private_types_in_public_api

import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/utils.dart';

/// Identifiers that are related to the annotated class, but that remain the
/// same no matter if it's a modddel or ssealed.
///
class GeneralIdentifiers {
  GeneralIdentifiers({required this.annotatedClassName}) {
    topLevelMixinIdentifiers = _TopLevelMixinIdentifiers._(this);
    holderIdentifiers = _HolderIdentifiers._(this);
    testerIdentifiers = _TesterIdentifiers._(this);
    invalidStepTestClassIdentifiers = _InvalidStepTestClassIdentifiers._(this);
  }

  /// The name of the annotated class.
  ///
  /// Example : 'Weather'
  ///
  final String annotatedClassName;

  late final _TopLevelMixinIdentifiers topLevelMixinIdentifiers;

  late final _HolderIdentifiers holderIdentifiers;

  late final _TesterIdentifiers testerIdentifiers;

  late final _InvalidStepTestClassIdentifiers invalidStepTestClassIdentifiers;

  /// The name of the "copyWith" getter.
  ///
  String get copyWithGetterName => 'copyWith';

  /// Returns the name of the callback parameter for the "invalid-step"
  /// union-case / ssealed class matching the [validationStep].
  ///
  /// Example : 'invalidForm'
  ///
  String getInvalidStepCallbackParamName(ValidationStepInfo validationStep) =>
      'invalid${validationStep.name}';

  /// Returns the name of the callback parameter for the failures of the
  /// "invalid-step" union-case / ssealed class matching the [validationStep].
  ///
  /// Example : 'formFailures'
  ///
  String getFailuresCallbackParamName(ValidationStepInfo validationStep) =>
      '${validationStep.name}Failures'.uncapitalize();

  /// Returns the name of the variable that represents the failure of the
  /// [validation].
  ///
  /// Example : 'habitableFailure'
  ///
  String getFailureVariableName(ValidationInfo validation) =>
      '${validation.validationName}Failure';

  /// Returns the parameter that represents the failure of the [validation].
  ///
  /// If [hasNullableType] is true, the type of the parameter is nullable.
  ///
  /// Example : 'WeatherHabitableFailure habitableFailure'
  ///
  Parameter getFailureParameter(
    ValidationInfo validation, {
    required bool hasNullableType,
  }) =>
      ExpandedParameter.empty(
        name: getFailureVariableName(validation),
        type: hasNullableType
            ? nullableType(validation.failureType)
            : validation.failureType,
      );

  /// Returns the name of the "hasFailure" getter, which is part of the
  /// invalid-step union-case / ssealed class that matches the [validation]'s
  /// parent validationStep.
  ///
  /// Example : 'hasHabitableFailure'
  ///
  String getHasFailureGetterName(ValidationInfo validation) =>
      'has${getFailureVariableName(validation).capitalize()}';
}

/* -------------------------------------------------------------------------- */
/*                             Grouped Identifiers                            */
/* -------------------------------------------------------------------------- */

// TODO : These classes should be replaced by records inside
// [GeneralIdentifiers] once the records feature is available in Dart.

abstract class _GroupedGeneralIdentifiers {
  _GroupedGeneralIdentifiers(this._generalIdentifiers)
      : annotatedClassName = _generalIdentifiers.annotatedClassName;

  final String annotatedClassName;

  final GeneralIdentifiers _generalIdentifiers;
}

class _TopLevelMixinIdentifiers extends _GroupedGeneralIdentifiers {
  _TopLevelMixinIdentifiers._(super.annotatedClassName);

  /// The name of the top-level mixin, which is the mixin that is mixed-in by
  /// the annotated class.
  ///
  /// Example : '_$Weather'
  ///
  String get topLevelMixinName => '_\$$annotatedClassName';

  /// The name of the "init" method.
  ///
  String get initMethodName => r'_$init';

  /// The name of the "instance" method, which creates a private instance of the
  /// annotated class.
  ///
  String get instanceMethodName => r'_$instance';

  /// The name of the variable representing a private instance of the annotated
  /// class.
  ///
  /// Example : '$weatherInstance'
  ///
  String get instanceVariableName =>
      '\$${_generalIdentifiers.annotatedClassName.uncapitalize()}Instance';

  /// The parameter representing a private instance of the annotated class.
  ///
  /// Example : 'Weather $weatherInstance'
  ///
  ExpandedParameter get instanceParameter => ExpandedParameter.empty(
        name: instanceVariableName,
        type: annotatedClassName,
      );

  /// Returns the name of the "validate" method of the [validation].
  ///
  /// Throws an [ArgumentError] if [validation] is the contentValidation. For
  /// the contentValidation, use instead
  /// [ModddelClassIdentifiers.getValidateContentMethodName].
  ///
  /// Example : 'validateHabitable'
  ///
  String getValidateMethodName(ValidationInfo validation) {
    if (validation.isContentValidation) {
      throw ArgumentError(
        'Must not be the contentValidation. Use instead `getValidateContentMethodName`.',
        'validation',
      );
    }
    return 'validate${validation.validationName.capitalize()}';
  }
}

class _HolderIdentifiers extends _GroupedGeneralIdentifiers {
  _HolderIdentifiers._(super.annotatedClassName);

  /// Returns the name of the "verifyNullables" method which converts the holder
  /// of the [validation]'s parent validationStep to the [validation]'s
  /// subholder.
  ///
  /// Example : 'verifyHabitableNullables'
  ///
  String getVerifyNullablesMethodName(ValidationInfo validation) =>
      'verify${validation.validationName.capitalize()}Nullables';

  /// Returns the name of the "toSubholder" method which converts the holder of
  /// the [validation]'s parent validationStep to the [validation]'s subholder.
  ///
  /// Example : 'toHabitableSubholder'
  ///
  String getToSubHolderMethodName(ValidationInfo validation) =>
      'to${validation.validationName.capitalize()}Subholder';
}

class _TesterIdentifiers extends _GroupedGeneralIdentifiers {
  _TesterIdentifiers._(super.annotatedClassName);

  /// The name of the Tester class.
  ///
  /// Example : 'TestWeather'
  ///
  String get testerClassName => 'Test$annotatedClassName';

  /// Returns the name of the "isInvalid" getter matching the [validationStep],
  /// which is part of the Tester class.
  ///
  /// Example : 'isInvalidForm'
  ///
  String getIsInvalidGetterName(ValidationStepInfo validationStep) =>
      'isInvalid${validationStep.name}';
}

class _InvalidStepTestClassIdentifiers extends _GroupedGeneralIdentifiers {
  _InvalidStepTestClassIdentifiers._(super.annotatedClassName);

  /// Returns the name of the InvalidStepTest matching the [validationStep].
  ///
  /// Example : 'InvalidUsernameFormTest'
  ///
  String getInvalidStepTestClassName(ValidationStepInfo validationStep) =>
      'Invalid$annotatedClassName${validationStep.name}Test';

  final maxTestInfoLengthParameter =
      ExpandedParameter.empty(name: 'maxTestInfoLength', type: 'int?');

  final testOnParameter =
      ExpandedParameter.empty(name: 'testOn', type: 'String?');

  final timeoutParameter =
      ExpandedParameter.empty(name: 'timeout', type: 'Timeout?');

  final skipParameter = ExpandedParameter.empty(name: 'skip');

  final tagsParameter = ExpandedParameter.empty(name: 'tags');

  final onPlatformParameter = ExpandedParameter.empty(
      name: 'onPlatform', type: 'Map<String, dynamic>?');

  final retryParameter = ExpandedParameter.empty(name: 'retry', type: 'int?');
}
