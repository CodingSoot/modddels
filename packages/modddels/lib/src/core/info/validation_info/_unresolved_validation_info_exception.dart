import 'package:modddels/src/core/parsed_annotations/parsed_validation.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';

/// Thrown if the validation info of a modddel or an annotated super-sealed
/// class can't be resolved.
///
class UnresolvedValidationException implements Exception {
  UnresolvedValidationException(
    this.message, {
    this.failedValidationStep,
    this.failedValidation,
  });

  final String message;

  /// The validationStep that caused the exception, if any.
  ///
  final ParsedValidationStep? failedValidationStep;

  /// The validation that caused the exception, if any.
  ///
  final ParsedValidation? failedValidation;

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('UnresolvedValidationException: $message');

    if (failedValidationStep != null) {
      buffer.writeln(
          'Failed ValidationStep : "${failedValidationStep!.name ?? 'Unnamed'}"');
    }

    if (failedValidation != null) {
      buffer
          .writeln('Failed Validation : "${failedValidation!.validationName}"');
    }

    return buffer.toString();
  }
}
