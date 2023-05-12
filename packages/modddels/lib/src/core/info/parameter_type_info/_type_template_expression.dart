import 'package:modddels/src/core/info/parameter_type_info/_type_template_syntax_error.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:modddels/src/core/utils.dart';

/// Matches a mask. Ex : '#1', '#2'...
///
final _maskRegex = RegExp(r'#(\d+)');

/// Matches a wildcard. Ex : '@1', '@2'...
///
final _wildcardRegex = RegExp(r'@(\d+)');

/// Matches a simple type argument. Ex : 'String', 'prefix.MyType?'.
///
final _typeArgRegex = RegExp(r'\s*' +
    RegexUtils.optionalPrefixGroup +
    RegexUtils.typeName +
    RegexUtils.optionalNullabilitySuffix +
    r'\s*');

/// Translates a TypeTemplate string into an internal representation that
/// can be executed and matched against a string representing a type.
///
class TypeTemplateExpression {
  TypeTemplateExpression._(
    this._typeTemplateExpressionRegex, {
    required this.typeTemplate,
    required this.normalizedTypeTemplate,
    required this.masksCount,
    required this.wildcardsCount,
  });

  /// Constructs a TypeTemplate expression.
  ///
  /// Throws a [TypeTemplateSyntaxError] if the [typeTemplate] is invalid.
  factory TypeTemplateExpression(String typeTemplate) {
    _assertValidPlaceholders(typeTemplate);

    final normalizedTypeTemplate =
        typeTemplate.replaceAllIndexed('*', (i, match) => '@$i');

    _assertSeparatedPlaceholders(
        typeTemplate: typeTemplate, normalizedTemplate: normalizedTypeTemplate);

    final typeTemplateRegex = _makeTypeTemplateRegex(normalizedTypeTemplate);

    final masksCount = _maskRegex.allMatches(typeTemplate).length;
    final wildcardsCount =
        _wildcardRegex.allMatches(normalizedTypeTemplate).length;

    return TypeTemplateExpression._(
      typeTemplateRegex,
      typeTemplate: typeTemplate,
      normalizedTypeTemplate: normalizedTypeTemplate,
      masksCount: masksCount,
      wildcardsCount: wildcardsCount,
    );
  }

  /// The [TypeTemplate] string.
  ///
  /// Examples : "Map<*,#1>" - "KtMap<#2,#1>" - "List<#1>"
  ///
  final String typeTemplate;

  /// The "Normalized" TypeTemplate is the TypeTemplate where the wildcards
  /// are replaced with numbered '@' characters (Starting with 0).
  ///
  /// Example : If [typeTemplate] is "Map<*,Map<#1,*>>", this will be
  /// "Map<@0,Map<#1,@1>>"
  ///
  final String normalizedTypeTemplate;

  /// The number of masks in the [typeTemplate].
  ///
  final int masksCount;

  /// The number of wildcards in the [typeTemplate].
  ///
  final int wildcardsCount;

  /// This regex is used internally to match a type and retrieve from it the
  /// type arguments matching the wildcards and masks.
  ///
  /// It has two kinds of named capture groups :
  ///
  /// - **Wildcard groups :** These are capture groups for wildcards. Their name
  ///   is composed of the letter 'a' followed by the number of the wildcard
  ///   (starting with 0). Example : `?<a0>` , `?<a1>` ...
  /// - **Masks groups :** These are capture groupes for masks. Their name is
  ///   composed of the letter 'b' followed by the maskNb (starting with 1).
  ///   Example : `?<b1>`, `?<b2>` ...
  ///
  final RegExp _typeTemplateExpressionRegex;

  /// Matches the [type] against the [typeTemplate].
  ///
  /// Returns null if the [type] doesn't match the TypeTemplate
  ///
  TypeTemplateMatch? match(String type) {
    return TypeTemplateMatch._create(expression: this, type: type);
  }

  static RegExp _makeTypeTemplateRegex(String normalizedTemplate) {
    final regexString = RegExp.escape(normalizedTemplate)
        .replaceAllMapped(_wildcardRegex,
            (match) => '(?<a${match.group(1)!}>${_typeArgRegex.pattern})')
        .replaceAllMapped(_maskRegex,
            (match) => '(?<b${match.group(1)!}>${_typeArgRegex.pattern})');

    return RegExp('^$regexString\$');
  }

  static void _assertValidPlaceholders(String typeTemplate) {
    final invalidMaskRegex = RegExp(r'#(?!\d+)');

    if (invalidMaskRegex.hasMatch(typeTemplate)) {
      throw TypeTemplateSyntaxError(
          'The "#" character is reserved for masks, and must be followed by a number.',
          typeTemplate: typeTemplate);
    }

    final invalidWildcardRegex = RegExp(r'\*(?=\d+)');

    if (invalidWildcardRegex.hasMatch(typeTemplate)) {
      throw TypeTemplateSyntaxError(
          'The "*" character is reserved for wildcards, and should not be followed by a number.',
          typeTemplate: typeTemplate);
    }

    if (typeTemplate.contains('@')) {
      throw TypeTemplateSyntaxError(
          'The "@" character is reserved and should not be used.',
          typeTemplate: typeTemplate);
    }

    final masks = _maskRegex.allMatches(typeTemplate).map((m) => m[1]!).toList()
      ..sort();

    for (var i = 0; i < masks.length; i++) {
      final maskNb = int.parse(masks[i]);
      if (maskNb != i + 1) {
        throw TypeTemplateSyntaxError(
            'The masks should be numbered from 1 to N.',
            typeTemplate: typeTemplate);
      }
    }
  }

  static void _assertSeparatedPlaceholders({
    required String normalizedTemplate,
    required String typeTemplate,
  }) {
    final result = normalizedTemplate
        .replaceAll(_maskRegex, '#')
        .replaceAll(_wildcardRegex, '#');

    final regExp = RegExp(r'#[^<>,]*#');

    if (regExp.hasMatch(result)) {
      throw TypeTemplateSyntaxError(
          'The masks and wildcards in the TypeTemplate must be separated by '
          'a sequence of characters that includes "<", ">" or ",".',
          typeTemplate: typeTemplate);
    }
  }
}

/// A TypeTemplate expression match.
///
/// It has the ability to retrieve and replace the modddel type for any mask
/// number.
///
/// Example :
///
/// ```dart
/// final typeTemplateExpression = TypeTemplateExpression('Map<*,#1>');
///
/// final type = 'Map<String, User>';
///
/// final typeTemplateMatch = typeTemplateExpression.match(type)!;
///
/// final modddelType = typeTemplateMatch.getModddelType(1); // User
/// final replaced = typeTemplateMatch.replaceModddelType(
///     1, (modddelType) => '${modddelType}name'); // Map<String,Username>
/// ```
///
class TypeTemplateMatch {
  TypeTemplateMatch._(
    this._expression,
    this._match, {
    required this.type,
  });

  static TypeTemplateMatch? _create({
    required TypeTemplateExpression expression,
    required String type,
  }) {
    final matches = expression._typeTemplateExpressionRegex.allMatches(type);
    if (matches.length != 1) {
      return null;
    }
    final match = matches.single;

    return TypeTemplateMatch._(
      expression,
      match,
      type: type,
    );
  }

  final TypeTemplateExpression _expression;

  final RegExpMatch _match;

  final String type;

  /// Returns the modddel type that matches the [maskNb].
  ///
  /// The [maskNb] must be the number of a mask in the TypeTemplate expression
  /// creating this match.
  ///
  String getModddelType(int maskNb) {
    try {
      final modddelType = _match.namedGroup('b$maskNb')!.trim();
      return modddelType;
    } on ArgumentError {
      throw ArgumentError.value(maskNb, 'maskNb', 'Not an existing maskNb.');
    }
  }

  /// Allows you to replace the modddel type that matches [maskNb] using the
  /// [replace] callback.
  ///
  String replaceModddelType(
      int maskNb, String Function(String modddelType) replace) {
    try {
      return replaceModddelTypes((maskNb2, modddelType) =>
          maskNb2 == maskNb ? replace(modddelType) : modddelType);
    } on ArgumentError {
      throw ArgumentError.value(maskNb, 'maskNb', 'Not an existing maskNb.');
    }
  }

  /// Allows you to replace all modddel types using the [replace] callback.
  ///
  String replaceModddelTypes(
      String Function(int maskNb, String modddelType) replace) {
    // We first replace the wildcards with the matching type arguments
    // from the matched type.
    final typeTemplateWithoutWildcards = _expression.normalizedTypeTemplate
        .replaceAllIndexed(_wildcardRegex, (i, m) => _match.namedGroup('a$i')!);

    // We then replace the masks with the matching type arguments from the
    // matched type.
    return typeTemplateWithoutWildcards.replaceAllMapped(_maskRegex, (m) {
      final maskNb = int.parse(m[1]!);
      final modddelType = _match.namedGroup('b$maskNb')!.trim();
      return replace(maskNb, modddelType);
    });
  }
}
