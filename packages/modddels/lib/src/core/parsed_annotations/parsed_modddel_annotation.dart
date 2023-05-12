import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_shared_prop.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen/source_gen.dart';

/// Represents a [Modddel] annotation that has been parsed.
///
class ParsedModddelAnnotation {
  ParsedModddelAnnotation._({
    required this.parsedValidationSteps,
    required this.parsedSharedProps,
    required this.generateTestClasses,
    required this.maxTestInfoLength,
  });

  factory ParsedModddelAnnotation.fromModddelAnnotation({
    required LibraryElement library,
    required ConstantReader annotation,
    required ClassElement annotatedClass,
  }) {
    // 1. The `validationSteps` field
    final parsedValidationSteps = annotation
        .read('validationSteps')
        .listValue
        .map((validationStepObject) =>
            ParsedValidationStep.fromValidationStepObject(
              library: library,
              validationStepObject: validationStepObject,
            ))
        .toList();

    // 2. The `sharedProps` field
    final parsedSharedProps = annotation
        .read('sharedProps')
        .listValue
        .map((sharedPropObject) => ParsedSharedProp.fromSharedPropObject(
              sharedPropObject: sharedPropObject,
            ))
        .toList();

    // 3. The `generateTestClasses` field
    final generateTestClasses =
        annotation.read('generateTestClasses').boolValue;

    // 4. The `maxTestInfoLength` field
    final maxTestInfoLength = annotation.read('maxTestInfoLength').intValue;

    if (!(maxTestInfoLength > 0 || maxTestInfoLength == Modddel.noMaxLength)) {
      throw InvalidGenerationSourceError(
          'The [maxTestInfoLength] should be > 0 or should equal Modddel.noMaxLength',
          element: annotatedClass);
    }

    return ParsedModddelAnnotation._(
      parsedValidationSteps: parsedValidationSteps,
      parsedSharedProps: parsedSharedProps,
      generateTestClasses: generateTestClasses,
      maxTestInfoLength: maxTestInfoLength,
    );
  }

  /// The parsed [Modddel.validationSteps].
  ///
  final List<ParsedValidationStep> parsedValidationSteps;

  /// The parsed [Modddel.sharedProps].
  ///
  final List<ParsedSharedProp> parsedSharedProps;

  /// The parsed [Modddel.generateTestClasses].
  ///
  final bool generateTestClasses;

  /// The parsed [Modddel.maxTestInfoLength].
  ///
  final int maxTestInfoLength;
}
