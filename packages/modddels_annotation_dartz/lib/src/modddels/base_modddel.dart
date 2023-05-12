import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// This is the base class of all modddels.
///
@immutable
abstract class BaseModddel<I extends InvalidModddel, V extends ValidModddel>
    extends Equatable {
  const BaseModddel();

  /// Whether this modddel is valid or not.
  ///
  bool get isValid => mapValidity(
        valid: (valid) => true,
        invalid: (invalid) => false,
      );

  /// Executes [valid] when this modddel is valid, otherwise executes [invalid].
  ///
  TResult mapValidity<TResult extends Object?>({
    required TResult Function(V valid) valid,
    required TResult Function(I invalid) invalid,
  });

  /// Converts this modddel to an [Either] where left is the invalid union-case,
  /// and right is the valid union-case.
  ///
  Either<I, V> get toEither => mapValidity(
        valid: (valid) => right(valid),
        invalid: (invalid) => left(invalid),
      );

  /// Converts this modddel to an [Either] where left is the [Failure] of the
  /// invalid union-case, and right is the valid union-case.
  ///
  Either<List<Failure>, V> get toBroadEither => mapValidity(
        valid: (valid) => right(valid),
        invalid: (invalid) => left(invalid.failures),
      );
}
