import 'package:modddels/src/core/templates/parameters/parameter.dart';

/// Thrown if the parameters info of a modddel or an annotated super-sealed
/// class can't be resolved.
///
class UnresolvedParametersInfoException implements Exception {
  UnresolvedParametersInfoException(
    this.message, {
    this.failedParameter,
  });

  final String message;

  /// The parameter that caused the exception, if any.
  ///
  final Parameter? failedParameter;

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('UnresolvedParametersException: $message');

    if (failedParameter != null) {
      buffer.writeln('Failed Parameter : "${failedParameter!.name}"');
    }

    return buffer.toString();
  }
}
