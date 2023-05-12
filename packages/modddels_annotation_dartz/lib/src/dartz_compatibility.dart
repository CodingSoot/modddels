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

extension Tuple2Compat<T1, T2> on Tuple2<T1, T2> {
  /// Same as [value1].
  ///
  T1 get first => value1;

  /// Same as [value2].
  ///
  T2 get second => value2;
}
