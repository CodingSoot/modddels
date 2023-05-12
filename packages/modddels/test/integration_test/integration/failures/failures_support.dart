// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';
import 'common_support.dart';
import 'failures.dart';

// Modddels groups :
//
// - A. Solo modddels
// - B. SSealed modddels
//

/* -------------------------------------------------------------------------- */
/*                   TestSupports and Helpers for each group                  */
/* -------------------------------------------------------------------------- */

/* ------------------------------------ A ----------------------------------- */

class FailuresSoloTestSupport extends ModddelsTestSupport<
    FailuresSoloTestHelper,
    SampleParams,
    SoloSampleOptions,
    FailuresSoloSVO,
    FailuresSoloMVO,
    FailuresSoloSE,
    FailuresSoloIE,
    FailuresSoloI2E> {
  FailuresSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      FailuresSoloTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  FailuresSoloSVO makeSingleValueObject(
          SampleParams params, SoloSampleOptions sampleOptions) =>
      FailuresSoloSVO(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  FailuresSoloMVO makeMultiValueObject(
          SampleParams params, SoloSampleOptions sampleOptions) =>
      FailuresSoloMVO(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  FailuresSoloSE makeSimpleEntity(
          SampleParams params, SoloSampleOptions sampleOptions) =>
      FailuresSoloSE(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  FailuresSoloIE makeIterableEntity(
          SampleParams params, SoloSampleOptions sampleOptions) =>
      FailuresSoloIE(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  FailuresSoloI2E makeIterable2Entity(
          SampleParams params, SoloSampleOptions sampleOptions) =>
      FailuresSoloI2E(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );
}

class FailuresSoloTestHelper extends ModddelTestHelper<
        SampleParams,
        SoloSampleOptions,
        FailuresSoloSVO,
        FailuresSoloMVO,
        FailuresSoloSE,
        FailuresSoloIE,
        FailuresSoloI2E>
    with TestHelperMixin, ElementsSoloTestHelperMixin, SoloTestHelperMixin {
  FailuresSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName => testSubject.whenAll(
        singleValueObject: (_) => 'FailuresSoloSVO',
        multiValueObject: (_) => 'FailuresSoloMVO',
        simpleEntity: (_) => 'FailuresSoloSE',
        iterableEntity: (_) => 'FailuresSoloIE',
        iterable2Entity: (_) => 'FailuresSoloI2E',
      );

  @override
  List<String> get vStepsNames => testSubject.map(
        valueObject: (_) => ['Value1', 'Value2'],
        entity: (_) => ['Early1', 'Early2'],
      );

  /// Returns a list of the failure fields after accessing them from an
  /// invalid-step union-case (which varies depending on the failed
  /// validationStep of the [testSubject]).
  ///
  /// NB 1 : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  /// NB 2 : The validationStep containing the contentValidation is not supposed
  /// to be tested.
  ///
  List<Failure?> getFailureFieldsFromInvalidStepUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
        valid: (valid) => throw UnreachableError(),
        invalidValue1: (invalidValue1) => [invalidValue1.lengthFailure],
        invalidValue2: (invalidValue2) =>
            [invalidValue2.sizeFailure, invalidValue2.formatFailure],
      ),
      multiValueObject: (multiValueObject) => multiValueObject.map(
        valid: (valid) => throw UnreachableError(),
        invalidValue1: (invalidValue1) => [invalidValue1.lengthFailure],
        invalidValue2: (invalidValue2) =>
            [invalidValue2.sizeFailure, invalidValue2.formatFailure],
      ),
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidEarly1: (invalidEarly1) => [invalidEarly1.lengthFailure],
        invalidEarly2: (invalidEarly2) =>
            [invalidEarly2.sizeFailure, invalidEarly2.formatFailure],
        invalidMid: (invalidMid) => throw UnreachableError(),
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidEarly1: (invalidEarly1) => [invalidEarly1.lengthFailure],
        invalidEarly2: (invalidEarly2) =>
            [invalidEarly2.sizeFailure, invalidEarly2.formatFailure],
        invalidMid: (invalidMid) => throw UnreachableError(),
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidEarly1: (invalidEarly1) => [invalidEarly1.lengthFailure],
        invalidEarly2: (invalidEarly2) =>
            [invalidEarly2.sizeFailure, invalidEarly2.formatFailure],
        invalidMid: (invalidMid) => throw UnreachableError(),
      ),
    );
  }

  /// Returns a list of the result of calling "hasFailure" getters from the
  /// second invalid-step union-case.
  ///
  /// NB : This should only be called if the [testSubject] is an instance of the
  /// second invalid-step union-case (which has multiple validations), otherwise
  /// throws an [UnreachableError].
  ///
  List<bool> getHasFailureGettersFromInvalidStepUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.maybeMap(
        invalidValue2: (invalidValue2) =>
            [invalidValue2.hasSizeFailure, invalidValue2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      multiValueObject: (multiValueObject) => multiValueObject.maybeMap(
        invalidValue2: (invalidValue2) =>
            [invalidValue2.hasSizeFailure, invalidValue2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      simpleEntity: (simpleEntity) => simpleEntity.maybeMap(
        invalidEarly2: (invalidEarly2) =>
            [invalidEarly2.hasSizeFailure, invalidEarly2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterableEntity: (iterableEntity) => iterableEntity.maybeMap(
        invalidEarly2: (invalidEarly2) =>
            [invalidEarly2.hasSizeFailure, invalidEarly2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.maybeMap(
        invalidEarly2: (invalidEarly2) =>
            [invalidEarly2.hasSizeFailure, invalidEarly2.hasFormatFailure],
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
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      multiValueObject: (multiValueObject) => multiValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
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
  /// NB 1 : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  /// NB 2 : The validationStep containing the contentValidation is not supposed
  /// to be tested.
  ///
  List<Failure> callFailuresGetterFromInvalidStepUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => throw UnreachableError(),
          invalidValue1: (invalidValue1) => invalidValue1.failures,
          invalidValue2: (invalidValue2) => invalidValue2.failures),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => throw UnreachableError(),
          invalidValue1: (invalidValue1) => invalidValue1.failures,
          invalidValue2: (invalidValue2) => invalidValue2.failures),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => throw UnreachableError(),
          invalidEarly1: (invalidEarly1) => invalidEarly1.failures,
          invalidEarly2: (invalidEarly2) => invalidEarly2.failures,
          invalidMid: (invalidMid) => throw UnreachableError()),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => throw UnreachableError(),
          invalidEarly1: (invalidEarly1) => invalidEarly1.failures,
          invalidEarly2: (invalidEarly2) => invalidEarly2.failures,
          invalidMid: (invalidMid) => throw UnreachableError()),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => throw UnreachableError(),
          invalidEarly1: (invalidEarly1) => invalidEarly1.failures,
          invalidEarly2: (invalidEarly2) => invalidEarly2.failures,
          invalidMid: (invalidMid) => throw UnreachableError()),
    );
  }

  @override
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    testSubject.whenAll(
      singleValueObject: (modddel) =>
          checkToBroadEitherGettersResults<ValidFailuresSoloSVO>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      multiValueObject: (modddel) =>
          checkToBroadEitherGettersResults<ValidFailuresSoloMVO>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      simpleEntity: (modddel) =>
          checkToBroadEitherGettersResults<ValidFailuresSoloSE>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      iterableEntity: (modddel) =>
          checkToBroadEitherGettersResults<ValidFailuresSoloIE>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
      iterable2Entity: (modddel) =>
          checkToBroadEitherGettersResults<ValidFailuresSoloI2E>(
        baseModddel.toBroadEither,
        modddel.toBroadEither,
        isModddelValid: isModddelValid,
        expectedFailures: expectedFailures,
      ),
    );
  }
}

/* ------------------------------------ B ----------------------------------- */

class FailuresSSealedTestSupport extends ModddelsTestSupport<
    FailuresSSealedTestHelper,
    SampleParams,
    SSealedSampleOptions,
    FailuresSSealedSVO,
    FailuresSSealedMVO,
    FailuresSSealedSE,
    FailuresSSealedIE,
    FailuresSSealedI2E> {
  FailuresSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      FailuresSSealedTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  FailuresSSealedSVO makeSingleValueObject(
      SampleParams params, SSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return FailuresSSealedSVO.firstFailuresSSealedSVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
      case FactoryConstructor.second:
        return FailuresSSealedSVO.secondFailuresSSealedSVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
    }
  }

  @override
  FailuresSSealedMVO makeMultiValueObject(
      SampleParams params, SSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return FailuresSSealedMVO.firstFailuresSSealedMVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
      case FactoryConstructor.second:
        return FailuresSSealedMVO.secondFailuresSSealedMVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
    }
  }

  @override
  FailuresSSealedSE makeSimpleEntity(
      SampleParams params, SSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return FailuresSSealedSE.firstFailuresSSealedSE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
      case FactoryConstructor.second:
        return FailuresSSealedSE.secondFailuresSSealedSE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
    }
  }

  @override
  FailuresSSealedIE makeIterableEntity(
      SampleParams params, SSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return FailuresSSealedIE.firstFailuresSSealedIE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
      case FactoryConstructor.second:
        return FailuresSSealedIE.secondFailuresSSealedIE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
    }
  }

  @override
  FailuresSSealedI2E makeIterable2Entity(
      SampleParams params, SSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return FailuresSSealedI2E.firstFailuresSSealedI2E(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
      case FactoryConstructor.second:
        return FailuresSSealedI2E.secondFailuresSSealedI2E(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
          $sizeValidationPasses: sampleOptions.sizeValidationPasses,
          $formatValidationPasses: sampleOptions.formatValidationPasses,
        );
    }
  }
}

class FailuresSSealedTestHelper extends ModddelTestHelper<
        SampleParams,
        SSealedSampleOptions,
        FailuresSSealedSVO,
        FailuresSSealedMVO,
        FailuresSSealedSE,
        FailuresSSealedIE,
        FailuresSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin {
  FailuresSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
        singleValueObject: (_) => 'FailuresSSealedSVO',
        multiValueObject: (_) => 'FailuresSSealedMVO',
        simpleEntity: (_) => 'FailuresSSealedSE',
        iterableEntity: (_) => 'FailuresSSealedIE',
        iterable2Entity: (_) => 'FailuresSSealedI2E',
      );

  @override
  List<String> get vStepsNames => testSubject.map(
        valueObject: (_) => ['Value1', 'Value2'],
        entity: (_) => ['Late1', 'Late2'],
      );

  /// Returns a list of the failure fields after accessing them from a ssealed
  /// invalid-step mixin (which varies depending on the failed validationStep of
  /// the [testSubject]).
  ///
  /// NB 1 : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  /// NB 2 : The validationStep containing the contentValidation is not supposed
  /// to be tested.
  ///
  List<Failure?> getFailureFieldsFromSSealedInvalidStepMixin() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
        valid: (valid) => throw UnreachableError(),
        invalidValue1: (invalidValue1) => [invalidValue1.lengthFailure],
        invalidValue2: (invalidValue2) =>
            [invalidValue2.sizeFailure, invalidValue2.formatFailure],
      ),
      multiValueObject: (multiValueObject) => multiValueObject.map(
        valid: (valid) => throw UnreachableError(),
        invalidValue1: (invalidValue1) => [invalidValue1.lengthFailure],
        invalidValue2: (invalidValue2) =>
            [invalidValue2.sizeFailure, invalidValue2.formatFailure],
      ),
      simpleEntity: (simpleEntity) => simpleEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => throw UnreachableError(),
        invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
        invalidLate2: (invalidLate2) =>
            [invalidLate2.sizeFailure, invalidLate2.formatFailure],
      ),
      iterableEntity: (iterableEntity) => iterableEntity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => throw UnreachableError(),
        invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
        invalidLate2: (invalidLate2) =>
            [invalidLate2.sizeFailure, invalidLate2.formatFailure],
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
        valid: (valid) => throw UnreachableError(),
        invalidMid: (invalidMid) => throw UnreachableError(),
        invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
        invalidLate2: (invalidLate2) =>
            [invalidLate2.sizeFailure, invalidLate2.formatFailure],
      ),
    );
  }

  /// Returns a list of the failure fields after accessing them from one of the
  /// case-modddel's invalid-step union-cases (which varies depending on the
  /// failed validationStep of the [testSubject]).
  ///
  /// NB 1 : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  /// NB 2 : The validationStep containing the contentValidation is not supposed
  /// to be tested.
  ///
  List<Failure?> getFailureFieldsFromModddelInvalidStepUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapFailuresSSealedSVO(
              firstFailuresSSealedSVO: (caseModddel) => caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidValue1: (invalidValue1) =>
                        [invalidValue1.lengthFailure],
                    invalidValue2: (invalidValue2) => [
                      invalidValue2.sizeFailure,
                      invalidValue2.formatFailure
                    ],
                  ),
              secondFailuresSSealedSVO: (caseModddel) => caseModddel.map(
                  valid: (valid) => throw UnreachableError(),
                  invalidValue1: (invalidValue1) =>
                      [invalidValue1.lengthFailure],
                  invalidValue2: (invalidValue2) => [
                        invalidValue2.sizeFailure,
                        invalidValue2.formatFailure
                      ])),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapFailuresSSealedMVO(
              firstFailuresSSealedMVO: (caseModddel) => caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidValue1: (invalidValue1) =>
                        [invalidValue1.lengthFailure],
                    invalidValue2: (invalidValue2) => [
                      invalidValue2.sizeFailure,
                      invalidValue2.formatFailure
                    ],
                  ),
              secondFailuresSSealedMVO: (caseModddel) => caseModddel.map(
                  valid: (valid) => throw UnreachableError(),
                  invalidValue1: (invalidValue1) =>
                      [invalidValue1.lengthFailure],
                  invalidValue2: (invalidValue2) => [
                        invalidValue2.sizeFailure,
                        invalidValue2.formatFailure
                      ])),
      simpleEntity: (simpleEntity) => simpleEntity.mapFailuresSSealedSE(
          firstFailuresSSealedSE: (caseModddel) => caseModddel.map(
                valid: (valid) => throw UnreachableError(),
                invalidMid: (invalidMid) => throw UnreachableError(),
                invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
                invalidLate2: (invalidLate2) =>
                    [invalidLate2.sizeFailure, invalidLate2.formatFailure],
              ),
          secondFailuresSSealedSE: (caseModddel) => caseModddel.map(
              valid: (valid) => throw UnreachableError(),
              invalidMid: (invalidMid) => throw UnreachableError(),
              invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
              invalidLate2: (invalidLate2) =>
                  [invalidLate2.sizeFailure, invalidLate2.formatFailure])),
      iterableEntity: (iterableEntity) => iterableEntity.mapFailuresSSealedIE(
          firstFailuresSSealedIE: (caseModddel) => caseModddel.map(
                valid: (valid) => throw UnreachableError(),
                invalidMid: (invalidMid) => throw UnreachableError(),
                invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
                invalidLate2: (invalidLate2) =>
                    [invalidLate2.sizeFailure, invalidLate2.formatFailure],
              ),
          secondFailuresSSealedIE: (caseModddel) => caseModddel.map(
              valid: (valid) => throw UnreachableError(),
              invalidMid: (invalidMid) => throw UnreachableError(),
              invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
              invalidLate2: (invalidLate2) =>
                  [invalidLate2.sizeFailure, invalidLate2.formatFailure])),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapFailuresSSealedI2E(
              firstFailuresSSealedI2E: (caseModddel) => caseModddel.map(
                    valid: (valid) => throw UnreachableError(),
                    invalidMid: (invalidMid) => throw UnreachableError(),
                    invalidLate1: (invalidLate1) =>
                        [invalidLate1.lengthFailure],
                    invalidLate2: (invalidLate2) =>
                        [invalidLate2.sizeFailure, invalidLate2.formatFailure],
                  ),
              secondFailuresSSealedI2E: (caseModddel) => caseModddel.map(
                  valid: (valid) => throw UnreachableError(),
                  invalidMid: (invalidMid) => throw UnreachableError(),
                  invalidLate1: (invalidLate1) => [invalidLate1.lengthFailure],
                  invalidLate2: (invalidLate2) =>
                      [invalidLate2.sizeFailure, invalidLate2.formatFailure])),
    );
  }

  /// Returns a list of the result of calling "hasFailure" getters from the
  /// second ssealed invalid-step mixin.
  ///
  /// NB : This should only be called if the [testSubject] is an instance of the
  /// second invalid-step union-case (which has multiple validations), otherwise
  /// throws an [UnreachableError].
  ///
  List<bool> getHasFailureGettersFromSSealedInvalidStepMixin() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.maybeMap(
        invalidValue2: (invalidValue2) =>
            [invalidValue2.hasSizeFailure, invalidValue2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      multiValueObject: (multiValueObject) => multiValueObject.maybeMap(
        invalidValue2: (invalidValue2) =>
            [invalidValue2.hasSizeFailure, invalidValue2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      simpleEntity: (simpleEntity) => simpleEntity.maybeMap(
        invalidLate2: (invalidLate2) =>
            [invalidLate2.hasSizeFailure, invalidLate2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterableEntity: (iterableEntity) => iterableEntity.maybeMap(
        invalidLate2: (invalidLate2) =>
            [invalidLate2.hasSizeFailure, invalidLate2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
      iterable2Entity: (iterable2Entity) => iterable2Entity.maybeMap(
        invalidLate2: (invalidLate2) =>
            [invalidLate2.hasSizeFailure, invalidLate2.hasFormatFailure],
        orElse: () => throw UnreachableError(),
      ),
    );
  }

  /// Returns a list of the result of calling "hasFailure" getters from the
  /// case-modddel's second invalid-step union-case.
  ///
  /// NB : This should only be called if the [testSubject] is an instance of the
  /// second invalid-step union-case (which has multiple validations), otherwise
  /// throws an [UnreachableError].
  ///
  List<bool> getHasFailureGettersFromModddelInvalidStepUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapFailuresSSealedSVO(
              firstFailuresSSealedSVO: (caseModddel) => caseModddel.maybeMap(
                    invalidValue2: (invalidValue2) => [
                      invalidValue2.hasSizeFailure,
                      invalidValue2.hasFormatFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  ),
              secondFailuresSSealedSVO: (caseModddel) => caseModddel.maybeMap(
                    invalidValue2: (invalidValue2) => [
                      invalidValue2.hasSizeFailure,
                      invalidValue2.hasFormatFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  )),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapFailuresSSealedMVO(
              firstFailuresSSealedMVO: (caseModddel) => caseModddel.maybeMap(
                    invalidValue2: (invalidValue2) => [
                      invalidValue2.hasSizeFailure,
                      invalidValue2.hasFormatFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  ),
              secondFailuresSSealedMVO: (caseModddel) => caseModddel.maybeMap(
                    invalidValue2: (invalidValue2) => [
                      invalidValue2.hasSizeFailure,
                      invalidValue2.hasFormatFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  )),
      simpleEntity: (simpleEntity) => simpleEntity.mapFailuresSSealedSE(
          firstFailuresSSealedSE: (caseModddel) => caseModddel.maybeMap(
                invalidLate2: (invalidLate2) => [
                  invalidLate2.hasSizeFailure,
                  invalidLate2.hasFormatFailure
                ],
                orElse: () => throw UnreachableError(),
              ),
          secondFailuresSSealedSE: (caseModddel) => caseModddel.maybeMap(
                invalidLate2: (invalidLate2) => [
                  invalidLate2.hasSizeFailure,
                  invalidLate2.hasFormatFailure
                ],
                orElse: () => throw UnreachableError(),
              )),
      iterableEntity: (iterableEntity) => iterableEntity.mapFailuresSSealedIE(
          firstFailuresSSealedIE: (caseModddel) => caseModddel.maybeMap(
                invalidLate2: (invalidLate2) => [
                  invalidLate2.hasSizeFailure,
                  invalidLate2.hasFormatFailure
                ],
                orElse: () => throw UnreachableError(),
              ),
          secondFailuresSSealedIE: (caseModddel) => caseModddel.maybeMap(
                invalidLate2: (invalidLate2) => [
                  invalidLate2.hasSizeFailure,
                  invalidLate2.hasFormatFailure
                ],
                orElse: () => throw UnreachableError(),
              )),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapFailuresSSealedI2E(
              firstFailuresSSealedI2E: (caseModddel) => caseModddel.maybeMap(
                    invalidLate2: (invalidLate2) => [
                      invalidLate2.hasSizeFailure,
                      invalidLate2.hasFormatFailure
                    ],
                    orElse: () => throw UnreachableError(),
                  ),
              secondFailuresSSealedI2E: (caseModddel) => caseModddel.maybeMap(
                    invalidLate2: (invalidLate2) => [
                      invalidLate2.hasSizeFailure,
                      invalidLate2.hasFormatFailure
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
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
      multiValueObject: (multiValueObject) => multiValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.failures),
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
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapFailuresSSealedSVO(
        firstFailuresSSealedSVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondFailuresSSealedSVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapFailuresSSealedMVO(
        firstFailuresSSealedMVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondFailuresSSealedMVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
      simpleEntity: (simpleEntity) => simpleEntity.mapFailuresSSealedSE(
        firstFailuresSSealedSE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondFailuresSSealedSE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
      iterableEntity: (iterableEntity) => iterableEntity.mapFailuresSSealedIE(
        firstFailuresSSealedIE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondFailuresSSealedIE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapFailuresSSealedI2E(
        firstFailuresSSealedI2E: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
        secondFailuresSSealedI2E: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.failures),
      ),
    );
  }

  /// Returns the result of calling the `failures` getter from a ssealed
  /// invalid-step mixin (which varies depending on the failed validationStep of
  /// the [testSubject]).
  ///
  /// NB 1 : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  /// NB 2 : The validationStep containing the contentValidation is not supposed
  /// to be tested.
  ///
  List<Failure> callFailuresGetterFromSSealedInvalidStepMixin() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => throw UnreachableError(),
          invalidValue1: (invalidValue1) => invalidValue1.failures,
          invalidValue2: (invalidValue2) => invalidValue2.failures),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => throw UnreachableError(),
          invalidValue1: (invalidValue1) => invalidValue1.failures,
          invalidValue2: (invalidValue2) => invalidValue2.failures),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => throw UnreachableError(),
          invalidLate1: (invalidLate1) => invalidLate1.failures,
          invalidLate2: (invalidLate2) => invalidLate2.failures),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => throw UnreachableError(),
          invalidLate1: (invalidLate1) => invalidLate1.failures,
          invalidLate2: (invalidLate2) => invalidLate2.failures),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => throw UnreachableError(),
          invalidMid: (invalidMid) => throw UnreachableError(),
          invalidLate1: (invalidLate1) => invalidLate1.failures,
          invalidLate2: (invalidLate2) => invalidLate2.failures),
    );
  }

  /// Returns the result of calling the `failures` getter from one of the
  /// case-modddel's invalid-step union-cases (which varies depending on the
  /// failed validationStep of the [testSubject]).
  ///
  /// NB 1 : This should only be called if the [testSubject] is invalid,
  /// otherwise throws an [UnreachableError].
  ///
  /// NB 2 : The validationStep containing the contentValidation is not supposed
  /// to be tested.
  ///
  List<Failure> callFailuresGetterFromModddelInvalidStepUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapFailuresSSealedSVO(
        firstFailuresSSealedSVO: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidValue1: (invalidValue1) => invalidValue1.failures,
            invalidValue2: (invalidValue2) => invalidValue2.failures),
        secondFailuresSSealedSVO: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidValue1: (invalidValue1) => invalidValue1.failures,
            invalidValue2: (invalidValue2) => invalidValue2.failures),
      ),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapFailuresSSealedMVO(
        firstFailuresSSealedMVO: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidValue1: (invalidValue1) => invalidValue1.failures,
            invalidValue2: (invalidValue2) => invalidValue2.failures),
        secondFailuresSSealedMVO: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidValue1: (invalidValue1) => invalidValue1.failures,
            invalidValue2: (invalidValue2) => invalidValue2.failures),
      ),
      simpleEntity: (simpleEntity) => simpleEntity.mapFailuresSSealedSE(
        firstFailuresSSealedSE: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidMid: (invalidMid) => throw UnreachableError(),
            invalidLate1: (invalidLate1) => invalidLate1.failures,
            invalidLate2: (invalidLate2) => invalidLate2.failures),
        secondFailuresSSealedSE: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidMid: (invalidMid) => throw UnreachableError(),
            invalidLate1: (invalidLate1) => invalidLate1.failures,
            invalidLate2: (invalidLate2) => invalidLate2.failures),
      ),
      iterableEntity: (iterableEntity) => iterableEntity.mapFailuresSSealedIE(
        firstFailuresSSealedIE: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidMid: (invalidMid) => throw UnreachableError(),
            invalidLate1: (invalidLate1) => invalidLate1.failures,
            invalidLate2: (invalidLate2) => invalidLate2.failures),
        secondFailuresSSealedIE: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidMid: (invalidMid) => throw UnreachableError(),
            invalidLate1: (invalidLate1) => invalidLate1.failures,
            invalidLate2: (invalidLate2) => invalidLate2.failures),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapFailuresSSealedI2E(
        firstFailuresSSealedI2E: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidMid: (invalidMid) => throw UnreachableError(),
            invalidLate1: (invalidLate1) => invalidLate1.failures,
            invalidLate2: (invalidLate2) => invalidLate2.failures),
        secondFailuresSSealedI2E: (caseModddel) => caseModddel.map(
            valid: (valid) => throw UnreachableError(),
            invalidMid: (invalidMid) => throw UnreachableError(),
            invalidLate1: (invalidLate1) => invalidLate1.failures,
            invalidLate2: (invalidLate2) => invalidLate2.failures),
      ),
    );
  }

  @override
  void checkAllToBroadEitherGettersResults({
    required bool isModddelValid,
    List<Failure>? expectedFailures,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    testSubject.whenAll(
      singleValueObject: (sSealedModddel) =>
          sSealedModddel.mapFailuresSSealedSVO(
              firstFailuresSSealedSVO: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidFailuresSSealedSVO,
                      ValidFirstFailuresSSealedSVO>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondFailuresSSealedSVO: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidFailuresSSealedSVO,
                      ValidSecondFailuresSSealedSVO>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
      multiValueObject: (sSealedModddel) =>
          sSealedModddel.mapFailuresSSealedMVO(
              firstFailuresSSealedMVO: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidFailuresSSealedMVO,
                      ValidFirstFailuresSSealedMVO>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  ),
              secondFailuresSSealedMVO: (caseModddel) =>
                  checkToBroadEitherGettersResults<ValidFailuresSSealedMVO,
                      ValidSecondFailuresSSealedMVO>(
                    baseModddel.toBroadEither,
                    sSealedModddel.toBroadEither,
                    caseModddel.toBroadEither,
                    isModddelValid: isModddelValid,
                    expectedFailures: expectedFailures,
                  )),
      simpleEntity: (sSealedModddel) => sSealedModddel.mapFailuresSSealedSE(
          firstFailuresSSealedSE: (caseModddel) =>
              checkToBroadEitherGettersResults<ValidFailuresSSealedSE,
                  ValidFirstFailuresSSealedSE>(
                baseModddel.toBroadEither,
                sSealedModddel.toBroadEither,
                caseModddel.toBroadEither,
                isModddelValid: isModddelValid,
                expectedFailures: expectedFailures,
              ),
          secondFailuresSSealedSE: (caseModddel) =>
              checkToBroadEitherGettersResults<ValidFailuresSSealedSE,
                  ValidSecondFailuresSSealedSE>(
                baseModddel.toBroadEither,
                sSealedModddel.toBroadEither,
                caseModddel.toBroadEither,
                isModddelValid: isModddelValid,
                expectedFailures: expectedFailures,
              )),
      iterableEntity: (sSealedModddel) => sSealedModddel.mapFailuresSSealedIE(
          firstFailuresSSealedIE: (caseModddel) =>
              checkToBroadEitherGettersResults<ValidFailuresSSealedIE,
                  ValidFirstFailuresSSealedIE>(
                baseModddel.toBroadEither,
                sSealedModddel.toBroadEither,
                caseModddel.toBroadEither,
                isModddelValid: isModddelValid,
                expectedFailures: expectedFailures,
              ),
          secondFailuresSSealedIE: (caseModddel) =>
              checkToBroadEitherGettersResults<ValidFailuresSSealedIE,
                  ValidSecondFailuresSSealedIE>(
                baseModddel.toBroadEither,
                sSealedModddel.toBroadEither,
                caseModddel.toBroadEither,
                isModddelValid: isModddelValid,
                expectedFailures: expectedFailures,
              )),
      iterable2Entity: (sSealedModddel) => sSealedModddel.mapFailuresSSealedI2E(
          firstFailuresSSealedI2E: (caseModddel) =>
              checkToBroadEitherGettersResults<ValidFailuresSSealedI2E,
                  ValidFirstFailuresSSealedI2E>(
                baseModddel.toBroadEither,
                sSealedModddel.toBroadEither,
                caseModddel.toBroadEither,
                isModddelValid: isModddelValid,
                expectedFailures: expectedFailures,
              ),
          secondFailuresSSealedI2E: (caseModddel) =>
              checkToBroadEitherGettersResults<ValidFailuresSSealedI2E,
                  ValidSecondFailuresSSealedI2E>(
                baseModddel.toBroadEither,
                sSealedModddel.toBroadEither,
                caseModddel.toBroadEither,
                isModddelValid: isModddelValid,
                expectedFailures: expectedFailures,
              )),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            Common SampleOptions                            */
/* -------------------------------------------------------------------------- */

abstract class SampleOptions extends SampleOptionsBase {
  SampleOptions(
    super.name, {
    required this.lengthValidationPasses,
    required this.sizeValidationPasses,
    required this.formatValidationPasses,
  });

  final bool lengthValidationPasses;

  final bool sizeValidationPasses;

  final bool formatValidationPasses;
}

class SoloSampleOptions extends SampleOptions {
  SoloSampleOptions(
    super.name, {
    required super.lengthValidationPasses,
    required super.sizeValidationPasses,
    required super.formatValidationPasses,
  });
}

class SSealedSampleOptions extends SampleOptions
    with SSealedSampleOptionsMixin {
  SSealedSampleOptions(
    super.name, {
    required this.usedFactoryConstructor,
    required super.lengthValidationPasses,
    required super.sizeValidationPasses,
    required super.formatValidationPasses,
  });

  @override
  final FactoryConstructor usedFactoryConstructor;
}

/* -------------------------------------------------------------------------- */
/*                             Common SampleValues                            */
/* -------------------------------------------------------------------------- */

class SampleParams extends SampleParamsBase {
  SampleParams(this.param);

  final ParamWithSource param;
}

final sampleValues = ModddelSampleValues<SampleParams>(
  singleValueObject: SampleParams(AlwaysValidSampleValues.paramInt),
  multiValueObject: SampleParams(AlwaysValidSampleValues.paramInt),
  simpleEntity: SampleParams(AlwaysValidSampleValues.paramModddel),
  iterableEntity: SampleParams(AlwaysValidSampleValues.paramListModddel),
  iterable2Entity: SampleParams(AlwaysValidSampleValues.paramMapModddel),
);
