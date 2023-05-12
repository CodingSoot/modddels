import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:checks/checks.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';

/* -------------------------------------------------------------------------- */
/*                          Common TestHelper Mixins                          */
/* -------------------------------------------------------------------------- */

mixin TestHelperMixin<P extends SampleParamsBase, O extends SampleOptionsBase>
    on TestHelperBase<P, O> {
  /// Checks that the [failureType] has a type that equals the given
  /// [expectedFailureType] + the nullability suffix if [isNullable] is true.
  ///
  /// Note that [expectedFailureType] shouldn't include the nullability suffix.
  ///
  void _checkFailureFieldType({
    required DartType failureType,
    required String expectedFailureType,
    required bool isNullable,
  }) {
    // NB : TypeChecker doesn't seem to work with build_test for types other
    // than the core ones, so we're checking the type this way.
    check(failureType.getDisplayString(withNullability: false))
        .equals(expectedFailureType);

    check(failureType.nullabilitySuffix).equals(
        isNullable ? NullabilitySuffix.question : NullabilitySuffix.none);
  }

  /// Checks that the [failureProperty] is not null and has a type that equals
  /// the given [expectedFailureType] + the nullability suffix if [isNullable]
  /// is true.
  ///
  /// Note that [expectedFailureType] shouldn't include the nullability suffix.
  ///
  void checkFailureFieldProperty(
    FieldElement? failureProperty, {
    required String expectedFailureType,
    required bool isNullable,
  }) {
    check(failureProperty).isNotNull();
    _checkFailureFieldType(
      failureType: failureProperty!.type,
      expectedFailureType: expectedFailureType,
      isNullable: isNullable,
    );
  }

  /// Checks that the [failureGetter] is not null and has a type that equals the
  /// given [expectedFailureType] + the nullability suffix if [isNullable] is
  /// true.
  ///
  /// Note that [expectedFailureType] shouldn't include the nullability suffix.
  ///
  void checkFailureFieldGetter(
    PropertyAccessorElement? failureGetter, {
    required String expectedFailureType,
    required bool isNullable,
  }) {
    check(failureGetter).isNotNull();
    _checkFailureFieldType(
      failureType: failureGetter!.returnType,
      expectedFailureType: expectedFailureType,
      isNullable: isNullable,
    );
  }

  /// Checks that the [hasFailureGetter] is not null and has a boolean return
  /// type.
  ///
  void checkHasFailureGetter(PropertyAccessorElement? hasFailureGetter) {
    check(hasFailureGetter).isNotNull();
    check(hasFailureGetter!.returnType.isDartCoreBool).isTrue();
  }

  /// Checks that the [failuresGetterResult], which is the result of calling the
  /// `failures` getter, is of the correct type and holds the
  /// [expectedFailures].
  ///
  void checkFailuresGetterResult(
      List<Failure> failuresGetterResult, List<Failure> expectedFailures) {
    testSubject.map(
        valueObject: (_) => check(failuresGetterResult)
            .isA<List<ValueFailure>>()
            .deepEquals(expectedFailures),
        entity: (_) => check(failuresGetterResult)
            .isA<List<EntityFailure>>()
            .deepEquals(expectedFailures));
  }

  /// Checks the [toBroadEither] object, which is of type `Either<List<Failure>,
  /// V>`, where :
  ///
  /// - [V] is the type of the Right side of the Either.
  /// - [R] is the type of the value actually held in the Right side.
  ///
  /// Depending on the [isModddelValid] flag, it checks whether the
  /// [toBroadEither] object is an instance of `Right<List<Failure>, V>` with
  /// the Right value being of type [R], or an instance of `Left<List<Failure>,
  /// V>` with the Left value holding [expectedFailures].
  ///
  void _checkToBroadEither<V extends ValidModddel, R extends V>(
    Either<List<Failure>, V> toBroadEither, {
    required bool isModddelValid,
    required List<Failure>? expectedFailures,
  }) {
    if (isModddelValid != (expectedFailures == null)) {
      throw ArgumentError(
          'expectedFailures should be provided if the modddel is invalid, and '
          "should be null if it's valid");
    }
    isModddelValid
        ? check(toBroadEither)
            .isA<Right<List<Failure>, V>>()
            .has((right) => right.value, 'right value')
            .isA<R>()
        : check(toBroadEither)
            .isA<Left<List<Failure>, V>>()
            .has((left) => left.value, 'left value')
            .deepEquals(expectedFailures!);
  }
}

mixin SoloTestHelperMixin<P extends SampleParamsBase,
        O extends SampleOptionsBase>
    on TestHelperMixin<P, O>, ElementsSoloTestHelperMixin<P, O> {
  /// Checks the [baseModddelEither] and [soloModddelEither] objects using
  /// [_checkToBroadEither], ensuring they have the correct types and hold the
  /// correct value based on the [isModddelValid] flag and the
  /// [expectedFailures].
  ///
  /// [baseModddelEither] is the result of calling `toBroadEither` on the
  /// [BaseModddel] level. [soloModddelEither] is the result of calling
  /// `toBroadEither` on the modddel.
  ///
  void checkToBroadEitherGettersResults<MV extends ValidModddel>(
    Either<List<Failure>, ValidModddel> baseModddelEither,
    Either<List<Failure>, MV> soloModddelEither, {
    required bool isModddelValid,
    required List<Failure>? expectedFailures,
  }) {
    _checkToBroadEither<ValidModddel, MV>(
      baseModddelEither,
      isModddelValid: isModddelValid,
      expectedFailures: expectedFailures,
    );
    _checkToBroadEither<MV, MV>(
      soloModddelEither,
      isModddelValid: isModddelValid,
      expectedFailures: expectedFailures,
    );
  }

  /// Checks that calling the `toBroadEither` getter on all possible levels
  /// ([BaseModddel] and the solo modddel) returns the expected values  based on
  /// the [isModddelValid] flag and the [expectedFailures].
  ///
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  });
}

mixin SSealedTestHelperMixin<P extends SampleParamsBase,
        O extends SSealedSampleOptionsMixin>
    on TestHelperMixin<P, O>, ElementsSSealedTestHelperMixin<P, O> {
  @override
  String get caseModddelName {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return 'First$sSealedName';
      case FactoryConstructor.second:
        return 'Second$sSealedName';
    }
  }

  /// Checks the [baseModddelEither], [sSealedModddelEither] and
  /// [caseModddelEither] objects using [_checkToBroadEither], ensuring they
  /// have the correct types and hold the correct value based on the
  /// [isModddelValid] flag and the [expectedFailures].
  ///
  /// [baseModddelEither] is the result of calling `toBroadEither` on the
  /// [BaseModddel] level. [sSealedModddelEither] is the result of calling
  /// `toBroadEither` on the ssealed modddel. [caseModddelEither] is the result
  /// of calling `toBroadEither` on the case-modddel.
  ///
  void checkToBroadEitherGettersResults<SV extends ValidModddel, CV extends SV>(
    Either<List<Failure>, ValidModddel> baseModddelEither,
    Either<List<Failure>, SV> sSealedModddelEither,
    Either<List<Failure>, CV> caseModddelEither, {
    required bool isModddelValid,
    required List<Failure>? expectedFailures,
  }) {
    _checkToBroadEither<ValidModddel, CV>(
      baseModddelEither,
      isModddelValid: isModddelValid,
      expectedFailures: expectedFailures,
    );
    _checkToBroadEither<SV, CV>(
      sSealedModddelEither,
      isModddelValid: isModddelValid,
      expectedFailures: expectedFailures,
    );
    _checkToBroadEither<CV, CV>(
      caseModddelEither,
      isModddelValid: isModddelValid,
      expectedFailures: expectedFailures,
    );
  }

  /// Checks that calling the `toBroadEither` getter on all possible levels
  /// ([BaseModddel], ssealed modddel and case-modddel) returns the expected
  /// values based on the [isModddelValid] flag and the [expectedFailures].
  ///
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  });
}

/* -------------------------------------------------------------------------- */
/*                         Common SampleOptions Mixins                        */
/* -------------------------------------------------------------------------- */

mixin SSealedSampleOptionsMixin on SampleOptionsBase {
  FactoryConstructor get usedFactoryConstructor;
}
