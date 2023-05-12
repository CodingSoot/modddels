import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/templates/annotations.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen/source_gen.dart';

/// Represents a [TypeTemplate] annotation that has been parsed.
///
class ParsedTypeTemplate {
  ParsedTypeTemplate._({required this.typeTemplate});

  factory ParsedTypeTemplate.fromTypeTemplateAnnotation({
    required ElementAnnotation annotation,
    required Element annotatedElement,
  }) {
    if (!typeTemplateAnnotationInfo.matches(
      annotation,
      annotatedElement: annotatedElement,
    )) {
      throw ArgumentError(
        'ParsedTypeTemplate.fromTypeTemplateAnnotation called on an '
            'annotation other than "@TypeTemplate".',
        'annotation',
      );
    }

    // computeConstantValue won't be null because the annotation is valid
    // (`AnnotationInfo.matches` would have thrown an error otherwise)
    final annotationObject = annotation.computeConstantValue()!;

    // 1. The `template` field
    final typeTemplate = annotationObject.getField('template')!.toStringValue();

    if (typeTemplate == null) {
      throw InvalidGenerationSourceError(
        'The annotation "@TypeTemplate" should contain the template as a valid '
        'string.',
        element: annotatedElement,
      );
    }

    return ParsedTypeTemplate._(typeTemplate: typeTemplate);
  }

  /// The parsed [TypeTemplate.template].
  ///
  final String typeTemplate;
}
