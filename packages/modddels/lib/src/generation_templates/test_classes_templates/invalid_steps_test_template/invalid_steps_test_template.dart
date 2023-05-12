import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/generation_templates/test_classes_templates/invalid_steps_test_template/_invalid_step_test_class_template.dart';
import 'package:modddels/src/generators/annotated_class_template/annotated_solo_template.dart';
import 'package:modddels/src/generators/annotated_class_template/annotated_ssealed_template.dart';

/// The template for the "InvalidStepTests" for all the validationSteps of the
/// annotated class. See [InvalidStepTestClassTemplate].
///
class InvalidStepsTestsTemplate {
  /// Creates the [InvalidStepsTestsTemplate] for a ssealed annotated class.
  ///
  InvalidStepsTestsTemplate.forAnnotatedSSealedTemplate({
    required AnnotatedSSealedTemplate annotatedSSealedTemplate,
  })  : classInfo = annotatedSSealedTemplate.sSealedInfo.sSealedClassInfo,
        validationSteps = annotatedSSealedTemplate
            .sSealedInfo.sSealedValidationInfo.allValidationSteps;

  /// Creates the [InvalidStepsTestsTemplate] for a solo annotated class.
  ///
  InvalidStepsTestsTemplate.forAnnotatedSoloTemplate({
    required AnnotatedSoloTemplate annotatedSoloTemplate,
  })  : classInfo = annotatedSoloTemplate.modddelInfo.modddelClassInfo,
        validationSteps = annotatedSoloTemplate
            .modddelInfo.modddelValidationInfo.allValidationSteps;

  final ClassInfo classInfo;
  final List<ValidationStepInfo> validationSteps;

  @override
  String toString() {
    final invalidStepTests = validationSteps
        .map((validationStep) => InvalidStepTestClassTemplate(
              classInfo: classInfo,
              validationStep: validationStep,
            ))
        .toList();

    return invalidStepTests.join('\n');
  }
}
