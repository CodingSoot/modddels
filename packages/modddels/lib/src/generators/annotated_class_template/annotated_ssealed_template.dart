import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/generation_templates/modddel_template.dart';
import 'package:modddels/src/generation_templates/ssealed_template.dart';
import 'package:modddels/src/generation_templates/test_classes_templates/invalid_steps_test_template/invalid_steps_test_template.dart';
import 'package:modddels/src/generation_templates/test_classes_templates/tester_template/tester_template.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// The template for all the classes generated for an annotated super-sealed
/// class.
///
class AnnotatedSSealedTemplate {
  AnnotatedSSealedTemplate({
    required this.sSealedInfo,
    required this.sSealedTemplate,
    required this.caseModddelsTemplates,
    required this.generateTestClasses,
    required this.maxTestInfoLength,
  });

  /// The info of the annotated super-sealed class.
  ///
  final SSealedInfo sSealedInfo;

  final SSealedTemplate sSealedTemplate;

  final List<ModddelTemplate> caseModddelsTemplates;

  /// See [Modddel.generateTestClasses].
  ///
  final bool generateTestClasses;

  /// See [Modddel.maxTestInfoLength].
  ///
  final int maxTestInfoLength;

  @override
  String toString() {
    final testerTemplate = TesterTemplate.forAnnotatedSSealedTemplate(
      annotatedSSealedTemplate: this,
    );

    final invalidStepsTestsTemplate =
        InvalidStepsTestsTemplate.forAnnotatedSSealedTemplate(
      annotatedSSealedTemplate: this,
    );

    return '''
    $sSealedTemplate

    ${caseModddelsTemplates.join('\n')}

    ${generateTestClasses ? testerTemplate : ''}

    ${generateTestClasses ? invalidStepsTestsTemplate : ''}
    ''';
  }
}
