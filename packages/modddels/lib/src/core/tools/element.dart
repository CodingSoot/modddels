import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:modddels/src/core/tools/ast.dart';
import 'package:modddels/src/core/tools/imports.dart';
import 'package:modddels/src/core/tools/type_visitors/invalid_type_exception.dart';
import 'package:modddels/src/core/tools/type_visitors/type_visitor.dart';
import 'package:modddels/src/core/tools/type_visitors/type_visitor_base.dart';
import 'package:modddels/src/core/utils.dart';
import 'package:recursive_regex/recursive_regex.dart';
import 'package:source_gen/source_gen.dart';

/// If the [element] has a prefix (= import alias) in the [originLibrary],
/// then returns it.
///
/// Otherwise, returns null.
///
PrefixElement? getPrefix(LibraryElement originLibrary, Element element) {
  return originLibrary.prefixes.firstWhereOrNull(
    (prefix) {
      // We're getting all the library's imports that use the same prefix (=
      // alias)
      final importsWithPrefix = prefix.imports;

      // If one of the libraries of these imports is the library that exports
      // the [element] (immediately or transitively), we return it.
      return importsWithPrefix.any((import) {
        return import.importedLibrary!
            .hasExportWhere((library) => library.id == element.library?.id);
      });
    },
  );
}

/// Returns the documentation (= comments) of the given [element].
///
Future<String> documentationOf(
  Element element,
  BuildStep buildStep,
) async {
  final buffer = StringBuffer();

  final astNode = await tryGetAstNodeForElement(element, buildStep);

  // If `precedingComments` is null, we break from the loop
  for (Token? token = astNode.beginToken.precedingComments;
      token != null;
      token = token.next) {
    buffer.writeln(token);
  }

  return buffer.toString();
}

/// Returns the type of the [element] in the [originLibrary] (prefixes are added
/// when needed).
///
/// If [expandTypeAliases] is true, then all type aliases are expanded
/// (including aliased type args).
///
/// **How it works :**
///
/// 1. We use the [StringTypeVisitor] to visit the [DartType] of the element
///    with [StringTypeVisitor.invalidTypeThrows] set to true.
/// 2. If the resulting type is/contains an [InvalidType], it could be because
///    that type is not defined generation-time. So we re-visit the [DartType]
///    of the element with [StringTypeVisitor.invalidTypeThrows] set to false,
///    meaning the [InvalidType] is replaced with 'dynamic'.
///   - (a) If the type is/contains a type alias that must be expanded : We
///     can't possibly expand the type alias from the source code -> we throw an
///     error.
///   - (b) Or else : We try to extract the type directly from the source code
///     using [_extractTypeFromSource].
///   - (c) If the latter fails, we use the string of the type where the
///     [InvalidType] is replaced with 'dynamic'.
///
String parseTypeSource(
  LibraryElement originLibrary,
  VariableElement element, {
  required bool expandTypeAliases,
}) {
  // 1.
  try {
    final stringType = element.type
        .accept(StringTypeVisitor(
          originLibrary,
          invalidTypeThrows: true,
          expandTypeAliases: expandTypeAliases,
        ))
        .trim();

    return stringType;
  }
  // 2.
  // (a)
  on InvalidTypeException {
    final stringType = element.type
        .accept(StringTypeVisitor(
          originLibrary,
          invalidTypeThrows: false,
          expandTypeAliases: expandTypeAliases,
        ))
        .trim();

    if (expandTypeAliases) {
      if (_typeIsOrContainsTypeAlias(
        element: element,
        expandedStringType: stringType,
        originLibrary: originLibrary,
      )) {
        throw InvalidGenerationSourceError(
          'Could not expand the type alias. Make sure all type arguments are valid '
          'types that are available generation-time, or don\'t use a type alias.',
          element: element,
        );
      }
    }

    // (b)
    return _extractTypeFromSource(element) ??
        // (c)
        stringType;
  }
}

/// Whether the type of the [element] is or contains an alias. The
/// [expandedStringType] must be the result of using the [StringTypeVisitor]
/// with [StringTypeVisitor.expandTypeAliases] set to true and
/// [StringTypeVisitor.invalidTypeThrows] set to false.
///
/// 1. We check if the type itself is a type alias.
/// 2. Using the [StringTypeVisitor], we check if the [expandedStringType] is
///    different than the `unexpandedStringType`, in which case the type must be
///    containing a type alias.
/// 3. At this point, there is still one case where the type might still be /
///    contain a type alias. Due to the way the dart analyzer works, when a
///    typedef evaluates to [DynamicType] or [InvalidType], the `element.type`
///    looses all information about the alias(es) referencing that typedef, so
///    the two previous methods fail to detect them. For example :
///
///    ```dart
///    typedef MyType = Inexistant; // This class doesn't exist generation-time.
///
///    MyType param1;
///    List<MyType> param2;
///    ```
///
///    In this example, `MyType` evaluates to [InvalidType], so :
///    - For param1 : `param1Element.type` is considered an [InvalidType]. This
///      means that its alias is null, and thus using the [StringTypeVisitor]
///      (with [StringTypeVisitor.invalidTypeThrows] set to false) always
///      returns `dynamic` (no matter the value of
///      [StringTypeVisitor.expandTypeAliases]).
///    - For param2 : The type argument is considered an [InvalidType]. This
///      means that its alias is null, and thus using the [StringTypeVisitor]
///      (with [StringTypeVisitor.invalidTypeThrows] set to false) always
///      returns `List<dynamic>` (no matter the value of
///      [StringTypeVisitor.expandTypeAliases]).
///
///    The solution we implement is to extract the type from the source code,
///    get all the names of the types that compose it using
///    [_allTypeElementsNamesRegex], and then checking if [originLibrary] or the
///    library it imports declare any typedef with one of these names.
///
bool _typeIsOrContainsTypeAlias({
  required VariableElement element,
  required String expandedStringType,
  required LibraryElement originLibrary,
}) {
  // 1.
  if (element.type.isTypeAlias) {
    return true;
  }

  // 2.
  final unexpandedStringType = element.type
      .accept(StringTypeVisitor(
        originLibrary,
        expandTypeAliases: false,
        invalidTypeThrows: false,
      ))
      .trim();

  if (expandedStringType != unexpandedStringType) {
    return true;
  }

  // 3.
  final sourceType = _extractTypeFromSource(element);

  // If the type was omitted, or it's 'dynamic', it's not an alias and doesn't
  // contain an alias.
  //
  // TODO : This can be generalized to exclude any type that is a reserved
  // keyword : dynamic, bool, num...
  if (sourceType == null || isDynamicType(sourceType)) {
    return false;
  }

  final allTypeElementsNames = _allTypeElementsNamesRegex
      .allMatches(sourceType)
      .map((match) => match.group(0))
      .whereNotNull()
      .toList();

  final containsTypeAlias = originLibrary.hasImportWhere((library) =>
      library.topLevelElements.any((element) =>
          element is TypeAliasElement &&
          allTypeElementsNames.contains(element.name)));

  return containsTypeAlias;
}

/// Extracts the type of the [element] from the source code. Returns null if no
/// type was found (Ex : the type of the element was omitted).
///
/// ## How it works :
///
/// A. We extract all the source code of the file until the name of the element
///
/// B. We use the [_noGenericsTypeRegex] to extract the type of the element.
///    This regex will only match if the type of the element doesn't have
///    generics (Ex : `MyType?`). We make sure the 'required' keyword is not
///    counted as a type.
///
/// C. If the previous method didn't work, it may be because the type has
///    generics :
///    1. First we use the [_vagueGenericsTypeRegex] to capture a smaller part
///       of the source code that still contains the type of the element.
///    2. We then use the [_genericsTypeRegex] to match all types in that string
///       that have generics, and we take the last match.
///    3. We verify that this last match is just before the element name (i.e at
///       the end of the source code). If yes, then that's the element's type.
///
String? _extractTypeFromSource(VariableElement element) {
  if (element.nameOffset <= 0) {
    return null;
  }

  // A.
  final source = element.source!.contents.data.substring(0, element.nameOffset);

  // B.
  String? getNoGenericsType() {
    final match = _noGenericsTypeRegex.firstMatch(source);

    final prefix = match?.group(1);
    final type = match?.group(2);

    if (type == null || type == 'required') {
      return null;
    }

    return prefix != null ? '$prefix.$type' : type;
  }

  final noGenericsType = getNoGenericsType();

  if (noGenericsType != null) {
    return noGenericsType;
  }

  // C.
  String? getVagueGenericsType() {
    final match = _vagueGenericsTypeRegex.firstMatch(source);

    final prefix = match?.group(1);
    final type = match?.group(2);

    if (type == null) {
      return null;
    }
    return prefix != null ? '$prefix.$type' : type;
  }

  final vagueGenericsType = getVagueGenericsType();

  if (vagueGenericsType != null) {
    final genericsType =
        _genericsTypeRegex.lastMatch(vagueGenericsType)?.group(0);
    if (genericsType != null) {
      final verifyRegex = RegExp(RegExp.escape(genericsType) + r'\s+$');
      if (verifyRegex.hasMatch(source)) {
        return genericsType;
      }
    }
  }
  return null;
}

/// Matches all the names of the types that could be participating in a generic
/// type (or not), including base types and type arguments. The prefixes and the
/// nullability suffixes are ignored.
///
/// For example :
/// - In `MyType<A?, prefix.B<C>>`, this regex would match all of `MyType`, `A`,
///   `B` and `C`.
/// - In `prefix.MyType?`, this regex would match `MyType`.
///
/// NB : The negative lookahead is for ignoring prefixes.
///
final _allTypeElementsNamesRegex = RegExp(RegexUtils.typeName + r'(?!\s*\.)');

/// This regex matches a type that doesn't have generics (Ex : `int` or
/// `prefix.MyType?`), at the end of the given string.
///
/// ### Composition :
///
/// This regex is composed of the following elements :
///
/// 1. A negative lookbehind for ignoring annotations
/// 2. The non-capturing [RegexUtils.optionalPrefixGroup], which has a nested
///    capturing group for the prefix (= group 1).
/// 3. A capturing group for the type (= group 2), which is made of :
///    - [RegexUtils.typeName] : The name of the type
///    - The [RegexUtils.optionalNullabilitySuffix].
/// 4. A mandatory trailing space, which separates the type from the parameter
///    name.
///
final _noGenericsTypeRegex = RegExp(r'(?<!@)' +
    RegexUtils.optionalPrefixGroup +
    RegexUtils.group(
        RegexUtils.typeName + RegexUtils.optionalNullabilitySuffix) +
    r'\s+$');

/// This regex vaguely matches a type that has generics (Ex : `Map<String,
/// List<int>>`), at the end of the given string.
///
/// Note that this regex is not precise, and can match more than one type : For
/// example, if we have a param 'p2' and the source is :
/// ```dart
/// // ...
/// factory UserName(List<String> p1, List<int> //p2) (the param name is not included in the source)
/// ```
/// Then the matched string is : `List<String> p1, List<int>`
///
/// ### Composition :
///
/// This regex is composed of the following elements :
///
/// 1. A negative lookbehind for ignoring annotations
/// 2. The non-capturing [RegexUtils.optionalPrefixGroup], which has a nested
///    capturing group for the prefix (= group 1).
/// 3. A capturing group for the type (= group 2), which is made of :
///    - [RegexUtils.typeName] : The name of the type
///    - The generics part delimited by "<" and ">". This part is crucial :
///       - All characters except ";" are matched. We could exclude other
///         symbols, but for the sake of compatibility with future versions of
///         dart, we only exclude semicolons which can't and will probably never
///         be part of a type's generics.
///       - We use negative lookaheads for excluding the "factory" and "class"
///         keywords.
///       - We use the greedy quantifier `+` (not lazy because there can be
///         nested generics)
///    - The [RegexUtils.optionalNullabilitySuffix].
/// 4. A mandatory trailing space, which separates the type from the parameter
///    name.
///
final _vagueGenericsTypeRegex = RegExp(
  r'(?<!@)' +
      RegexUtils.optionalPrefixGroup +
      RegexUtils.group(RegexUtils.typeName +
          r'<(?:(?!\bfactory\b|\bclass\b)[^;])+>' +
          RegexUtils.optionalNullabilitySuffix) +
      r'\s+$',
);

/// This regex matches all types that have generics in the given String.
///
/// Contrary to [_vagueGenericsTypeRegex], this recursive regex is precise and
/// correctly captures types with nested generics. However, It is more expensive
/// so it must be used on short strings, only when needed.
///
/// Example : If the String is `List<String> p1, List<int>`, then the matches
/// are `List<String>` and `List<int>`.
///
final _genericsTypeRegex = RecursiveRegex(
  startDelimiter: RegExp(r'<'),
  endDelimiter: RegExp(r'>'),
  prepended:
      RegExp(RegexUtils.optionalPrefixGroup + RegexUtils.typeName + r'\s*'),
  appended: RegExp(RegexUtils.optionalNullabilitySuffix),
);
