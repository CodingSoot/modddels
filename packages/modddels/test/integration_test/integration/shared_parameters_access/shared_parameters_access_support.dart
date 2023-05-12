// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';
import 'shared_parameters_access.dart';

// Modddels groups : SSealed modddels that have :
//
// - A. Member parameters (without the `@withGetter` annotation) + Dependency
//   parameters
//   - A1 : The parameters are not shared
//   - A2 : The parameters are shared
// - B. Member parameters with the `@withGetter` annotation
//   - B1 : The parameters are not shared
//   - B2 : The parameters are shared
//

/* -------------------------------------------------------------------------- */
/*                   TestSupports and Helpers for each group                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

class NonSharedParamsAccessTestSupport extends ModddelsTestSupport<
    NonSharedParamsAccessTestHelper,
    WithoutGetterParams,
    NonSharedSampleOptions,
    NonSharedParamsAccessSVO,
    NonSharedParamsAccessMVO,
    NonSharedParamsAccessSE,
    NonSharedParamsAccessIE,
    NonSharedParamsAccessI2E> {
  NonSharedParamsAccessTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      NonSharedParamsAccessTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  NonSharedParamsAccessSVO makeSingleValueObject(
      WithoutGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return NonSharedParamsAccessSVO.firstNonSharedParamsAccessSVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return NonSharedParamsAccessSVO.secondNonSharedParamsAccessSVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  NonSharedParamsAccessMVO makeMultiValueObject(
      WithoutGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return NonSharedParamsAccessMVO.firstNonSharedParamsAccessMVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return NonSharedParamsAccessMVO.secondNonSharedParamsAccessMVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  NonSharedParamsAccessSE makeSimpleEntity(
      WithoutGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return NonSharedParamsAccessSE.firstNonSharedParamsAccessSE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return NonSharedParamsAccessSE.secondNonSharedParamsAccessSE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  NonSharedParamsAccessIE makeIterableEntity(
      WithoutGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return NonSharedParamsAccessIE.firstNonSharedParamsAccessIE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return NonSharedParamsAccessIE.secondNonSharedParamsAccessIE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  NonSharedParamsAccessI2E makeIterable2Entity(
      WithoutGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return NonSharedParamsAccessI2E.firstNonSharedParamsAccessI2E(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return NonSharedParamsAccessI2E.secondNonSharedParamsAccessI2E(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }
}

class NonSharedParamsAccessTestHelper extends ModddelTestHelper<
        WithoutGetterParams,
        NonSharedSampleOptions,
        NonSharedParamsAccessSVO,
        NonSharedParamsAccessMVO,
        NonSharedParamsAccessSE,
        NonSharedParamsAccessIE,
        NonSharedParamsAccessI2E>
    with ElementsSSealedTestHelperMixin, TestHelperMixin {
  NonSharedParamsAccessTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
      singleValueObject: (_) => 'NonSharedParamsAccessSVO',
      multiValueObject: (_) => 'NonSharedParamsAccessMVO',
      simpleEntity: (_) => 'NonSharedParamsAccessSE',
      iterableEntity: (_) => 'NonSharedParamsAccessIE',
      iterable2Entity: (_) => 'NonSharedParamsAccessI2E');

  @override
  String getSampleInstanceInvocationSrc() {
    return '$sSealedName.$caseModddelCallbackName('
        'param : ${sampleParams.param.src},'
        'dependency : ${sampleParams.dependency.src},'
        '\$isModddelValid : ${sampleOptions.isModddelValid},'
        ')';
  }
}

/* ----------------------------------- A2 ----------------------------------- */

class SharedParamsAccessTestSupport extends ModddelsTestSupport<
    SharedParamsAccessTestHelper,
    WithoutGetterParams,
    SharedSampleOptions,
    SharedParamsAccessSVO,
    SharedParamsAccessMVO,
    SharedParamsAccessSE,
    SharedParamsAccessIE,
    SharedParamsAccessI2E> {
  SharedParamsAccessTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      SharedParamsAccessTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  SharedParamsAccessSVO makeSingleValueObject(
      WithoutGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return SharedParamsAccessSVO.firstSharedParamsAccessSVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return SharedParamsAccessSVO.secondSharedParamsAccessSVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  SharedParamsAccessMVO makeMultiValueObject(
      WithoutGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return SharedParamsAccessMVO.firstSharedParamsAccessMVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return SharedParamsAccessMVO.secondSharedParamsAccessMVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  SharedParamsAccessSE makeSimpleEntity(
      WithoutGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return SharedParamsAccessSE.firstSharedParamsAccessSE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return SharedParamsAccessSE.secondSharedParamsAccessSE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  SharedParamsAccessIE makeIterableEntity(
      WithoutGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return SharedParamsAccessIE.firstSharedParamsAccessIE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return SharedParamsAccessIE.secondSharedParamsAccessIE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  SharedParamsAccessI2E makeIterable2Entity(
      WithoutGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return SharedParamsAccessI2E.firstSharedParamsAccessI2E(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return SharedParamsAccessI2E.secondSharedParamsAccessI2E(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }
}

class SharedParamsAccessTestHelper extends ModddelTestHelper<
        WithoutGetterParams,
        SharedSampleOptions,
        SharedParamsAccessSVO,
        SharedParamsAccessMVO,
        SharedParamsAccessSE,
        SharedParamsAccessIE,
        SharedParamsAccessI2E>
    with ElementsSSealedTestHelperMixin, TestHelperMixin {
  SharedParamsAccessTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
      singleValueObject: (_) => 'SharedParamsAccessSVO',
      multiValueObject: (_) => 'SharedParamsAccessMVO',
      simpleEntity: (_) => 'SharedParamsAccessSE',
      iterableEntity: (_) => 'SharedParamsAccessIE',
      iterable2Entity: (_) => 'SharedParamsAccessI2E');

  @override
  String getSampleInstanceInvocationSrc() {
    return '$sSealedName.$caseModddelCallbackName('
        'param : ${sampleParams.param.src},'
        'dependency : ${sampleParams.dependency.src},'
        '\$isModddelValid : ${sampleOptions.isModddelValid},'
        '\$validateMethodShouldThrowInfos : ${sampleOptions.validateMethodShouldThrowInfos},'
        ')';
  }

  /// Returns the member parameter named "param" after accessing it from either
  /// the valid ssealed class or the invalid-step ssealed class (which varies
  /// depending on the validness of the [testSubject]).
  ///
  dynamic getParamFromValidOrInvalidStepSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalidValue) => invalidValue.param),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalidValue) => invalidValue.param),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalidMid) => invalidMid.param),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalidMid) => invalidMid.param),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalidMid) => invalidMid.param),
    );
  }

  /// Returns the member parameter named "param" after accessing it from the
  /// invalid ssealed class.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  dynamic getParamFromInvalidSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      multiValueObject: (multiValueObject) => multiValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      simpleEntity: (simpleEntity) => simpleEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      iterableEntity: (iterableEntity) => iterableEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from the base ssealed class.
  ///
  MyService getDependencyFromBaseSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.dependency,
      multiValueObject: (multiValueObject) => multiValueObject.dependency,
      simpleEntity: (simpleEntity) => simpleEntity.dependency,
      iterableEntity: (iterableEntity) => iterableEntity.dependency,
      iterable2Entity: (iterable2Entity) => iterable2Entity.dependency,
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from either the valid ssealed class or the invalid-step ssealed class
  /// (which varies depending on the validness of the [testSubject]).
  ///
  MyService getDependencyFromValidOrInvalidStepSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => valid.dependency,
          invalidValue: (invalidValue) => invalidValue.dependency),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => valid.dependency,
          invalidValue: (invalidValue) => invalidValue.dependency),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => valid.dependency,
          invalidMid: (invalidMid) => invalidMid.dependency),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => valid.dependency,
          invalidMid: (invalidMid) => invalidMid.dependency),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => valid.dependency,
          invalidMid: (invalidMid) => invalidMid.dependency),
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from the invalid ssealed class.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  MyService getDependencyFromInvalidSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.dependency),
      multiValueObject: (multiValueObject) => multiValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.dependency),
      simpleEntity: (simpleEntity) => simpleEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.dependency),
      iterableEntity: (iterableEntity) => iterableEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.dependency),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.dependency),
    );
  }
}

/* ----------------------------------- B1 ----------------------------------- */

class WithGetterNonSharedParamsAccessTestSupport extends ModddelsTestSupport<
    WithGetterNonSharedParamsAccessTestHelper,
    WithGetterParams,
    NonSharedSampleOptions,
    WithGetterNonSharedParamsAccessSVO,
    WithGetterNonSharedParamsAccessMVO,
    WithGetterNonSharedParamsAccessSE,
    WithGetterNonSharedParamsAccessIE,
    WithGetterNonSharedParamsAccessI2E> {
  WithGetterNonSharedParamsAccessTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      WithGetterNonSharedParamsAccessTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  WithGetterNonSharedParamsAccessSVO makeSingleValueObject(
      WithGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterNonSharedParamsAccessSVO
            .firstWithGetterNonSharedParamsAccessSVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return WithGetterNonSharedParamsAccessSVO
            .secondWithGetterNonSharedParamsAccessSVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  WithGetterNonSharedParamsAccessMVO makeMultiValueObject(
      WithGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterNonSharedParamsAccessMVO
            .firstWithGetterNonSharedParamsAccessMVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return WithGetterNonSharedParamsAccessMVO
            .secondWithGetterNonSharedParamsAccessMVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  WithGetterNonSharedParamsAccessSE makeSimpleEntity(
      WithGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterNonSharedParamsAccessSE
            .firstWithGetterNonSharedParamsAccessSE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return WithGetterNonSharedParamsAccessSE
            .secondWithGetterNonSharedParamsAccessSE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  WithGetterNonSharedParamsAccessIE makeIterableEntity(
      WithGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterNonSharedParamsAccessIE
            .firstWithGetterNonSharedParamsAccessIE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return WithGetterNonSharedParamsAccessIE
            .secondWithGetterNonSharedParamsAccessIE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }

  @override
  WithGetterNonSharedParamsAccessI2E makeIterable2Entity(
      WithGetterParams params, NonSharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterNonSharedParamsAccessI2E
            .firstWithGetterNonSharedParamsAccessI2E(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
      case FactoryConstructor.second:
        return WithGetterNonSharedParamsAccessI2E
            .secondWithGetterNonSharedParamsAccessI2E(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
        );
    }
  }
}

class WithGetterNonSharedParamsAccessTestHelper extends ModddelTestHelper<
        WithGetterParams,
        NonSharedSampleOptions,
        WithGetterNonSharedParamsAccessSVO,
        WithGetterNonSharedParamsAccessMVO,
        WithGetterNonSharedParamsAccessSE,
        WithGetterNonSharedParamsAccessIE,
        WithGetterNonSharedParamsAccessI2E>
    with ElementsSSealedTestHelperMixin, TestHelperMixin {
  WithGetterNonSharedParamsAccessTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
      singleValueObject: (_) => 'WithGetterNonSharedParamsAccessSVO',
      multiValueObject: (_) => 'WithGetterNonSharedParamsAccessMVO',
      simpleEntity: (_) => 'WithGetterNonSharedParamsAccessSE',
      iterableEntity: (_) => 'WithGetterNonSharedParamsAccessIE',
      iterable2Entity: (_) => 'WithGetterNonSharedParamsAccessI2E');

  @override
  String getSampleInstanceInvocationSrc() {
    return '$sSealedName.$caseModddelCallbackName('
        'param : ${sampleParams.param.src},'
        '\$isModddelValid : ${sampleOptions.isModddelValid},'
        ')';
  }
}

/* ----------------------------------- B2 ----------------------------------- */

class WithGetterSharedParamsAccessTestSupport extends ModddelsTestSupport<
    WithGetterSharedParamsAccessTestHelper,
    WithGetterParams,
    SharedSampleOptions,
    WithGetterSharedParamsAccessSVO,
    WithGetterSharedParamsAccessMVO,
    WithGetterSharedParamsAccessSE,
    WithGetterSharedParamsAccessIE,
    WithGetterSharedParamsAccessI2E> {
  WithGetterSharedParamsAccessTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      WithGetterSharedParamsAccessTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  WithGetterSharedParamsAccessSVO makeSingleValueObject(
      WithGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterSharedParamsAccessSVO
            .firstWithGetterSharedParamsAccessSVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return WithGetterSharedParamsAccessSVO
            .secondWithGetterSharedParamsAccessSVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  WithGetterSharedParamsAccessMVO makeMultiValueObject(
      WithGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterSharedParamsAccessMVO
            .firstWithGetterSharedParamsAccessMVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return WithGetterSharedParamsAccessMVO
            .secondWithGetterSharedParamsAccessMVO(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  WithGetterSharedParamsAccessSE makeSimpleEntity(
      WithGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterSharedParamsAccessSE
            .firstWithGetterSharedParamsAccessSE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return WithGetterSharedParamsAccessSE
            .secondWithGetterSharedParamsAccessSE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  WithGetterSharedParamsAccessIE makeIterableEntity(
      WithGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterSharedParamsAccessIE
            .firstWithGetterSharedParamsAccessIE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return WithGetterSharedParamsAccessIE
            .secondWithGetterSharedParamsAccessIE(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }

  @override
  WithGetterSharedParamsAccessI2E makeIterable2Entity(
      WithGetterParams params, SharedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return WithGetterSharedParamsAccessI2E
            .firstWithGetterSharedParamsAccessI2E(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
      case FactoryConstructor.second:
        return WithGetterSharedParamsAccessI2E
            .secondWithGetterSharedParamsAccessI2E(
          param: params.param.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
        );
    }
  }
}

class WithGetterSharedParamsAccessTestHelper extends ModddelTestHelper<
        WithGetterParams,
        SharedSampleOptions,
        WithGetterSharedParamsAccessSVO,
        WithGetterSharedParamsAccessMVO,
        WithGetterSharedParamsAccessSE,
        WithGetterSharedParamsAccessIE,
        WithGetterSharedParamsAccessI2E>
    with ElementsSSealedTestHelperMixin, TestHelperMixin {
  WithGetterSharedParamsAccessTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
      singleValueObject: (_) => 'WithGetterSharedParamsAccessSVO',
      multiValueObject: (_) => 'WithGetterSharedParamsAccessMVO',
      simpleEntity: (_) => 'WithGetterSharedParamsAccessSE',
      iterableEntity: (_) => 'WithGetterSharedParamsAccessIE',
      iterable2Entity: (_) => 'WithGetterSharedParamsAccessI2E');

  @override
  String getSampleInstanceInvocationSrc() {
    return '$sSealedName.$caseModddelCallbackName('
        'param : ${sampleParams.param.src},'
        '\$isModddelValid : ${sampleOptions.isModddelValid},'
        '\$validateMethodShouldThrowInfos : ${sampleOptions.validateMethodShouldThrowInfos},'
        ')';
  }

  /// Returns the member parameter named "param" after accessing it from the
  /// base ssealed class.
  ///
  dynamic getParamFromBaseSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.param,
      multiValueObject: (multiValueObject) => multiValueObject.param,
      simpleEntity: (simpleEntity) => simpleEntity.param,
      iterableEntity: (iterableEntity) => iterableEntity.param,
      iterable2Entity: (iterable2Entity) => iterable2Entity.param,
    );
  }

  /// Returns the member parameter named "param" after accessing it from either
  /// the valid ssealed class or the invalid-step ssealed class (which varies
  /// depending on the validness of the [testSubject]).
  ///
  dynamic getParamFromValidOrInvalidStepSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalidValue) => invalidValue.param),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalidValue) => invalidValue.param),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalidMid) => invalidMid.param),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalidMid) => invalidMid.param),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalidMid) => invalidMid.param),
    );
  }

  /// Returns the member parameter named "param" after accessing it
  /// from the invalid ssealed class.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  dynamic getParamFromInvalidSSealedClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      multiValueObject: (multiValueObject) => multiValueObject.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      simpleEntity: (simpleEntity) => simpleEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      iterableEntity: (iterableEntity) => iterableEntity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapValidity(
          valid: (valid) => throw UnreachableError(),
          invalid: (invalid) => invalid.param),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                          Common TestHelper Mixins                          */
/* -------------------------------------------------------------------------- */

mixin TestHelperMixin<P extends SampleParamsBase, O extends SampleOptions>
    on ElementsSSealedTestHelperMixin<P, O> {
  @override
  String get caseModddelName {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return 'First$sSealedName';
      case FactoryConstructor.second:
        return 'Second$sSealedName';
    }
  }

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);

  /// Returns the source code for creating an instance of the tested modddel.
  ///
  String getSampleInstanceInvocationSrc();
}

/* -------------------------------------------------------------------------- */
/*                            Common SampleOptions                            */
/* -------------------------------------------------------------------------- */

abstract class SampleOptions extends SampleOptionsBase {
  SampleOptions(
    super.name, {
    required this.isModddelValid,
    required this.usedFactoryConstructor,
  });

  final bool isModddelValid;

  final FactoryConstructor usedFactoryConstructor;
}

class NonSharedSampleOptions extends SampleOptions {
  NonSharedSampleOptions(
    super.name, {
    required super.isModddelValid,
    required super.usedFactoryConstructor,
  });
}

class SharedSampleOptions extends SampleOptions {
  SharedSampleOptions(
    super.name, {
    required super.isModddelValid,
    required super.usedFactoryConstructor,
    required this.validateMethodShouldThrowInfos,
  });

  final bool validateMethodShouldThrowInfos;
}

/* -------------------------------------------------------------------------- */
/*                             Common SampleValues                            */
/* -------------------------------------------------------------------------- */

class WithoutGetterParams extends SampleParamsBase {
  WithoutGetterParams(this.param, this.dependency);

  final ParamWithSource param;
  final ParamWithSource<MyService> dependency;
}

class WithGetterParams extends SampleParamsBase {
  WithGetterParams(this.param);

  final ParamWithSource param;
}

final withoutGetterSampleValues1 = ModddelSampleValues<WithoutGetterParams>(
  singleValueObject: WithoutGetterParams(
    SampleValues1.paramString,
    SampleValues1.dependency,
  ),
  multiValueObject: WithoutGetterParams(
    SampleValues1.paramString,
    SampleValues1.dependency,
  ),
  simpleEntity: WithoutGetterParams(
    SampleValues1.paramModddel,
    SampleValues1.dependency,
  ),
  iterableEntity: WithoutGetterParams(
    SampleValues1.paramListModddel,
    SampleValues1.dependency,
  ),
  iterable2Entity: WithoutGetterParams(
    SampleValues1.paramMapModddel,
    SampleValues1.dependency,
  ),
);

final withGetterSampleValues1 = ModddelSampleValues<WithGetterParams>(
  singleValueObject: WithGetterParams(SampleValues1.paramString),
  multiValueObject: WithGetterParams(SampleValues1.paramString),
  simpleEntity: WithGetterParams(SampleValues1.paramModddel),
  iterableEntity: WithGetterParams(SampleValues1.paramListModddel),
  iterable2Entity: WithGetterParams(SampleValues1.paramMapModddel),
);
