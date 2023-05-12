import 'package:modddels/src/core/info/parameter_type_info/_type_template_expression.dart';

/// This error is thrown by the [TypeTemplateExpression] if a type template
/// string is invalid.
///
class TypeTemplateSyntaxError extends Error {
  TypeTemplateSyntaxError(
    this.message, {
    required this.typeTemplate,
  });

  final String message;

  /// The type template string that caused the error.
  ///
  final String typeTemplate;

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('TypeTemplateSyntaxError: $message');

    buffer.writeln('Invalid TypeTemplate : "$typeTemplate"');

    return buffer.toString();
  }
}
