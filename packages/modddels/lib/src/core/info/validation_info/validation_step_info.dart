import 'package:modddels/src/core/info/validation_info/_vstep_transformations.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// Holds information about a validationStep and its matching "invalid"
/// union-case. This info can be either related to a modddel or an annotated
/// super-sealed class.
///
class ValidationStepInfo {
  ValidationStepInfo({
    required this.parametersTemplate,
    required this.name,
    required this.validations,
    required this.nullFailureParameters,
    required this.vStepTransformations,
  }) {
    for (final validation in validations) {
      validation.parentValidationStep = this;
    }
  }

  /// Creates a [ValidationStepInfo] without initializing the [validations]'
  /// parentValidationStep.
  ///
  ValidationStepInfo._noInitialization({
    required this.parametersTemplate,
    required this.name,
    required this.validations,
    required this.nullFailureParameters,
    required this.vStepTransformations,
  });

  /// Regex for a valid validationStep name. It must begin with an _uppercase_
  /// letter, and it must be made of valid dart identifier characters
  /// (alphanumeric, underscore and dollar sign).
  ///
  static final nameRegex = RegExp(r'^[A-Z][\w$]+$');

  /// The member parameters with all transformations of the previous
  /// validationSteps applied.
  ///
  /// NB :
  /// - If this [ValidationStepInfo] is for a modddel : The form of the
  ///   parameters (required/optional, positional/named) is unchanged, i.e
  ///   it's the same as in the factory constructor.
  /// - If this [ValidationStepInfo] is for an annotated super-sealed class :
  ///   The parameters are all named and required.
  ///
  final ParametersTemplate parametersTemplate;

  /// The name of the validationStep.
  ///
  /// Example : 'Form'
  ///
  final String name;

  /// The list of validations of this validationStep. The order doesn't matter.
  ///
  final List<ValidationInfo> validations;

  /// The member parameters that have at least one [NonNullParamTransformation]
  /// that will be applied on them after this validationStep is passed.
  ///
  final List<Parameter> nullFailureParameters;

  /// Whether there is at least one member parameter which has a
  /// [NonNullParamTransformation] that will be applied on it after this
  /// validationStep is passed.
  ///
  bool get hasNullFailures => nullFailureParameters.isNotEmpty;

  /// The transformations that will be applied on the member parameters after
  /// this validationStep is passed.
  ///
  final VStepTransformations vStepTransformations;

  /// Whether this validationStep contains the contentValidation.
  ///
  bool get isContentValidationStep =>
      validations.any((validation) => validation.isContentValidation);

  /// Whether this validationStep only contains one validation.
  ///
  bool get hasOneValidation => validations.length == 1;

  /// **NB :** Copying with null values is not implemented
  ///
  ValidationStepInfo copyWith({
    ParametersTemplate? parametersTemplate,
    String? name,
    List<Parameter>? nullFailureParameters,
    VStepTransformations? vStepTransformations,
  }) {
    return ValidationStepInfo._noInitialization(
      parametersTemplate: parametersTemplate ?? this.parametersTemplate,
      name: name ?? this.name,
      nullFailureParameters:
          nullFailureParameters ?? this.nullFailureParameters,
      vStepTransformations: vStepTransformations ?? this.vStepTransformations,
      validations: validations,
    );
  }
}
