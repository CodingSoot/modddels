import 'package:modddels_annotation_internal/src/modddels/failures.dart';

const contentValidation = Validation(
  'content',
  FailureType<ContentFailure>(),
);

class Validation {
  const Validation(
    this.name,
    this.failureType,
  );

  /// The name of the validation.
  ///
  /// It must begin with a _lowercase_ letter, and it must be made of valid dart
  /// identifier characters (alphanumeric, underscore and dollar sign).
  ///
  final String name;

  /// The type of the failure of the validation.
  ///
  /// You can either provide it either :
  /// - As a typeArg (recommended) : `FailureType<UsernameSizeFailure>()`
  /// - As a string : `FailureType('UsernameSizeFailure')`. This takes
  ///   precedence over the typeArg.
  ///
  final FailureType failureType;
}

class FailureType<F extends Failure> {
  const FailureType([this.typeName]);

  /// Optional. If provided, will override the generic type.
  ///
  final String? typeName;
}

class ValidationStep {
  const ValidationStep(
    this.validations, {
    this.name,
  });

  /// The list of validations of this [ValidationStep]. The order doesn't
  /// matter.
  ///
  final List<Validation> validations;

  /// (Optional) The name of the validationStep.
  ///
  /// If provided, it must begin with an _uppercase_ letter, and it must be
  /// made of valid dart identifier characters (alphanumeric, underscore and
  /// dollar sign).
  ///
  final String? name;
}
