import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';
import 'package:modddels/src/generation_templates/validation_steps_templates/ssealed/_invalid_step_ssealed_template.dart';
import 'package:modddels/src/generation_templates/validation_steps_templates/ssealed/_subholder_ssealed_template.dart';

/// The template for the ssealed classes of the validationSteps.
///
/// It includes for each validationStep :
///
/// - [InvalidStepSSealedTemplate]
/// - [SubHolderSSealedTemplate]
///
class ValidationStepsSSealedTemplate extends SSealedGenerationTemplate {
  ValidationStepsSSealedTemplate({
    required this.sSealedInfo,
  });

  @override
  final SSealedInfo sSealedInfo;

  @override
  String toString() {
    return sSealedInfo.sSealedValidationInfo.allValidationSteps
        .map(_makeValidationStepClasses)
        .join('\n');
  }

  String _makeValidationStepClasses(ValidationStepInfo validationStep) {
    final invalidStepClass = InvalidStepSSealedTemplate(
      sSealedInfo: sSealedInfo,
      validationStep: validationStep,
    );

    // This list can be empty if the validationStep only contains the
    // contentValidation.
    final subholderClasses = validationStep.validations
        .where((validation) => !validation.isContentValidation)
        .map((validation) => SubHolderSSealedTemplate(
              sSealedInfo: sSealedInfo,
              validation: validation,
            ))
        .toList();

    return '''
    $invalidStepClass

    ${subholderClasses.join('\n')}
    ''';
  }
}
