import 'package:modddels/src/core/info/validation_info/_vstep_transformations.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// Computes the [VStepTransformations] of a validationStep for a modddel. That
/// is, calculates the transformations that will be applied on the member
/// parameters of a modddel after a validationStep is passed.
///
class ModddelVStepTransformationsComputer {
  ModddelVStepTransformationsComputer._({
    required this.vStepTransformations,
  });

  /// Calculates the [VStepTransformations] of a validationStep represented by
  /// [parsedVStep]. That is, it calculates the transformations that
  /// will be applied on the parameters contained in [vStepParametersTemplate]
  /// (see [ValidationStepInfo.parametersTemplate]) after the validationStep is
  /// passed.
  ///
  /// ## How it works :
  ///
  /// A. We add the [NonNullParamTransformation]s : These are the
  ///    transformations related to the '@NullFailure' annotations that will be
  ///    processed during the validationStep.
  ///    1. We gather the names of the validations of the validationStep.
  ///    2. For each parameter, we gather its NullFailure annotation(s) that
  ///       reference one of those validations.
  ///    3. Then, we create a transformation for each of these annotations (if
  ///       any).
  ///
  /// B. If the validationStep contains the contentValidation, we add the
  /// [ValidParamTransformation]s and [NullParamTransformation]s. For each
  /// parameter :
  ///    1. If it's annotated with the '@invalidParam' annotation, we create a
  ///       [NullParamTransformation].
  ///    2. If it isn't annotated with '@invalidParam' nor '@validParam', we
  ///       create a [ValidParamTransformation].
  ///
  factory ModddelVStepTransformationsComputer.compute({
    required ParametersTemplate vStepParametersTemplate,
    required ParsedValidationStep parsedVStep,
  }) {
    final vStepParameters = vStepParametersTemplate.allParameters;

    final vStepTransformations =
        VStepTransformations.empty(trackedParameters: vStepParameters);

    // A.
    // 1.
    final validationNames = parsedVStep.parsedValidations
        .map((parsedValidation) => parsedValidation.validationName)
        .toList();

    for (final parameter in vStepParameters) {
      // 2.
      final vStepNullFailures = parameter.nullFailures
          .where((nullFailure) =>
              validationNames.contains(nullFailure.validationName))
          .toList();

      // 3.
      final transformations = vStepNullFailures
          .map((nullFailure) => ParamTransformation.makeNonNull(
              maskNb: nullFailure.maskNb,
              validationName: nullFailure.validationName))
          .toList();

      if (transformations.isNotEmpty) {
        vStepTransformations.addAllTransformations(
            parameter.name, transformations);
      }
    }

    // B.
    if (parsedVStep.containsContentValidation) {
      for (final parameter in vStepParameters) {
        ParamTransformation? transformation;

        // 1.
        if (parameter.hasInvalidAnnotation) {
          transformation = const ParamTransformation.makeNull();
        }

        // 2.
        if (!parameter.hasValidAnnotation && !parameter.hasInvalidAnnotation) {
          transformation = const ParamTransformation.makeValid();
        }

        if (transformation != null) {
          vStepTransformations.addTransformation(
              parameter.name, transformation);
        }
      }
    }

    return ModddelVStepTransformationsComputer._(
        vStepTransformations: vStepTransformations);
  }

  /// The computed transformations that will be applied after the
  /// validationStep is passed.
  ///
  final VStepTransformations vStepTransformations;
}
