import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/generation_templates/modddel_template.dart';
import 'package:modddels/src/generation_templates/test_classes_templates/invalid_steps_test_template/invalid_steps_test_template.dart';
import 'package:modddels/src/generation_templates/test_classes_templates/tester_template/tester_template.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// The template for all the classes generated for an annotated solo class.
///
class AnnotatedSoloTemplate {
  AnnotatedSoloTemplate({
    required this.modddelInfo,
    required this.modddelTemplate,
    required this.generateTestClasses,
    required this.maxTestInfoLength,
  });

  /// See [Modddel.generateTestClasses].
  ///
  final bool generateTestClasses;

  /// See [Modddel.maxTestInfoLength].
  ///
  final int maxTestInfoLength;

  /// The info of the solo modddel.
  ///
  final ModddelInfo modddelInfo;

  final ModddelTemplate modddelTemplate;

  @override
  String toString() {
    final testerTemplate = TesterTemplate.forAnnotatedSoloTemplate(
      annotatedSoloTemplate: this,
    );

    final invalidStepsTestsTemplate =
        InvalidStepsTestsTemplate.forAnnotatedSoloTemplate(
      annotatedSoloTemplate: this,
    );

    return '''
    $modddelTemplate

    ${generateTestClasses ? testerTemplate : ''}

    ${generateTestClasses ? invalidStepsTestsTemplate : ''}
    ''';
  }
}
