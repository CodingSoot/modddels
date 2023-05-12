// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';
import 'parameters_access.dart';

// Modddels groups : SSealed modddels that have :
//
// - A. Solo modddels that have :
//   - A1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters
//   - A2 : Member parameters with the `@withGetter` annotation
// - B. SSealed modddels that have :
//   - B1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters (Not shared)
//   - B2 : Member parameters with the `@withGetter` annotation (Not shared)
//

/* -------------------------------------------------------------------------- */
/*                   TestSupports and Helpers for each group                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

class ParamsAccessSoloTestSupport extends ModddelsTestSupport<
    ParamsAccessSoloTestHelper,
    WithoutGetterParams,
    SampleOptions,
    ParamsAccessSoloSVO,
    ParamsAccessSoloMVO,
    ParamsAccessSoloSE,
    ParamsAccessSoloIE,
    ParamsAccessSoloI2E> {
  ParamsAccessSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      ParamsAccessSoloTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  ParamsAccessSoloSVO makeSingleValueObject(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSoloSVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSoloMVO makeMultiValueObject(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSoloMVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSoloSE makeSimpleEntity(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSoloSE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSoloIE makeIterableEntity(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSoloIE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSoloI2E makeIterable2Entity(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSoloI2E(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);
}

class ParamsAccessSoloTestHelper extends ModddelTestHelper<
        WithoutGetterParams,
        SampleOptions,
        ParamsAccessSoloSVO,
        ParamsAccessSoloMVO,
        ParamsAccessSoloSE,
        ParamsAccessSoloIE,
        ParamsAccessSoloI2E>
    with ElementsSoloTestHelperMixin, WithoutGetterTestHelperMixin {
  ParamsAccessSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName => testSubject.whenAll(
      singleValueObject: (_) => 'ParamsAccessSoloSVO',
      multiValueObject: (_) => 'ParamsAccessSoloMVO',
      simpleEntity: (_) => 'ParamsAccessSoloSE',
      iterableEntity: (_) => 'ParamsAccessSoloIE',
      iterable2Entity: (_) => 'ParamsAccessSoloI2E');

  @override
  String getSampleInstanceInvocationSrc() {
    return '$modddelName('
        'param : ${sampleParams.param.src},'
        'dependency : ${sampleParams.dependency.src},'
        '\$isModddelValid : ${sampleOptions.isModddelValid},'
        '\$validateMethodShouldThrowInfos : ${sampleOptions.validateMethodShouldThrowInfos},'
        ')';
  }

  /// Returns the member parameter named "param" after accessing it from a
  /// concrete union-case (which varies depending on the validness of the
  /// [testSubject]).
  ///
  dynamic getParamFromConcreteUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalid) => invalid.param),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalid) => invalid.param),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalid) => invalid.param),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalid) => invalid.param),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalid) => invalid.param),
    );
  }

  /// Returns the member parameter named "param" after accessing it from the
  /// abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  dynamic getParamFromAbstractInvalidUnionCase() {
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
  /// from the solo modddel.
  ///
  MyService getDependencyFromBaseClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.dependency,
      multiValueObject: (multiValueObject) => multiValueObject.dependency,
      simpleEntity: (simpleEntity) => simpleEntity.dependency,
      iterableEntity: (iterableEntity) => iterableEntity.dependency,
      iterable2Entity: (iterable2Entity) => iterable2Entity.dependency,
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from a concrete union-case (which varies depending on the validness of the
  /// [testSubject]).
  ///
  MyService getDependencyFromConcreteUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => valid.dependency,
          invalidValue: (invalid) => invalid.dependency),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => valid.dependency,
          invalidValue: (invalid) => invalid.dependency),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => valid.dependency,
          invalidMid: (invalid) => invalid.dependency),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => valid.dependency,
          invalidMid: (invalid) => invalid.dependency),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => valid.dependency,
          invalidMid: (invalid) => invalid.dependency),
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from the abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  MyService getDependencyFromAbstractInvalidUnionCase() {
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

/* ----------------------------------- A2 ----------------------------------- */

class WithGetterParamsAccessSoloTestSupport extends ModddelsTestSupport<
    WithGetterParamsAccessSoloTestHelper,
    WithGetterParams,
    SampleOptions,
    WithGetterParamsAccessSoloSVO,
    WithGetterParamsAccessSoloMVO,
    WithGetterParamsAccessSoloSE,
    WithGetterParamsAccessSoloIE,
    WithGetterParamsAccessSoloI2E> {
  WithGetterParamsAccessSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      WithGetterParamsAccessSoloTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  WithGetterParamsAccessSoloSVO makeSingleValueObject(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSoloSVO(
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
          param: params.param.value);

  @override
  WithGetterParamsAccessSoloMVO makeMultiValueObject(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSoloMVO(
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
          param: params.param.value);

  @override
  WithGetterParamsAccessSoloSE makeSimpleEntity(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSoloSE(
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
          param: params.param.value);

  @override
  WithGetterParamsAccessSoloIE makeIterableEntity(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSoloIE(
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
          param: params.param.value);

  @override
  WithGetterParamsAccessSoloI2E makeIterable2Entity(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSoloI2E(
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos,
          param: params.param.value);
}

class WithGetterParamsAccessSoloTestHelper extends ModddelTestHelper<
    WithGetterParams,
    SampleOptions,
    WithGetterParamsAccessSoloSVO,
    WithGetterParamsAccessSoloMVO,
    WithGetterParamsAccessSoloSE,
    WithGetterParamsAccessSoloIE,
    WithGetterParamsAccessSoloI2E> {
  WithGetterParamsAccessSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  /// Returns the member parameter named "param" after accessing it from the
  /// solo modddel.
  ///
  dynamic getParamFromBaseClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.param,
      multiValueObject: (multiValueObject) => multiValueObject.param,
      simpleEntity: (simpleEntity) => simpleEntity.param,
      iterableEntity: (iterableEntity) => iterableEntity.param,
      iterable2Entity: (iterable2Entity) => iterable2Entity.param,
    );
  }

  /// Returns the member parameter named "param" after accessing it from a
  /// concrete union-case (which varies depending on the validness of the
  /// [testSubject]).
  ///
  dynamic getParamFromConcreteUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalid) => invalid.param),
      multiValueObject: (multiValueObject) => multiValueObject.map(
          valid: (valid) => valid.param,
          invalidValue: (invalid) => invalid.param),
      simpleEntity: (simpleEntity) => simpleEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalid) => invalid.param),
      iterableEntity: (iterableEntity) => iterableEntity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalid) => invalid.param),
      iterable2Entity: (iterable2Entity) => iterable2Entity.map(
          valid: (valid) => valid.param,
          invalidMid: (invalid) => invalid.param),
    );
  }

  /// Returns the member parameter named "param" after accessing it from the
  /// abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  dynamic getParamFromAbstractInvalidUnionCase() {
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

/* ----------------------------------- B1 ----------------------------------- */

class ParamsAccessSSealedTestSupport extends ModddelsTestSupport<
    ParamsAccessSSealedTestHelper,
    WithoutGetterParams,
    SampleOptions,
    ParamsAccessSSealedSVO,
    ParamsAccessSSealedMVO,
    ParamsAccessSSealedSE,
    ParamsAccessSSealedIE,
    ParamsAccessSSealedI2E> {
  ParamsAccessSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      ParamsAccessSSealedTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  ParamsAccessSSealedSVO makeSingleValueObject(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSSealedSVO.namedParamsAccessSSealedSVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSSealedMVO makeMultiValueObject(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSSealedMVO.namedParamsAccessSSealedMVO(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSSealedSE makeSimpleEntity(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSSealedSE.namedParamsAccessSSealedSE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSSealedIE makeIterableEntity(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSSealedIE.namedParamsAccessSSealedIE(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);

  @override
  ParamsAccessSSealedI2E makeIterable2Entity(
          WithoutGetterParams params, SampleOptions sampleOptions) =>
      ParamsAccessSSealedI2E.namedParamsAccessSSealedI2E(
          param: params.param.value,
          dependency: params.dependency.value,
          $isModddelValid: sampleOptions.isModddelValid,
          $validateMethodShouldThrowInfos:
              sampleOptions.validateMethodShouldThrowInfos);
}

class ParamsAccessSSealedTestHelper extends ModddelTestHelper<
        WithoutGetterParams,
        SampleOptions,
        ParamsAccessSSealedSVO,
        ParamsAccessSSealedMVO,
        ParamsAccessSSealedSE,
        ParamsAccessSSealedIE,
        ParamsAccessSSealedI2E>
    with ElementsSSealedTestHelperMixin, WithoutGetterTestHelperMixin {
  ParamsAccessSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
      singleValueObject: (_) => 'ParamsAccessSSealedSVO',
      multiValueObject: (_) => 'ParamsAccessSSealedMVO',
      simpleEntity: (_) => 'ParamsAccessSSealedSE',
      iterableEntity: (_) => 'ParamsAccessSSealedIE',
      iterable2Entity: (_) => 'ParamsAccessSSealedI2E');

  @override
  String get caseModddelName => 'Named$sSealedName';

  @override
  String getSampleInstanceInvocationSrc() {
    return '$sSealedName.$caseModddelCallbackName('
        'param : ${sampleParams.param.src},'
        'dependency : ${sampleParams.dependency.src},'
        '\$isModddelValid : ${sampleOptions.isModddelValid},'
        '\$validateMethodShouldThrowInfos : ${sampleOptions.validateMethodShouldThrowInfos},'
        ')';
  }

  /// Returns the member parameter named "param" after accessing it from one of
  /// the case-modddel's concrete union-cases (which varies depending on the
  /// validness of the [testSubject]).
  ///
  dynamic getParamFromCaseModddelConcreteUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapParamsAccessSSealedSVO(
              namedParamsAccessSSealedSVO: (caseModddel) => caseModddel.map(
                  valid: (valid) => valid.param,
                  invalidValue: (invalid) => invalid.param)),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapParamsAccessSSealedMVO(
              namedParamsAccessSSealedMVO: (caseModddel) => caseModddel.map(
                  valid: (valid) => valid.param,
                  invalidValue: (invalid) => invalid.param)),
      simpleEntity: (simpleEntity) => simpleEntity.mapParamsAccessSSealedSE(
        namedParamsAccessSSealedSE: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidMid: (invalid) => invalid.param),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapParamsAccessSSealedIE(
        namedParamsAccessSSealedIE: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidMid: (invalid) => invalid.param),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapParamsAccessSSealedI2E(
        namedParamsAccessSSealedI2E: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidMid: (invalid) => invalid.param),
      ),
    );
  }

  /// Returns the member parameter named "param" after accessing it from the
  /// case-modddel's abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  dynamic getParamFromCaseModddelAbstractInvalidUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapParamsAccessSSealedSVO(
        namedParamsAccessSSealedSVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.param),
      ),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapParamsAccessSSealedMVO(
        namedParamsAccessSSealedMVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.param),
      ),
      simpleEntity: (simpleEntity) => simpleEntity.mapParamsAccessSSealedSE(
        namedParamsAccessSSealedSE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.param),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapParamsAccessSSealedIE(
        namedParamsAccessSSealedIE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.param),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapParamsAccessSSealedI2E(
        namedParamsAccessSSealedI2E: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.param),
      ),
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from the case-modddel's base class.
  ///
  MyService getDependencyFromCaseModddelBaseClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapParamsAccessSSealedSVO(
              namedParamsAccessSSealedSVO: (caseModddel) =>
                  caseModddel.dependency),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapParamsAccessSSealedMVO(
              namedParamsAccessSSealedMVO: (caseModddel) =>
                  caseModddel.dependency),
      simpleEntity: (simpleEntity) => simpleEntity.mapParamsAccessSSealedSE(
          namedParamsAccessSSealedSE: (caseModddel) => caseModddel.dependency),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapParamsAccessSSealedIE(
              namedParamsAccessSSealedIE: (caseModddel) =>
                  caseModddel.dependency),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapParamsAccessSSealedI2E(
              namedParamsAccessSSealedI2E: (caseModddel) =>
                  caseModddel.dependency),
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from one of the case-modddel's concrete union-cases (which varies
  /// depending on the validness of the [testSubject]).
  ///
  MyService getDependencyFromCaseModddelConcreteUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapParamsAccessSSealedSVO(
              namedParamsAccessSSealedSVO: (caseModddel) => caseModddel.map(
                  valid: (valid) => valid.dependency,
                  invalidValue: (invalid) => invalid.dependency)),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapParamsAccessSSealedMVO(
              namedParamsAccessSSealedMVO: (caseModddel) => caseModddel.map(
                  valid: (valid) => valid.dependency,
                  invalidValue: (invalid) => invalid.dependency)),
      simpleEntity: (simpleEntity) => simpleEntity.mapParamsAccessSSealedSE(
          namedParamsAccessSSealedSE: (caseModddel) => caseModddel.map(
              valid: (valid) => valid.dependency,
              invalidMid: (invalid) => invalid.dependency)),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapParamsAccessSSealedIE(
              namedParamsAccessSSealedIE: (caseModddel) => caseModddel.map(
                  valid: (valid) => valid.dependency,
                  invalidMid: (invalid) => invalid.dependency)),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapParamsAccessSSealedI2E(
              namedParamsAccessSSealedI2E: (caseModddel) => caseModddel.map(
                  valid: (valid) => valid.dependency,
                  invalidMid: (invalid) => invalid.dependency)),
    );
  }

  /// Returns the dependency parameter named "dependency" after accessing it
  /// from the case-modddel's abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  MyService getDependencyFromCaseModddelAbstractInvalidUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapParamsAccessSSealedSVO(
        namedParamsAccessSSealedSVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.dependency),
      ),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapParamsAccessSSealedMVO(
        namedParamsAccessSSealedMVO: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.dependency),
      ),
      simpleEntity: (simpleEntity) => simpleEntity.mapParamsAccessSSealedSE(
        namedParamsAccessSSealedSE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.dependency),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapParamsAccessSSealedIE(
        namedParamsAccessSSealedIE: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.dependency),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapParamsAccessSSealedI2E(
        namedParamsAccessSSealedI2E: (caseModddel) => caseModddel.mapValidity(
            valid: (valid) => throw UnreachableError(),
            invalid: (invalid) => invalid.dependency),
      ),
    );
  }
}

/* ----------------------------------- B2 ----------------------------------- */

class WithGetterParamsAccessSSealedTestSupport extends ModddelsTestSupport<
    WithGetterParamsAccessSSealedTestHelper,
    WithGetterParams,
    SampleOptions,
    WithGetterParamsAccessSSealedSVO,
    WithGetterParamsAccessSSealedMVO,
    WithGetterParamsAccessSSealedSE,
    WithGetterParamsAccessSSealedIE,
    WithGetterParamsAccessSSealedI2E> {
  WithGetterParamsAccessSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      WithGetterParamsAccessSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  WithGetterParamsAccessSSealedSVO makeSingleValueObject(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSSealedSVO.namedWithGetterParamsAccessSSealedSVO(
        param: params.param.value,
        $isModddelValid: sampleOptions.isModddelValid,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  WithGetterParamsAccessSSealedMVO makeMultiValueObject(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSSealedMVO.namedWithGetterParamsAccessSSealedMVO(
        param: params.param.value,
        $isModddelValid: sampleOptions.isModddelValid,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  WithGetterParamsAccessSSealedSE makeSimpleEntity(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSSealedSE.namedWithGetterParamsAccessSSealedSE(
        param: params.param.value,
        $isModddelValid: sampleOptions.isModddelValid,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  WithGetterParamsAccessSSealedIE makeIterableEntity(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSSealedIE.namedWithGetterParamsAccessSSealedIE(
        param: params.param.value,
        $isModddelValid: sampleOptions.isModddelValid,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  WithGetterParamsAccessSSealedI2E makeIterable2Entity(
          WithGetterParams params, SampleOptions sampleOptions) =>
      WithGetterParamsAccessSSealedI2E.namedWithGetterParamsAccessSSealedI2E(
        param: params.param.value,
        $isModddelValid: sampleOptions.isModddelValid,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );
}

class WithGetterParamsAccessSSealedTestHelper extends ModddelTestHelper<
    WithGetterParams,
    SampleOptions,
    WithGetterParamsAccessSSealedSVO,
    WithGetterParamsAccessSSealedMVO,
    WithGetterParamsAccessSSealedSE,
    WithGetterParamsAccessSSealedIE,
    WithGetterParamsAccessSSealedI2E> {
  WithGetterParamsAccessSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  /// Returns the member parameter named "param" after accessing it from the
  /// case-modddel's base class.
  ///
  dynamic getParamFromCaseModddelBaseClass() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapWithGetterParamsAccessSSealedSVO(
              namedWithGetterParamsAccessSSealedSVO: (caseModddel) =>
                  caseModddel.param),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapWithGetterParamsAccessSSealedMVO(
              namedWithGetterParamsAccessSSealedMVO: (caseModddel) =>
                  caseModddel.param),
      simpleEntity: (simpleEntity) =>
          simpleEntity.mapWithGetterParamsAccessSSealedSE(
              namedWithGetterParamsAccessSSealedSE: (caseModddel) =>
                  caseModddel.param),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapWithGetterParamsAccessSSealedIE(
              namedWithGetterParamsAccessSSealedIE: (caseModddel) =>
                  caseModddel.param),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapWithGetterParamsAccessSSealedI2E(
              namedWithGetterParamsAccessSSealedI2E: (caseModddel) =>
                  caseModddel.param),
    );
  }

  /// Returns the member parameter named "param" after accessing it from one of
  /// the case-modddel's concrete union-cases (which varies depending on the
  /// validness of the [testSubject]).
  ///
  dynamic getParamFromCaseModddelConcreteUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapWithGetterParamsAccessSSealedSVO(
        namedWithGetterParamsAccessSSealedSVO: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidValue: (invalid) => invalid.param),
      ),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapWithGetterParamsAccessSSealedMVO(
        namedWithGetterParamsAccessSSealedMVO: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidValue: (invalid) => invalid.param),
      ),
      simpleEntity: (simpleEntity) =>
          simpleEntity.mapWithGetterParamsAccessSSealedSE(
        namedWithGetterParamsAccessSSealedSE: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidMid: (invalid) => invalid.param),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapWithGetterParamsAccessSSealedIE(
        namedWithGetterParamsAccessSSealedIE: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidMid: (invalid) => invalid.param),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapWithGetterParamsAccessSSealedI2E(
        namedWithGetterParamsAccessSSealedI2E: (caseModddel) => caseModddel.map(
            valid: (valid) => valid.param,
            invalidMid: (invalid) => invalid.param),
      ),
    );
  }

  /// Returns the member parameter named "param" after accessing it from the
  /// case-modddel's abstract invalid union-case.
  ///
  /// NB : This should only be called if the [testSubject] is invalid, otherwise
  /// throws an [UnreachableError].
  ///
  dynamic getParamFromCaseModddelAbstractInvalidUnionCase() {
    return testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapWithGetterParamsAccessSSealedSVO(
        namedWithGetterParamsAccessSSealedSVO: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.param),
      ),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapWithGetterParamsAccessSSealedMVO(
        namedWithGetterParamsAccessSSealedMVO: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.param),
      ),
      simpleEntity: (simpleEntity) =>
          simpleEntity.mapWithGetterParamsAccessSSealedSE(
        namedWithGetterParamsAccessSSealedSE: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.param),
      ),
      iterableEntity: (iterableEntity) =>
          iterableEntity.mapWithGetterParamsAccessSSealedIE(
        namedWithGetterParamsAccessSSealedIE: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.param),
      ),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapWithGetterParamsAccessSSealedI2E(
        namedWithGetterParamsAccessSSealedI2E: (caseModddel) =>
            caseModddel.mapValidity(
                valid: (valid) => throw UnreachableError(),
                invalid: (invalid) => invalid.param),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                          Common TestHelper Mixins                          */
/* -------------------------------------------------------------------------- */

mixin WithoutGetterTestHelperMixin<P extends SampleParamsBase,
    O extends SampleOptions> on TestHelperBase<P, O> {
  /// Overrides [ElementsSoloTestHelperMixin.vStepsNames] /
  /// [ElementsSSealedTestHelperMixin.vStepsNames].
  ///
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);

  /// Returns the source code for creating an instance of the tested modddel.
  ///
  String getSampleInstanceInvocationSrc();
}

/* -------------------------------------------------------------------------- */
/*                            Common SampleOptions                            */
/* -------------------------------------------------------------------------- */

class SampleOptions extends SampleOptionsBase {
  SampleOptions(
    super.name, {
    required this.isModddelValid,
    required this.validateMethodShouldThrowInfos,
  });

  final bool isModddelValid;
  final bool validateMethodShouldThrowInfos;
}

/* -------------------------------------------------------------------------- */
/*                             Common SampleValues                            */
/* -------------------------------------------------------------------------- */

class WithoutGetterParams extends SampleParamsBase {
  WithoutGetterParams(this.param, this.dependency);

  final ParamWithSource param;
  final ParamWithSource dependency;
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
