import 'package:dartz/dartz.dart';

extension EitherCompat<L, R> on Either<L, R> {
  /// Extracts the value from [Left] in a [Option].
  ///
  /// If the [Either] is [Right], returns [None].
  ///
  Option<L> getLeft() => fold(
        (l) => some(l),
        (r) => none(),
      );
}
