import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// Holds information about a single validation.
///
class ValidationInfo {
  ValidationInfo({
    required this.validationName,
    required this.failureType,
    required this.isContentValidation,
    required this.subHolderParametersTemplate,
    required this.nullFailureParameters,
  });

  /// Regex for a valid validation name. It must begin with a _lowercase_
  /// letter, and it must be made of valid dart identifier characters
  /// (alphanumeric, underscore and dollar sign).
  ///
  static final validationNameRegex = RegExp(r'^[a-z][\w$]+$');

  /// The parent [ValidationStepInfo] that contains this [ValidationInfo].
  ///
  late final ValidationStepInfo parentValidationStep;

  /// The name of the validation.
  ///
  /// Example : 'size'
  ///
  final String validationName;

  /// The type of the failure of the validation.
  ///
  final String failureType;

  /// Whether this validation is the contentValidation.
  ///
  final bool isContentValidation;

  /// The parameters template of the [parentValidationStep] with all the
  /// [NonNullParamTransformation]s that refer to this validation applied.
  ///
  /// Those are the transformations that have
  /// [NonNullParamTransformation.validationName] equal to [validationName].
  ///
  final ParametersTemplate subHolderParametersTemplate;

  /// The member parameters that have at least one [NonNullParamTransformation]
  /// that refers to this validation.
  ///
  /// Those are the transformations that have
  /// [NonNullParamTransformation.validationName] equal to [validationName].
  ///
  final List<Parameter> nullFailureParameters;

  /// Whether there are any NullFailures that should be processed during this
  /// validation.
  ///
  bool get hasNullFailures => nullFailureParameters.isNotEmpty;

  /// **NB :** Copying with null values is not implemented
  ///
  ValidationInfo copyWith({
    ValidationStepInfo? parentValidationStep,
    String? validationName,
    String? failureType,
    bool? isContentValidation,
    ParametersTemplate? subHolderParametersTemplate,
    List<Parameter>? nullFailureParameters,
  }) {
    return ValidationInfo(
      validationName: validationName ?? this.validationName,
      failureType: failureType ?? this.failureType,
      isContentValidation: isContentValidation ?? this.isContentValidation,
      subHolderParametersTemplate:
          subHolderParametersTemplate ?? this.subHolderParametersTemplate,
      nullFailureParameters:
          nullFailureParameters ?? this.nullFailureParameters,
    )..parentValidationStep = parentValidationStep ?? this.parentValidationStep;
  }
}
