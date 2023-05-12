import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:modddels/src/core/templates/annotations.dart';
import 'package:modddels/src/core/tools/ast.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen/source_gen.dart';

/// Represents a [NullFailure] annotation that has been parsed.
///
class ParsedNullFailure {
  ParsedNullFailure._({
    required this.validationName,
    required this.failure,
    required this.maskNb,
  });

  @factory
  static Future<ParsedNullFailure> fromNullFailureAnnotation({
    required ElementAnnotation annotation,
    required Element annotatedElement,
    required BuildStep buildStep,
  }) async {
    if (!nullFailureAnnotationInfo.matches(
      annotation,
      annotatedElement: annotatedElement,
    )) {
      throw ArgumentError(
        'ParsedNullFailure.fromNullFailureAnnotation called on a annotation '
            'other than "@NullFailure".',
        'annotation',
      );
    }

    // computeConstantValue won't be null because the annotation is valid
    // (`AnnotationInfo.matches` would have thrown an error otherwise)
    final annotationObject = annotation.computeConstantValue()!;

    // 1. The `validationName` field
    final validationName =
        annotationObject.getField('validationName')!.toStringValue();

    if (validationName == null) {
      throw InvalidGenerationSourceError(
        'The annotation "@NullFailure" should contain the validationName '
        'as a valid string.',
        element: annotatedElement,
      );
    }

    // 2. The `maskNb` field
    final maskNb = annotationObject.getField('maskNb')!.toIntValue();

    // 3. The `failure` field
    final node = await tryGetAstNodeForElement(annotatedElement, buildStep);

    final failure = node.accept(NullFailureAstVisitor(
      maskNb: maskNb,
      annotatedElement: annotatedElement,
    ));

    if (failure == null) {
      throw InvalidGenerationSourceError(
        'Failed to extract the "failure" field of the "@NullFailure" annotation.',
        element: annotatedElement,
      );
    }

    return ParsedNullFailure._(
      validationName: validationName,
      failure: failure,
      maskNb: maskNb,
    );
  }

  /// The parsed [NullFailure.validationName].
  ///
  final String validationName;

  /// The parsed source code of [NullFailure.failure].
  ///
  final String failure;

  /// The parsed [NullFailure.maskNb].
  ///
  final int? maskNb;
}
