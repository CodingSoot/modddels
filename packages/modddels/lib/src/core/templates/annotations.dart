import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_null_failure.dart';
import 'package:source_gen/source_gen.dart';

const validAnnotationInfo = AnnotationInfo(
  name: '@validParam',
  type: ValidParamAnnotation,
);

const invalidAnnotationInfo = AnnotationInfo(
  name: '@invalidParam',
  type: InvalidParamAnnotation,
);

const withGetterAnnotationInfo = AnnotationInfo(
  name: '@withGetter',
  type: WithGetterAnnotation,
);

const validWithGetterAnnotationInfo = AnnotationInfo(
  name: '@validWithGetter',
  type: ValidWithGetterAnnotation,
);

const invalidWithGetterAnnotationInfo = AnnotationInfo(
  name: '@invalidWithGetter',
  type: InvalidWithGetterAnnotation,
);

const nullFailureAnnotationInfo = AnnotationInfo(
  name: '@NullFailure',
  type: NullFailure,
);

const dependencyParamAnnotationInfo = AnnotationInfo(
  name: '@dependencyParam',
  type: DependencyParamAnnotation,
);

const typeTemplateAnnotationInfo = AnnotationInfo(
  name: '@TypeTemplate',
  type: TypeTemplate,
);

/// Represents an annotation.
///
class AnnotationInfo {
  const AnnotationInfo({
    required this.name,
    required this.type,
  });

  /// The name of the annotation. Only used for debugging/error messages.
  ///
  final String name;

  /// The type of the annotation.
  ///
  /// For example : [WithGetterAnnotation].
  ///
  final Type type;

  TypeChecker get typeChecker => TypeChecker.fromRuntime(type);

  /// Whether the [annotation] is an annotation represented by this
  /// [AnnotationInfo].
  ///
  /// Throws an [InvalidGenerationSourceError] if the annotation contains
  /// errors.
  ///
  bool matches(
    ElementAnnotation annotation, {
    required Element? annotatedElement,
  }) {
    return typeChecker.isExactlyType(annotation.getAnnotationType(
      annotatedElement: annotatedElement,
    ));
  }
}

extension ModddelsAnnotation on ElementAnnotation {
  /// Returns the type of this annotation.
  ///
  /// Throws an [InvalidGenerationSourceError] if the annotation contains
  /// errors.
  ///
  DartType getAnnotationType({
    required Element? annotatedElement,
  }) {
    final result = computeConstantValue()?.type;
    if (result == null) {
      throw InvalidGenerationSourceError(
        'The annotation "${toSource()}" contains errors. Please fix the errors.',
        element: annotatedElement,
      );
    }
    return result;
  }
}

extension ParameterElementAnnotations on ParameterElement {
  /// Returns true if this [ParameterElement] is annotated with only one of the
  /// [annotations].
  ///
  /// If it's not annotated with any of [annotations], returns false.
  ///
  /// If it's annotated with more than one of [annotations], or if it's
  /// annotated with the same annotation more than once, throws a
  /// [InvalidGenerationSourceError].
  ///
  bool hasSingleAnnotation(List<AnnotationInfo> annotations) {
    AnnotationInfo? singleAnnotation;

    void setSingleAnnotation(AnnotationInfo annotationInfo) {
      if (singleAnnotation != null) {
        throw InvalidGenerationSourceError(
          'A parameter can\'t have both of these annotations : '
          '${singleAnnotation!.name} and ${annotationInfo.name}',
          element: this,
        );
      }
      singleAnnotation = annotationInfo;
    }

    for (final annotationInfo in annotations) {
      final matchingMetadata = metadata
          .where((meta) => annotationInfo.matches(meta, annotatedElement: this))
          .toList();

      if (matchingMetadata.length > 1) {
        throw InvalidGenerationSourceError(
          'A parameter can\'t have the same annotation more than once : ${annotationInfo.name}',
          element: this,
        );
      }

      if (matchingMetadata.length == 1) {
        setSingleAnnotation(annotationInfo);
      }
    }
    return singleAnnotation != null;
  }

  /// True if the parameter has the `@validParam` annotation or the
  /// `@validWithGetter` annotation.
  ///
  bool get hasValidAnnotation => hasSingleAnnotation([
        validAnnotationInfo,
        validWithGetterAnnotationInfo,
      ]);

  /// True if the parameter has the `@invalidParam` annotation or the
  /// `@invalidWithGetter` annotation.
  ///
  bool get hasInvalidAnnotation => hasSingleAnnotation([
        invalidAnnotationInfo,
        invalidWithGetterAnnotationInfo,
      ]);

  /// True if the parameter has the `@withGetter` annotation, the
  /// `@validWithGetter` annotation, or the `@invalidWithGetter` annotation.
  ///
  bool get hasWithGetterAnnotation => hasSingleAnnotation([
        withGetterAnnotationInfo,
        validWithGetterAnnotationInfo,
        invalidWithGetterAnnotationInfo,
      ]);

  /// True if the parameter has at least one `@NullFailure` annotation.
  ///
  bool get hasNullFailureAnnotation => _nullFailureAnnotations.isNotEmpty;

  /// True if the parameter has the `@dependencyParam` annotation.
  ///
  bool get hasDependencyAnnotation => hasSingleAnnotation([
        dependencyParamAnnotationInfo,
      ]);

  /// Returns the list of the `@NullFailure` annotations of this parameter.
  ///
  Future<List<ParsedNullFailure>> getParsedNullFailures({
    required BuildStep buildStep,
  }) {
    if (!hasNullFailureAnnotation) {
      return Future.value(const []);
    }
    return Future.wait(_nullFailureAnnotations
        .map((annotation) => ParsedNullFailure.fromNullFailureAnnotation(
              annotation: annotation,
              annotatedElement: this,
              buildStep: buildStep,
            )));
  }

  List<ElementAnnotation> get _nullFailureAnnotations => metadata
      .where((meta) =>
          nullFailureAnnotationInfo.matches(meta, annotatedElement: this))
      .toList();
}
