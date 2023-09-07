import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:modddels/src/core/tools/type_visitors/invalid_type_exception.dart';
import 'package:modddels/src/core/tools/type_visitors/type_visitor_base.dart';
import 'package:modddels/src/core/utils.dart';

/// This visitor is used to visit a type and make a String that best approaches
/// its declaration code.
///
/// It differs from using [DartType.getDisplayString] which should be used
/// exclusively for "presenting" a type for the user (for example in an error
/// message).
///
/// If [invalidTypeThrows] is true, throws an [InvalidTypeException] if an
/// [InvalidType] is encountered. Otherwise, the [InvalidType] is considered as
/// a [DynamicType].
///
class StringTypeVisitor extends BaseStringTypeVisitor {
  StringTypeVisitor(
    this.originLibrary, {
    required this.invalidTypeThrows,
    required this.expandTypeAliases,
  });

  @override
  final LibraryElement originLibrary;

  @override
  final bool invalidTypeThrows;

  /// If true, this visitor will expanded all type aliases to the type they
  /// represent.
  ///
  final bool expandTypeAliases;

  @override
  StringTypeVisitor newInstance() => StringTypeVisitor(
        originLibrary,
        invalidTypeThrows: invalidTypeThrows,
        expandTypeAliases: expandTypeAliases,
      );

  @override
  String visitInvalidType(InvalidType type) {
    if (type.isTypeAlias) {
      return visitTypeAlias(type);
    }
    return super.visitInvalidType(type);
  }

  @override
  String visitDynamicType(DynamicType type) {
    if (type.isTypeAlias) {
      return visitTypeAlias(type);
    }
    return super.visitDynamicType(type);
  }

  @override
  String visitFunctionType(FunctionType type) {
    if (type.isTypeAlias) {
      return visitTypeAlias(type);
    }
    return super.visitFunctionType(type);
  }

  @override
  String visitInterfaceType(InterfaceType type) {
    if (type.isTypeAlias) {
      return visitTypeAlias(type);
    }
    return super.visitInterfaceType(type);
  }

  @override
  String visitNeverType(NeverType type) {
    if (type.isTypeAlias) {
      return visitTypeAlias(type);
    }
    return super.visitNeverType(type);
  }

  @override
  String visitTypeParameterType(TypeParameterType type) {
    if (type.isTypeAlias) {
      return visitTypeAlias(type);
    }
    return super.visitTypeParameterType(type);
  }

  @override
  String visitVoidType(VoidType type) {
    if (type.isTypeAlias) {
      return visitTypeAlias(type);
    }
    return super.visitVoidType(type);
  }

  @override
  String visitRecordType(RecordType type) {
    // TODO: implement Record types
    throw UnimplementedError('Record types are not implemented yet');
  }

  String visitTypeAlias(DartType type) {
    assert(type.isTypeAlias);

    final alias = type.alias!;

    if (expandTypeAliases) {
      // Ex : The visited type alias is `MyType<String>`
      // - The `alias.element` is `typedef MyType<T> = Map<T, List<T?>`
      // - The `alias.element.aliasedType` is `Map<T, List<T?>`
      //
      // => In order to expand the type alias, we should take the aliasedType,
      // and replace its type parameters with the alias's type argument(s). For
      // that, we use the [ReplaceTypeParametersVisitor].
      final aliasedType = alias.element.aliasedType;
      var result = aliasedType.accept(ReplaceTypeParametersVisitor(
          originLibrary,
          invalidTypeThrows: invalidTypeThrows,
          expandTypeAliases: expandTypeAliases,
          typeArgumentsReplacement: Map.fromIterables(
              alias.element.typeParameters, alias.typeArguments)));

      // If the type alias is nullable (Ex : `MyType<String>?`), and the
      // expanded type is not, we add the '?'.
      if (!isNullableType(result) &&
          type.nullabilitySuffix == NullabilitySuffix.question) {
        result += '?';
      }
      return result;
    }

    final buffer = DartTypeStringBuilder(originLibrary, newInstance);

    buffer.writePrefix(alias.element);
    buffer.write(alias.element.name);
    buffer.writeTypeArguments(alias.typeArguments);
    buffer.writeNullability(type.nullabilitySuffix);

    return buffer.toString();
  }
}

/// Similar to [StringTypeVisitor], this visitor is used to visit a type and
/// make a String that best approaches its declaration code. In addition to
/// that, it replaces all the type parameters it encounters with the provided
/// [typeArgumentsReplacement].
///
/// Example : Consider the type : `Map<T?, List<S>>` where `T` and `S` are type
/// parameters.
///
/// If the [typeArgumentsReplacement] equals `{T : int, S : String}`, then the
/// result would be : `Map<int?, List<String>>`
///
/// If [invalidTypeThrows] is true, throws an [InvalidTypeException] if an
/// [InvalidType] is encountered. Otherwise, the [InvalidType] is considered as
/// a [DynamicType].
///
class ReplaceTypeParametersVisitor extends BaseStringTypeVisitor {
  ReplaceTypeParametersVisitor(
    this.originLibrary, {
    required this.typeArgumentsReplacement,
    required this.invalidTypeThrows,
    required this.expandTypeAliases,
  });

  @override
  final LibraryElement originLibrary;

  @override
  final bool invalidTypeThrows;

  /// If true, this visitor will expanded all type aliases to the type they
  /// represent.
  ///
  final bool expandTypeAliases;

  /// The map of type parameters (the keys) we want to replace with type
  /// arguments (the values).
  ///
  final Map<TypeParameterElement, DartType> typeArgumentsReplacement;

  @override
  ReplaceTypeParametersVisitor newInstance() => ReplaceTypeParametersVisitor(
        originLibrary,
        typeArgumentsReplacement: typeArgumentsReplacement,
        invalidTypeThrows: invalidTypeThrows,
        expandTypeAliases: expandTypeAliases,
      );

  @override
  String visitTypeParameterType(TypeParameterType type) {
    final replacement = typeArgumentsReplacement[type.element];

    if (replacement != null) {
      var result = replacement.accept(StringTypeVisitor(originLibrary,
          invalidTypeThrows: invalidTypeThrows, expandTypeAliases: true));

      // If the type parameter is nullable, and the replacement is not, we add
      // the '?'.
      // Ex : For the type `List<T?>` where `T?` is the visited type parameter,
      // if the replacement is `String`, we add the '?' so that the resulting
      // type is List<String?>
      if (replacement.nullabilitySuffix != NullabilitySuffix.question &&
          type.nullabilitySuffix == NullabilitySuffix.question) {
        result += '?';
      }
      return result;
    }

    return super.visitTypeParameterType(type);
  }
}
