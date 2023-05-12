import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/info/parameter_type_info/_type_template_syntax_error.dart';
import 'package:modddels/src/core/info/parameter_type_info/_type_template_expression.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_type_template.dart';
import 'package:modddels/src/core/templates/annotations.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

/// This is a resolver that extracts the [TypeTemplateExpression] of the
/// annotated class. Should only be used when said class is an IterableEntity or
/// Iterable2Entity.
///
class IterablesTypeTemplateResolver {
  IterablesTypeTemplateResolver._({required this.typeTemplateExpression});

  /// Extracts the [TypeTemplateExpression] of the given [annotatedClass]. Also,
  /// ensures that the TypeTemplate contains the same number of masks as
  /// [masksCount].
  ///
  /// ## How it works :
  ///
  /// 1. We search for the TypeTemplate annotation in [annotatedClass] and all
  ///    its supertypes. Lower supertypes take precedence over higher ones.
  /// 2. Once we find it, we parse its template string, and make a
  ///    TypeTemplateExpression.
  /// 3. We verify that the [masksCount] is respected.
  ///
  factory IterablesTypeTemplateResolver.resolve({
    required ClassElement annotatedClass,
    required int masksCount,
  }) {
    // 1.
    final classesToExplore = [
      annotatedClass,
      ...annotatedClass.allSupertypes.map((e) => e.element)
    ];

    final classWithAnnotation = classesToExplore.firstWhereOrNull((element) =>
        element.metadata.any((annotation) => typeTemplateAnnotationInfo.matches(
              annotation,
              annotatedElement: element,
            )));

    final typeTemplateAnnotationList = classWithAnnotation?.metadata
        .where((annotation) => typeTemplateAnnotationInfo.matches(
              annotation,
              annotatedElement: classWithAnnotation,
            ))
        .toList();

    if (classWithAnnotation == null ||
        typeTemplateAnnotationList == null ||
        typeTemplateAnnotationList.isEmpty) {
      throw InvalidGenerationSourceError(
        'No TypeTemplate annotation found.',
        element: annotatedClass,
      );
    }

    if (typeTemplateAnnotationList.length > 1) {
      throw InvalidGenerationSourceError(
        'A class can\'t have more than one TypeTemplate annotation.',
        element: classWithAnnotation,
      );
    }

    final typeTemplateAnnotation = typeTemplateAnnotationList.single;

    // 2.
    final parsedTypeTemplate = ParsedTypeTemplate.fromTypeTemplateAnnotation(
      annotation: typeTemplateAnnotation,
      annotatedElement: classWithAnnotation,
    );

    final typeTemplate = parsedTypeTemplate.typeTemplate;

    final TypeTemplateExpression typeTemplateExpression;

    try {
      typeTemplateExpression = TypeTemplateExpression(typeTemplate);
    } on TypeTemplateSyntaxError catch (error) {
      throw InvalidGenerationSourceError(
        error.toString(),
        element: classWithAnnotation,
      );
    }

    // 3.
    _assertCorrectMaskCount(
      typeTemplateExpression: typeTemplateExpression,
      masksCount: masksCount,
      classWithAnnotation: classWithAnnotation,
    );

    return IterablesTypeTemplateResolver._(
        typeTemplateExpression: typeTemplateExpression);
  }

  final TypeTemplateExpression typeTemplateExpression;
}

void _assertCorrectMaskCount({
  required TypeTemplateExpression typeTemplateExpression,
  required int masksCount,
  required InterfaceElement classWithAnnotation,
}) {
  if (typeTemplateExpression.masksCount != masksCount) {
    throw InvalidGenerationSourceError(
      'The TypeTemplate should contain $masksCount mask(s).',
      element: classWithAnnotation,
    );
  }
}
