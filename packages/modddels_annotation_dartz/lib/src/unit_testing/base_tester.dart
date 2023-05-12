import 'package:modddels_annotation_dartz/src/modddels/base_modddel.dart';
import 'package:modddels_annotation_dartz/src/unit_testing/unit_testing_classes.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// This is the base class of Testers. A Tester is a generated class that allows
/// you to easily create tests for your modddel.
///
abstract class BaseTester<M extends BaseModddel<I, V>, I extends InvalidModddel,
    V extends ValidModddel> {
  const BaseTester({
    required this.maxTestInfoLength,
  });

  /// See [Modddel.maxTestInfoLength].
  ///
  /// NB : This takes priority over `maxTestInfoLength` set in the `@Modddel`
  /// annotation.
  ///
  final int maxTestInfoLength;

  /// Tests that the modddel, when instantiated with the given [ModddelParams],
  /// is valid.
  ///
  /// Example :
  ///
  /// ```dart
  /// const testAge = TestAge();
  ///
  /// testAge.isValid(const AgeParams(19));
  /// ```
  ///
  ValidTest<M, I, V> get isValid => ValidTest<M, I, V>(this);

  /// Tests that the modddel, when instantiated with the given [ModddelParams],
  /// holds the `sanitizedParams`.
  ///
  /// Example :
  ///
  /// ```dart
  /// // We test that the Name is trimmed before being stored inside the modddel.
  /// testAge.isSanitized(
  ///   const NameParams('  Dash '),
  ///   sanitizedParams: const NameParams('Dash'),
  /// );
  /// ```
  ///
  SanitizedTest<M, I, V> get isSanitized => SanitizedTest<M, I, V>(this);
}
