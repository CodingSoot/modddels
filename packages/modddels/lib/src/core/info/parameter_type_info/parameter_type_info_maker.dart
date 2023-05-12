import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/info/parameter_type_info/_iterables_type_template_resolver.dart';
import 'package:modddels/src/core/info/parameter_type_info/_type_template_expression.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/utils.dart' as utils;
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';
import 'package:source_gen/source_gen.dart';

typedef ParameterTypeInfoMakerConstructor<PTIM extends ParameterTypeInfoMaker>
    = PTIM Function({required ClassElement annotatedClass});

/// A [ParameterTypeInfoMaker] is a callable class that "makes" the
/// [ParameterTypeInfo] of any given member parameter.
///
/// NB : All subclasses should have a default constructor/factory and which
/// tear-off should have the same type as [ParameterTypeInfoMakerConstructor].
///
abstract class ParameterTypeInfoMaker {
  ParameterTypeInfo call(Parameter parameter);
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/// This is a [ParameterTypeInfoMaker] for member parameters of ValueObjects and
/// SimpleEntities. These member parameters are "normal", meaning that they are
/// not collections of other modddels.
///
class NormalParameterTypeInfoMaker extends ParameterTypeInfoMaker {
  NormalParameterTypeInfoMaker({required ClassElement annotatedClass});

  @override
  NormalParameterTypeInfo call(Parameter parameter) {
    final paramType = parameter.type;
    return NormalParameterTypeInfo(
      nonNullable: TransformedType(all: utils.nonNullableType(paramType)),
      nullable: TransformedType(all: utils.nullableType(paramType)),
      valid: TransformedType(all: utils.validType(paramType)),
    );
  }
}

/// This is a [ParameterTypeInfoMaker] for member parameters of
/// IterableEntities.
///
class IterableParameterTypeInfoMaker extends ParameterTypeInfoMaker {
  IterableParameterTypeInfoMaker._({
    required this.typeTemplateExpression,
  });

  factory IterableParameterTypeInfoMaker({
    required ClassElement annotatedClass,
  }) {
    final resolver = IterablesTypeTemplateResolver.resolve(
      annotatedClass: annotatedClass,
      masksCount: 1,
    );
    return IterableParameterTypeInfoMaker._(
        typeTemplateExpression: resolver.typeTemplateExpression);
  }

  final TypeTemplateExpression typeTemplateExpression;

  @override
  IterableParameterTypeInfo call(Parameter parameter) {
    final typeTemplateMatch = typeTemplateExpression.match(parameter.type);

    if (typeTemplateMatch == null) {
      throw InvalidGenerationSourceError(
        'The type of the parameter doesn\'t match the TypeTemplate '
        '"${typeTemplateExpression.typeTemplate}".',
        element: parameter.parameterElement,
      );
    }
    return IterableParameterTypeInfo(
      nonNullable: TransformedType(
        all: typeTemplateMatch.replaceModddelType(1, utils.nonNullableType),
      ),
      nullable: TransformedType(
        all: typeTemplateMatch.replaceModddelType(1, utils.nullableType),
      ),
      valid: TransformedType(
        all: typeTemplateMatch.replaceModddelType(1, utils.validType),
      ),
      modddelType: typeTemplateMatch.getModddelType(1),
    );
  }
}

/// This is a [ParameterTypeInfoMaker] for member parameters of
/// Iterable2Entities.
///
class Iterable2ParameterTypeInfoMaker extends ParameterTypeInfoMaker {
  Iterable2ParameterTypeInfoMaker._({
    required this.typeTemplateExpression,
  });

  factory Iterable2ParameterTypeInfoMaker({
    required ClassElement annotatedClass,
  }) {
    final resolver = IterablesTypeTemplateResolver.resolve(
      annotatedClass: annotatedClass,
      masksCount: 2,
    );
    return Iterable2ParameterTypeInfoMaker._(
        typeTemplateExpression: resolver.typeTemplateExpression);
  }

  final TypeTemplateExpression typeTemplateExpression;

  @override
  Iterable2ParameterTypeInfo call(Parameter parameter) {
    final type = parameter.type;
    final typeTemplateMatch = typeTemplateExpression.match(type);

    if (typeTemplateMatch == null) {
      throw InvalidGenerationSourceError(
        'The type of the parameter doesn\'t match the TypeTemplate '
        '"${typeTemplateExpression.typeTemplate}".',
        element: parameter.parameterElement,
      );
    }

    TransformedTypeIter2 getTransformedType(
            String Function(String modddelType) replace) =>
        TransformedTypeIter2(
          all: typeTemplateMatch.replaceModddelTypes(
              (maskNb, modddelType) => replace(modddelType)),
          modddel1: typeTemplateMatch.replaceModddelType(1, replace),
          modddel2: typeTemplateMatch.replaceModddelType(2, replace),
        );

    return Iterable2ParameterTypeInfo(
      nonNullable: getTransformedType(utils.nonNullableType),
      nullable: getTransformedType(utils.nullableType),
      valid: getTransformedType(utils.validType),
      modddel1Type: typeTemplateMatch.getModddelType(1),
      modddel2Type: typeTemplateMatch.getModddelType(2),
    );
  }
}
