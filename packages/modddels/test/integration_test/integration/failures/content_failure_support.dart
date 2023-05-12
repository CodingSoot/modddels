// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';
import 'common_support.dart';
import 'content_failure.dart';

// Entities groups :
//
// - A. Solo entities with :
//   - A1 : A contentValidationStep that has one validation
//   - A2 : A contentValidationStep that has two validations
// - B. SSealed entities with :
//   - B1 : A contentValidationStep that has one validation
//   - B2 : A contentValidationStep that has two validations
//

/* -------------------------------------------------------------------------- */
/*                   TestSupports and Helpers for each group                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

class OneValidationSoloTestSupport extends EntitiesTestSupport<
    OneValidationSoloTestHelper,
    SampleParams,
    OneValidationSoloSampleOptions,
    OneValidationSoloSE,
    OneValidationSoloIE,
    OneValidationSoloI2E> {
  OneValidationSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, SampleParams sampleParams) =>
      OneValidationSoloTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  OneValidationSoloSE makeSimpleEntity(
          SampleParams params, OneValidationSoloSampleOptions sampleOptions) =>
      OneValidationSoloSE(
        param1: params.param1.value,
        param2: params.param2.value,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
      );

  @override
  OneValidationSoloIE makeIterableEntity(
          SampleParams params, OneValidationSoloSampleOptions sampleOptions) =>
      OneValidationSoloIE(
        params: [
          params.param1.value,
          params.param2.value,
        ],
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
      );

  @override
  OneValidationSoloI2E makeIterable2Entity(
          SampleParams params, OneValidationSoloSampleOptions sampleOptions) =>
      OneValidationSoloI2E(
        params: {
          params.param1.value: params.param2.value,
        },
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
      );
}

class OneValidationSoloTestHelper extends EntityTestHelper<
        SampleParams,
        OneValidationSoloSampleOptions,
        OneValidationSoloSE,
        OneValidationSoloIE,
        OneValidationSoloI2E>
    with
        TestHelperMixin,
        ElementsSoloTestHelperMixin,
        SoloTestHelperMixin,
        ContentFailureTestHelperMixin {
  OneValidationSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName => entityTestSubject.map(
        simpleEntity: (_) => 'OneValidationSoloSE',
        iterableEntity: (_) => 'OneValidationSoloIE',
        iterable2Entity: (_) => 'OneValidationSoloI2E',
      );

  @override
  List<String> get vStepsNames => ['Mid', 'Late'];

  /// Returns a list of the failure fields after accessing them from an
  /// invalid-step union-case (which varies depending on the failed
  /// validationStep of the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure?> getFailureFieldsFromInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => [invalidMid.contentFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => [invalidMid.contentFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => [invalidMid.contentFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
    );
  }

  /// Returns the result of calling the `failures` getter from the abstract
  /// invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromAbstractInvalidUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterableEntity: (iterableEntity) => iterableEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
    );
  }

  /// Returns the result of calling the `failures` getter from an invalid-step
  /// union-case (which varies depending on the failed validationStep of the
  /// [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
    );
  }

  @override
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    entityTestSubject.when(
      simpleEntity: (modddel) =>
          checkToBroadEitherGettersResults<ValidOneValidationSoloSE>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      iterableEntity: (modddel) =>
          checkToBroadEitherGettersResults<ValidOneValidationSoloIE>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      iterable2Entity: (modddel) =>
          checkToBroadEitherGettersResults<ValidOneValidationSoloI2E>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
    );
  }
}

class OneValidationSoloSampleOptions extends SampleOptionsBase {
  OneValidationSoloSampleOptions(
    super.name, {
    required this.sizeValidationPasses,
  });

  final bool sizeValidationPasses;
}

/* ----------------------------------- A2 ----------------------------------- */

class MultipleValidationsSoloTestSupport extends EntitiesTestSupport<
    MultipleValidationsSoloTestHelper,
    SampleParams,
    MultipleValidationsSoloSampleOptions,
    MultipleValidationsSoloSE,
    MultipleValidationsSoloIE,
    MultipleValidationsSoloI2E> {
  MultipleValidationsSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, SampleParams sampleParams) =>
      MultipleValidationsSoloTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  MultipleValidationsSoloSE makeSimpleEntity(SampleParams params,
          MultipleValidationsSoloSampleOptions sampleOptions) =>
      MultipleValidationsSoloSE(
        param1: params.param1.value,
        param2: params.param2.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
      );

  @override
  MultipleValidationsSoloIE makeIterableEntity(SampleParams params,
          MultipleValidationsSoloSampleOptions sampleOptions) =>
      MultipleValidationsSoloIE(
        params: [
          params.param1.value,
          params.param2.value,
        ],
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
      );

  @override
  MultipleValidationsSoloI2E makeIterable2Entity(SampleParams params,
          MultipleValidationsSoloSampleOptions sampleOptions) =>
      MultipleValidationsSoloI2E(
        params: {
          params.param1.value: params.param2.value,
        },
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
      );
}

class MultipleValidationsSoloTestHelper extends EntityTestHelper<
        SampleParams,
        MultipleValidationsSoloSampleOptions,
        MultipleValidationsSoloSE,
        MultipleValidationsSoloIE,
        MultipleValidationsSoloI2E>
    with
        TestHelperMixin,
        ElementsSoloTestHelperMixin,
        SoloTestHelperMixin,
        ContentFailureTestHelperMixin {
  MultipleValidationsSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName => entityTestSubject.map(
        simpleEntity: (_) => 'MultipleValidationsSoloSE',
        iterableEntity: (_) => 'MultipleValidationsSoloIE',
        iterable2Entity: (_) => 'MultipleValidationsSoloI2E',
      );

  @override
  List<String> get vStepsNames => ['Mid', 'Late'];

  /// Returns a list of the failure fields after accessing them from an
  /// invalid-step union-case (which varies depending on the failed
  /// validationStep of the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure?> getFailureFieldsFromInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) =>
            [invalidMid.contentFailure, invalidMid.lengthFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) =>
            [invalidMid.contentFailure, invalidMid.lengthFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) =>
            [invalidMid.contentFailure, invalidMid.lengthFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
    );
  }

  /// Returns a list of the result of calling "hasFailure" getters from the
  /// "mid" invalid-step union-case.
  ///
  /// NB : This should only be called if the [testSubject] is an instance of the
  /// "mid" invalid-step union-case (which has multiple validations), otherwise
  /// throws an [UnreachableError].
  ///
  List<bool> getHasFailureGettersFromInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.maybeMap(
        invalidMid: (invalidMid) =>
            [invalidMid.hasContentFailure, invalidMid.hasLengthFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterableEntity: (iterableEntity) => iterableEntity.maybeMap(
        invalidMid: (invalidMid) =>
            [invalidMid.hasContentFailure, invalidMid.hasLengthFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.maybeMap(
        invalidMid: (invalidMid) =>
            [invalidMid.hasContentFailure, invalidMid.hasLengthFailure],
        orElse: () => throw UnreachableError(),
      ),
    );
  }

  /// Returns the result of calling the `failures` getter from the abstract
  /// invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromAbstractInvalidUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterableEntity: (iterableEntity) => iterableEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
    );
  }

  /// Returns the result of calling the `failures` getter from an invalid-step
  /// union-case (which varies depending on the failed validationStep of the
  /// [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
    );
  }

  @override
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    entityTestSubject.when(
      simpleEntity: (modddel) =>
          checkToBroadEitherGettersResults<ValidMultipleValidationsSoloSE>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      iterableEntity: (modddel) =>
          checkToBroadEitherGettersResults<ValidMultipleValidationsSoloIE>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      iterable2Entity: (modddel) =>
          checkToBroadEitherGettersResults<ValidMultipleValidationsSoloI2E>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
    );
  }
}

class MultipleValidationsSoloSampleOptions extends SampleOptionsBase {
  MultipleValidationsSoloSampleOptions(
    super.name, {
    required this.lengthValidationPasses,
    required this.sizeValidationPasses,
  });

  final bool lengthValidationPasses;

  final bool sizeValidationPasses;
}

/* ----------------------------------- B1 ----------------------------------- */

class OneValidationSSealedTestSupport extends EntitiesTestSupport<
    OneValidationSSealedTestHelper,
    SampleParams,
    OneValidationSSealedSampleOptions,
    OneValidationSSealedSE,
    OneValidationSSealedIE,
    OneValidationSSealedI2E> {
  OneValidationSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, SampleParams sampleParams) =>
      OneValidationSSealedTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  OneValidationSSealedSE makeSimpleEntity(
      SampleParams params, OneValidationSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneValidationSSealedSE.firstOneValidationSSealedSE(
          param1: params.param1.value,
          param2: params.param2.value,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        );
      case FactoryConstructor.second:
        return OneValidationSSealedSE.secondOneValidationSSealedSE(
          param1: params.param1.value,
          param2: params.param2.value,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        );
    }
  }

  @override
  OneValidationSSealedIE makeIterableEntity(
      SampleParams params, OneValidationSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneValidationSSealedIE.firstOneValidationSSealedIE(
          params: [
            params.param1.value,
            params.param2.value,
          ],
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        );
      case FactoryConstructor.second:
        return OneValidationSSealedIE.secondOneValidationSSealedIE(
          params: [
            params.param1.value,
            params.param2.value,
          ],
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        );
    }
  }

  @override
  OneValidationSSealedI2E makeIterable2Entity(
      SampleParams params, OneValidationSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneValidationSSealedI2E.firstOneValidationSSealedI2E(
          params: {
            params.param1.value: params.param2.value,
          },
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        );
      case FactoryConstructor.second:
        return OneValidationSSealedI2E.secondOneValidationSSealedI2E(
          params: {
            params.param1.value: params.param2.value,
          },
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        );
    }
  }
}

class OneValidationSSealedTestHelper extends EntityTestHelper<
        SampleParams,
        OneValidationSSealedSampleOptions,
        OneValidationSSealedSE,
        OneValidationSSealedIE,
        OneValidationSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin,
        ContentFailureTestHelperMixin {
  OneValidationSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => entityTestSubject.map(
        simpleEntity: (_) => 'OneValidationSSealedSE',
        iterableEntity: (_) => 'OneValidationSSealedIE',
        iterable2Entity: (_) => 'OneValidationSSealedI2E',
      );

  @override
  List<String> get vStepsNames => ['Mid', 'Late'];

  /// Returns a list of the failure fields after accessing them from a ssealed
  /// invalid-step mixin (which varies depending on the failed validationStep of
  /// the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  List<Failure?> getFailureFieldsFromSSealedInvalidStepMixin() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => [invalidMid.contentFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => [invalidMid.contentFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => [invalidMid.contentFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
    );
  }

  /// Returns a list of the failure fields after accessing them from one of the
  /// case-modddel's invalid-step union-cases (which varies depending on the
  /// failed validationStep of the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure?> getFailureFieldsFromModddelInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.mapOneValidationSSealedSE(
          firstOneValidationSSealedSE: (caseModddel) => caseModddel.map(
                valid: (valid) => throw UnreachableError(),
                invalidMid: (invalidMid) => [invalidMid.contentFailure],
                invalidLate: (invalidLate) => [invalidLate.sizeFailure],
              ),
          secondOneValidationSSealedSE: (caseModddel) => caseModddel.map(
                valid: (valid) => throw UnreachableError(),
                invalidMid: (invalidMid) => [invalidMid.contentFailure],
                invalidLate: (invalidLate) => [invalidLate.sizeFailure],
              )),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapOneValidationSSealedIE(
              firstOneValidationSSealedIE: (caseModddel) => caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) => [invalidMid.contentFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  ),
              secondOneValidationSSealedIE: (caseModddel) => caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) => [invalidMid.contentFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  )),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapOneValidationSSealedI2E(
              firstOneValidationSSealedI2E: (caseModddel) => caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) => [invalidMid.contentFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  ),
              secondOneValidationSSealedI2E: (caseModddel) => caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) => [invalidMid.contentFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  )),
    );
  }

  /// Returns the result of calling the `failures` getter from the ssealed
  /// invalid mixin.
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromSSealedInvalidMixin() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterableEntity: (iterableEntity) => iterableEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
    );
  }

  /// Returns the result of calling the `failures` getter from the
  /// case-modddel's abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromModddelAbstractInvalidUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.mapOneValidationSSealedSE(
        firstOneValidationSSealedSE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondOneValidationSSealedSE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapOneValidationSSealedIE(
        firstOneValidationSSealedIE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondOneValidationSSealedIE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapOneValidationSSealedI2E(
        firstOneValidationSSealedI2E: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondOneValidationSSealedI2E: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
    );
  }

  /// Returns the result of calling the `failures` getter from a ssealed
  /// invalid-step mixin (which varies depending on the failed validationStep of
  /// the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromSSealedInvalidStepMixin() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
    );
  }

  /// Returns the result of calling the `failures` getter from one of the
  /// case-modddel's invalid-step union-cases (which varies depending on the
  /// failed validationStep of the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromModddelInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.mapOneValidationSSealedSE(
        firstOneValidationSSealedSE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
        secondOneValidationSSealedSE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapOneValidationSSealedIE(
        firstOneValidationSSealedIE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
        secondOneValidationSSealedIE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapOneValidationSSealedI2E(
        firstOneValidationSSealedI2E: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
        secondOneValidationSSealedI2E: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
      ),
    );
  }

  @override
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    entityTestSubject.when(
      simpleEntity: (sSealedModddel) =>
          sSealedModddel.mapOneValidationSSealedSE(
              firstOneValidationSSealedSE: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidOneValidationSSealedSE,
                      ValidFirstOneValidationSSealedSE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondOneValidationSSealedSE: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidOneValidationSSealedSE,
                      ValidSecondOneValidationSSealedSE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
      iterableEntity: (sSealedModddel) =>
          sSealedModddel.mapOneValidationSSealedIE(
              firstOneValidationSSealedIE: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidOneValidationSSealedIE,
                      ValidFirstOneValidationSSealedIE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondOneValidationSSealedIE: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidOneValidationSSealedIE,
                      ValidSecondOneValidationSSealedIE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
      iterable2Entity: (sSealedModddel) =>
          sSealedModddel.mapOneValidationSSealedI2E(
              firstOneValidationSSealedI2E: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidOneValidationSSealedI2E,
                      ValidFirstOneValidationSSealedI2E>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondOneValidationSSealedI2E: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidOneValidationSSealedI2E,
                      ValidSecondOneValidationSSealedI2E>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
    );
  }
}

class OneValidationSSealedSampleOptions extends SampleOptionsBase
    with SSealedSampleOptionsMixin {
  OneValidationSSealedSampleOptions(
    super.name, {
    required this.usedFactoryConstructor,
    required this.sizeValidationPasses,
  });

  @override
  final FactoryConstructor usedFactoryConstructor;

  final bool sizeValidationPasses;
}

/* ----------------------------------- B2 ----------------------------------- */

class MultipleValidationsSSealedTestSupport extends EntitiesTestSupport<
    MultipleValidationsSSealedTestHelper,
    SampleParams,
    MultipleValidationsSSealedSampleOptions,
    MultipleValidationsSSealedSE,
    MultipleValidationsSSealedIE,
    MultipleValidationsSSealedI2E> {
  MultipleValidationsSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, SampleParams sampleParams) =>
      MultipleValidationsSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  MultipleValidationsSSealedSE makeSimpleEntity(SampleParams params,
      MultipleValidationsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleValidationsSSealedSE.firstMultipleValidationsSSealedSE(
          param1: params.param1.value,
          param2: params.param2.value,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return MultipleValidationsSSealedSE.secondMultipleValidationsSSealedSE(
          param1: params.param1.value,
          param2: params.param2.value,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }

  @override
  MultipleValidationsSSealedIE makeIterableEntity(SampleParams params,
      MultipleValidationsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleValidationsSSealedIE.firstMultipleValidationsSSealedIE(
          params: [
            params.param1.value,
            params.param2.value,
          ],
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return MultipleValidationsSSealedIE.secondMultipleValidationsSSealedIE(
          params: [
            params.param1.value,
            params.param2.value,
          ],
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }

  @override
  MultipleValidationsSSealedI2E makeIterable2Entity(SampleParams params,
      MultipleValidationsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleValidationsSSealedI2E.firstMultipleValidationsSSealedI2E(
          params: {
            params.param1.value: params.param2.value,
          },
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return MultipleValidationsSSealedI2E
            .secondMultipleValidationsSSealedI2E(
          params: {
            params.param1.value: params.param2.value,
          },
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }
}

class MultipleValidationsSSealedTestHelper extends EntityTestHelper<
        SampleParams,
        MultipleValidationsSSealedSampleOptions,
        MultipleValidationsSSealedSE,
        MultipleValidationsSSealedIE,
        MultipleValidationsSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin,
        ContentFailureTestHelperMixin {
  MultipleValidationsSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => entityTestSubject.map(
        simpleEntity: (_) => 'MultipleValidationsSSealedSE',
        iterableEntity: (_) => 'MultipleValidationsSSealedIE',
        iterable2Entity: (_) => 'MultipleValidationsSSealedI2E',
      );

  @override
  List<String> get vStepsNames => ['Mid', 'Late'];

  /// Returns a list of the failure fields after accessing them from a ssealed
  /// invalid-step mixin (which varies depending on the failed validationStep of
  /// the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  List<Failure?> getFailureFieldsFromSSealedInvalidStepMixin() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) =>
            [invalidMid.contentFailure, invalidMid.lengthFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) =>
            [invalidMid.contentFailure, invalidMid.lengthFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) =>
            [invalidMid.contentFailure, invalidMid.lengthFailure],
        invalidLate: (invalidLate) => [invalidLate.sizeFailure],
      ),
    );
  }

  /// Returns a list of the failure fields after accessing them from one of the
  /// case-modddel's invalid-step union-cases (which varies depending on the
  /// failed validationStep of the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  List<Failure?> getFailureFieldsFromModddelInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) =>
          simpleEntity.mapMultipleValidationsSSealedSE(
              firstMultipleValidationsSSealedSE: (caseModddel) =>
                  caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) =>
                        [invalidMid.contentFailure, invalidMid.lengthFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  ),
              secondMultipleValidationsSSealedSE: (caseModddel) =>
                  caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) =>
                        [invalidMid.contentFailure, invalidMid.lengthFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  )),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapMultipleValidationsSSealedIE(
              firstMultipleValidationsSSealedIE: (caseModddel) =>
                  caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) =>
                        [invalidMid.contentFailure, invalidMid.lengthFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  ),
              secondMultipleValidationsSSealedIE: (caseModddel) =>
                  caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) =>
                        [invalidMid.contentFailure, invalidMid.lengthFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  )),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapMultipleValidationsSSealedI2E(
              firstMultipleValidationsSSealedI2E: (caseModddel) =>
                  caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) =>
                        [invalidMid.contentFailure, invalidMid.lengthFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  ),
              secondMultipleValidationsSSealedI2E: (caseModddel) =>
                  caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) =>
                        [invalidMid.contentFailure, invalidMid.lengthFailure],
                    invalidLate: (invalidLate) => [invalidLate.sizeFailure],
                  )),
    );
  }

  /// Returns a list of the result of calling "hasFailure" getters from the
  /// "mid" ssealed invalid-step mixin.
  ///
  /// NB : This should only be called if the [testSubject] is an instance of the
  /// "mid" invalid-step union-case (which has multiple validations), otherwise
  /// throws an [UnreachableError].
  ///
  List<bool> getHasFailureGettersFromSSealedInvalidStepMixin() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.maybeMap(
        invalidMid: (invalidMid) =>
            [invalidMid.hasContentFailure, invalidMid.hasLengthFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterableEntity: (iterableEntity) => iterableEntity.maybeMap(
        invalidMid: (invalidMid) =>
            [invalidMid.hasContentFailure, invalidMid.hasLengthFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.maybeMap(
        invalidMid: (invalidMid) =>
            [invalidMid.hasContentFailure, invalidMid.hasLengthFailure],
        orElse: () => throw UnreachableError(),
      ),
    );
  }

  /// Returns a list of the result of calling "hasFailure" getters from the
  /// case-modddel's "mid" invalid-step union-case.
  ///
  /// NB : This should only be called if the [testSubject] is an instance of the
  /// "mid" invalid-step union-case (which has multiple validations), otherwise
  /// throws an [UnreachableError].
  ///
  List<bool> getHasFailureGettersFromModddelInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) =>
          simpleEntity.mapMultipleValidationsSSealedSE(
              firstMultipleValidationsSSealedSE: (caseModddel) =>
                  caseModddel.maybeMap(
                    invalidMid: (invalidMid) => [
                      invalidMid.hasContentFailure,
                      invalidMid.hasLengthFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  ),
              secondMultipleValidationsSSealedSE: (caseModddel) =>
                  caseModddel.maybeMap(
                    invalidMid: (invalidMid) => [
                      invalidMid.hasContentFailure,
                      invalidMid.hasLengthFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  )),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapMultipleValidationsSSealedIE(
              firstMultipleValidationsSSealedIE: (caseModddel) =>
                  caseModddel.maybeMap(
                    invalidMid: (invalidMid) => [
                      invalidMid.hasContentFailure,
                      invalidMid.hasLengthFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  ),
              secondMultipleValidationsSSealedIE: (caseModddel) =>
                  caseModddel.maybeMap(
                    invalidMid: (invalidMid) => [
                      invalidMid.hasContentFailure,
                      invalidMid.hasLengthFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  )),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapMultipleValidationsSSealedI2E(
              firstMultipleValidationsSSealedI2E: (caseModddel) =>
                  caseModddel.maybeMap(
                    invalidMid: (invalidMid) => [
                      invalidMid.hasContentFailure,
                      invalidMid.hasLengthFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  ),
              secondMultipleValidationsSSealedI2E: (caseModddel) =>
                  caseModddel.maybeMap(
                    invalidMid: (invalidMid) => [
                      invalidMid.hasContentFailure,
                      invalidMid.hasLengthFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  )),
    );
  }

  /// Returns the result of calling the `failures` getter from the ssealed
  /// invalid mixin.
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromSSealedInvalidMixin() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterableEntity: (iterableEntity) => iterableEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
    );
  }

  /// Returns the result of calling the `failures` getter from the
  /// case-modddel's abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromModddelAbstractInvalidUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) =>
          simpleEntity.mapMultipleValidationsSSealedSE(
        firstMultipleValidationsSSealedSE: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.failures),
        secondMultipleValidationsSSealedSE: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.failures),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapMultipleValidationsSSealedIE(
        firstMultipleValidationsSSealedIE: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.failures),
        secondMultipleValidationsSSealedIE: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.failures),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapMultipleValidationsSSealedI2E(
        firstMultipleValidationsSSealedI2E: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.failures),
        secondMultipleValidationsSSealedI2E: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.failures),
      ),
    );
  }

  /// Returns the result of calling the `failures` getter from a ssealed
  /// invalid-step mixin (which varies depending on the failed validationStep of
  /// the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromSSealedInvalidStepMixin() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => invalidMid.failures,
        invalidLate: (invalidLate) => invalidLate.failures,
      ),
    );
  }

  /// Returns the result of calling the `failures` getter from one of the
  /// case-modddel's invalid-step union-cases (which varies depending on the
  /// failed validationStep of the [testSubject]).
  ///
  /// NB : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  List<Failure> callFailuresGetterFromModddelInvalidStepUnionCase() {
    return entityTestSubject.when(
      simpleEntity: (simpleEntity) =>
          simpleEntity.mapMultipleValidationsSSealedSE(
        firstMultipleValidationsSSealedSE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
        secondMultipleValidationsSSealedSE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapMultipleValidationsSSealedIE(
        firstMultipleValidationsSSealedIE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
        secondMultipleValidationsSSealedIE: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapMultipleValidationsSSealedI2E(
        firstMultipleValidationsSSealedI2E: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
        secondMultipleValidationsSSealedI2E: (caseModddel) => caseModddel.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => invalidMid.failures,
          invalidLate: (invalidLate) => invalidLate.failures,
        ),
      ),
    );
  }

  @override
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    entityTestSubject.when(
      simpleEntity: (sSealedModddel) =>
          sSealedModddel.mapMultipleValidationsSSealedSE(
              firstMultipleValidationsSSealedSE: (caseModddel) =>
                  checkToBroadEitherGettersResults<
                      ValidMultipleValidationsSSealedSE,
                      ValidFirstMultipleValidationsSSealedSE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondMultipleValidationsSSealedSE: (caseModddel) =>
                  checkToBroadEitherGettersResults<
                      ValidMultipleValidationsSSealedSE,
                      ValidSecondMultipleValidationsSSealedSE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
      iterableEntity: (sSealedModddel) =>
          sSealedModddel.mapMultipleValidationsSSealedIE(
              firstMultipleValidationsSSealedIE: (caseModddel) =>
                  checkToBroadEitherGettersResults<
                      ValidMultipleValidationsSSealedIE,
                      ValidFirstMultipleValidationsSSealedIE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondMultipleValidationsSSealedIE: (caseModddel) =>
                  checkToBroadEitherGettersResults<
                      ValidMultipleValidationsSSealedIE,
                      ValidSecondMultipleValidationsSSealedIE>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
      iterable2Entity: (sSealedModddel) =>
          sSealedModddel.mapMultipleValidationsSSealedI2E(
              firstMultipleValidationsSSealedI2E: (caseModddel) =>
                  checkToBroadEitherGettersResults<
                      ValidMultipleValidationsSSealedI2E,
                      ValidFirstMultipleValidationsSSealedI2E>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondMultipleValidationsSSealedI2E: (caseModddel) =>
                  checkToBroadEitherGettersResults<
                      ValidMultipleValidationsSSealedI2E,
                      ValidSecondMultipleValidationsSSealedI2E>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
    );
  }
}

class MultipleValidationsSSealedSampleOptions extends SampleOptionsBase
    with SSealedSampleOptionsMixin {
  MultipleValidationsSSealedSampleOptions(
    super.name, {
    required this.usedFactoryConstructor,
    required this.lengthValidationPasses,
    required this.sizeValidationPasses,
  });

  @override
  final FactoryConstructor usedFactoryConstructor;

  final bool lengthValidationPasses;

  final bool sizeValidationPasses;
}

/* -------------------------------------------------------------------------- */
/*                          Common TestHelper Mixins                          */
/* -------------------------------------------------------------------------- */

mixin ContentFailureTestHelperMixin<
    P extends SampleParamsBase,
    O extends SampleOptionsBase,
    SE extends SimpleEntity,
    IE extends IterableEntity,
    I2E extends Iterable2Entity> on EntityTestHelper<P, O, SE, IE, I2E> {
  /// Returns the description of the first member parameter (See
  /// [ModddelInvalidMember.description]).
  ///
  String getFirstMemberDescription() {
    return entityTestSubject.map(
        simpleEntity: (_) => 'param1',
        iterableEntity: (_) => 'item 0',
        iterable2Entity: (_) => 'key 0');
  }

  /// Returns the description of the second member parameter (See
  /// [ModddelInvalidMember.description]).
  ///
  String getSecondMemberDescription() {
    return entityTestSubject.map(
        simpleEntity: (_) => 'param2',
        iterableEntity: (_) => 'item 1',
        iterable2Entity: (_) => 'value 0');
  }
}

/* -------------------------------------------------------------------------- */
/*                             Common SampleValues                            */
/* -------------------------------------------------------------------------- */

class SampleParams extends SampleParamsBase {
  SampleParams._({
    required this.param1,
    required this.param2,
    required this.param1IsValid,
    required this.param2IsValid,
  });

  final ParamWithSource<CustomModddel> param1;

  final ParamWithSource<CustomModddel> param2;

  /// Whether the provided [param1] is a valid modddel.
  ///
  final bool param1IsValid;

  /// Whether the provided [param2] is a valid modddel.
  ///
  final bool param2IsValid;
}

EntitySampleValues<SampleParams> getSampleValues(
    {required bool param1IsValid, required bool param2IsValid}) {
  final param1 =
      CustomSampleValues.getParamModddel(shouldBeValid: param1IsValid);
  final param2 =
      CustomSampleValues.getParamModddel(shouldBeValid: param2IsValid);

  return EntitySampleValues<SampleParams>(
    simpleEntity: SampleParams._(
        param1: param1,
        param2: param2,
        param1IsValid: param1IsValid,
        param2IsValid: param2IsValid),
    iterableEntity: SampleParams._(
        param1: param1,
        param2: param2,
        param1IsValid: param1IsValid,
        param2IsValid: param2IsValid),
    iterable2Entity: SampleParams._(
        param1: param1,
        param2: param2,
        param1IsValid: param1IsValid,
        param2IsValid: param2IsValid),
  );
}
