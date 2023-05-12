import 'package:collection/collection.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:checks/checks.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';
import 'validation.dart';

// Modddels groups :
//
// - A1. Solo modddels with one validationStep
// - A2. Solo modddels with two validationSteps
// - B1. SSealed modddels with one validationStep
// - B2. SSealed modddels with two validationSteps
//

/* -------------------------------------------------------------------------- */
/*                   TestSupports and Helpers for each group                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

class OneVStepSoloTestSupport extends ModddelsTestSupport<
    OneVStepSoloTestHelper,
    SampleParams,
    OneVStepSoloSampleOptions,
    OneVStepSoloSVO,
    OneVStepSoloMVO,
    OneVStepSoloSE,
    OneVStepSoloIE,
    OneVStepSoloI2E> {
  OneVStepSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      OneVStepSoloTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  OneVStepSoloSVO makeSingleValueObject(
          SampleParams params, OneVStepSoloSampleOptions sampleOptions) =>
      OneVStepSoloSVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses);

  @override
  OneVStepSoloMVO makeMultiValueObject(
          SampleParams params, OneVStepSoloSampleOptions sampleOptions) =>
      OneVStepSoloMVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses);

  @override
  OneVStepSoloSE makeSimpleEntity(
          SampleParams params, OneVStepSoloSampleOptions sampleOptions) =>
      OneVStepSoloSE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses);

  @override
  OneVStepSoloIE makeIterableEntity(
          SampleParams params, OneVStepSoloSampleOptions sampleOptions) =>
      OneVStepSoloIE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses);

  @override
  OneVStepSoloI2E makeIterable2Entity(
          SampleParams params, OneVStepSoloSampleOptions sampleOptions) =>
      OneVStepSoloI2E(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses);
}

class OneVStepSoloTestHelper extends ModddelTestHelper<
        SampleParams,
        OneVStepSoloSampleOptions,
        OneVStepSoloSVO,
        OneVStepSoloMVO,
        OneVStepSoloSE,
        OneVStepSoloIE,
        OneVStepSoloI2E>
    with TestHelperMixin, ElementsSoloTestHelperMixin, SoloTestHelperMixin {
  OneVStepSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName => testSubject.whenAll(
        singleValueObject: (_) => 'OneVStepSoloSVO',
        multiValueObject: (_) => 'OneVStepSoloMVO',
        simpleEntity: (_) => 'OneVStepSoloSE',
        iterableEntity: (_) => 'OneVStepSoloIE',
        iterable2Entity: (_) => 'OneVStepSoloI2E',
      );

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);

  @override
  void checkAllToEitherGettersResults({
    required bool isModddelValid,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    testSubject.whenAll(
        singleValueObject: (modddel) => _checkToEitherGettersResults<
                InvalidOneVStepSoloSVO, ValidOneVStepSoloSVO>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        multiValueObject: (modddel) => _checkToEitherGettersResults<
                InvalidOneVStepSoloMVO, ValidOneVStepSoloMVO>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        simpleEntity: (modddel) => _checkToEitherGettersResults<
                InvalidOneVStepSoloSE, ValidOneVStepSoloSE>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        iterableEntity: (modddel) => _checkToEitherGettersResults<
                InvalidOneVStepSoloIE, ValidOneVStepSoloIE>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        iterable2Entity: (modddel) => _checkToEitherGettersResults<
                InvalidOneVStepSoloI2E, ValidOneVStepSoloI2E>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ));
  }
}

class OneVStepSoloSampleOptions extends SampleOptionsBase
    with OneVStepSampleOptions {
  OneVStepSoloSampleOptions(
    super.name, {
    required this.lengthValidationPasses,
  });

  @override
  final bool lengthValidationPasses;
}

/* ----------------------------------- A2 ----------------------------------- */

class MultipleVStepsSoloTestSupport extends ModddelsTestSupport<
    MultipleVStepsSoloTestHelper,
    SampleParams,
    MultipleVStepsSoloSampleOptions,
    MultipleVStepsSoloSVO,
    MultipleVStepsSoloMVO,
    MultipleVStepsSoloSE,
    MultipleVStepsSoloIE,
    MultipleVStepsSoloI2E> {
  MultipleVStepsSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      MultipleVStepsSoloTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  MultipleVStepsSoloSVO makeSingleValueObject(
          SampleParams params, MultipleVStepsSoloSampleOptions sampleOptions) =>
      MultipleVStepsSoloSVO(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  MultipleVStepsSoloMVO makeMultiValueObject(
          SampleParams params, MultipleVStepsSoloSampleOptions sampleOptions) =>
      MultipleVStepsSoloMVO(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  MultipleVStepsSoloSE makeSimpleEntity(
          SampleParams params, MultipleVStepsSoloSampleOptions sampleOptions) =>
      MultipleVStepsSoloSE(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  MultipleVStepsSoloIE makeIterableEntity(
          SampleParams params, MultipleVStepsSoloSampleOptions sampleOptions) =>
      MultipleVStepsSoloIE(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );

  @override
  MultipleVStepsSoloI2E makeIterable2Entity(
          SampleParams params, MultipleVStepsSoloSampleOptions sampleOptions) =>
      MultipleVStepsSoloI2E(
        param: params.param.value,
        $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        $sizeValidationPasses: sampleOptions.sizeValidationPasses,
        $formatValidationPasses: sampleOptions.formatValidationPasses,
      );
}

class MultipleVStepsSoloTestHelper extends ModddelTestHelper<
        SampleParams,
        MultipleVStepsSoloSampleOptions,
        MultipleVStepsSoloSVO,
        MultipleVStepsSoloMVO,
        MultipleVStepsSoloSE,
        MultipleVStepsSoloIE,
        MultipleVStepsSoloI2E>
    with TestHelperMixin, ElementsSoloTestHelperMixin, SoloTestHelperMixin {
  MultipleVStepsSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName => testSubject.whenAll(
        singleValueObject: (_) => 'MultipleVStepsSoloSVO',
        multiValueObject: (_) => 'MultipleVStepsSoloMVO',
        simpleEntity: (_) => 'MultipleVStepsSoloSE',
        iterableEntity: (_) => 'MultipleVStepsSoloIE',
        iterable2Entity: (_) => 'MultipleVStepsSoloI2E',
      );

  @override
  List<String> get vStepsNames => testSubject.map(
      valueObject: (_) => ['Value1', 'Value2'], entity: (_) => ['Mid', 'Late']);

  @override
  void checkAllToEitherGettersResults({
    required bool isModddelValid,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    testSubject.whenAll(
        singleValueObject: (modddel) => _checkToEitherGettersResults<
                InvalidMultipleVStepsSoloSVO, ValidMultipleVStepsSoloSVO>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        multiValueObject: (modddel) => _checkToEitherGettersResults<
                InvalidMultipleVStepsSoloMVO, ValidMultipleVStepsSoloMVO>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        simpleEntity: (modddel) => _checkToEitherGettersResults<
                InvalidMultipleVStepsSoloSE, ValidMultipleVStepsSoloSE>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        iterableEntity: (modddel) => _checkToEitherGettersResults<
                InvalidMultipleVStepsSoloIE, ValidMultipleVStepsSoloIE>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ),
        iterable2Entity: (modddel) => _checkToEitherGettersResults<
                InvalidMultipleVStepsSoloI2E, ValidMultipleVStepsSoloI2E>(
              baseModddel.toEither,
              modddel.toEither,
              isModddelValid: isModddelValid,
            ));
  }
}

class MultipleVStepsSoloSampleOptions extends SampleOptionsBase
    with MultipleVStepsSampleOptions {
  MultipleVStepsSoloSampleOptions(
    super.name, {
    required this.lengthValidationPasses,
    required this.sizeValidationPasses,
    required this.formatValidationPasses,
  });

  @override
  final bool lengthValidationPasses;

  @override
  final bool sizeValidationPasses;

  @override
  final bool formatValidationPasses;
}

/* ----------------------------------- B1 ----------------------------------- */

class OneVStepSSealedTestSupport extends ModddelsTestSupport<
    OneVStepSSealedTestHelper,
    SampleParams,
    OneVStepSSealedSampleOptions,
    OneVStepSSealedSVO,
    OneVStepSSealedMVO,
    OneVStepSSealedSE,
    OneVStepSSealedIE,
    OneVStepSSealedI2E> {
  OneVStepSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      OneVStepSSealedTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  OneVStepSSealedSVO makeSingleValueObject(
      SampleParams params, OneVStepSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneVStepSSealedSVO.firstOneVStepSSealedSVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return OneVStepSSealedSVO.secondOneVStepSSealedSVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }

  @override
  OneVStepSSealedMVO makeMultiValueObject(
      SampleParams params, OneVStepSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneVStepSSealedMVO.firstOneVStepSSealedMVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return OneVStepSSealedMVO.secondOneVStepSSealedMVO(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }

  @override
  OneVStepSSealedSE makeSimpleEntity(
      SampleParams params, OneVStepSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneVStepSSealedSE.firstOneVStepSSealedSE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return OneVStepSSealedSE.secondOneVStepSSealedSE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }

  @override
  OneVStepSSealedIE makeIterableEntity(
      SampleParams params, OneVStepSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneVStepSSealedIE.firstOneVStepSSealedIE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return OneVStepSSealedIE.secondOneVStepSSealedIE(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }

  @override
  OneVStepSSealedI2E makeIterable2Entity(
      SampleParams params, OneVStepSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return OneVStepSSealedI2E.firstOneVStepSSealedI2E(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
      case FactoryConstructor.second:
        return OneVStepSSealedI2E.secondOneVStepSSealedI2E(
          param: params.param.value,
          $lengthValidationPasses: sampleOptions.lengthValidationPasses,
        );
    }
  }
}

class OneVStepSSealedTestHelper extends ModddelTestHelper<
        SampleParams,
        OneVStepSSealedSampleOptions,
        OneVStepSSealedSVO,
        OneVStepSSealedMVO,
        OneVStepSSealedSE,
        OneVStepSSealedIE,
        OneVStepSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin {
  OneVStepSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
        singleValueObject: (_) => 'OneVStepSSealedSVO',
        multiValueObject: (_) => 'OneVStepSSealedMVO',
        simpleEntity: (_) => 'OneVStepSSealedSE',
        iterableEntity: (_) => 'OneVStepSSealedIE',
        iterable2Entity: (_) => 'OneVStepSSealedI2E',
      );

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);

  @override
  void checkAllIsValidGettersResults({
    required bool isModddelValid,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;
    check(baseModddel.isValid).equals(isModddelValid);

    testSubject.whenAll(
      singleValueObject: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapOneVStepSSealedSVO(
          firstOneVStepSSealedSVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondOneVStepSSealedSVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      multiValueObject: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapOneVStepSSealedMVO(
          firstOneVStepSSealedMVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondOneVStepSSealedMVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      simpleEntity: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapOneVStepSSealedSE(
          firstOneVStepSSealedSE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondOneVStepSSealedSE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      iterableEntity: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapOneVStepSSealedIE(
          firstOneVStepSSealedIE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondOneVStepSSealedIE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      iterable2Entity: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapOneVStepSSealedI2E(
          firstOneVStepSSealedI2E: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondOneVStepSSealedI2E: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
    );
  }

  @override
  void checkAllToEitherGettersResults({
    required bool isModddelValid,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    testSubject.whenAll(
      singleValueObject: (sSealedModddel) =>
          sSealedModddel.mapOneVStepSSealedSVO(
        firstOneVStepSSealedSVO: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedSVO,
                ValidOneVStepSSealedSVO,
                InvalidFirstOneVStepSSealedSVO,
                ValidFirstOneVStepSSealedSVO>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
        secondOneVStepSSealedSVO: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedSVO,
                ValidOneVStepSSealedSVO,
                InvalidSecondOneVStepSSealedSVO,
                ValidSecondOneVStepSSealedSVO>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
      ),
      multiValueObject: (sSealedModddel) =>
          sSealedModddel.mapOneVStepSSealedMVO(
        firstOneVStepSSealedMVO: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedMVO,
                ValidOneVStepSSealedMVO,
                InvalidFirstOneVStepSSealedMVO,
                ValidFirstOneVStepSSealedMVO>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
        secondOneVStepSSealedMVO: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedMVO,
                ValidOneVStepSSealedMVO,
                InvalidSecondOneVStepSSealedMVO,
                ValidSecondOneVStepSSealedMVO>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
      ),
      simpleEntity: (sSealedModddel) => sSealedModddel.mapOneVStepSSealedSE(
        firstOneVStepSSealedSE: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedSE,
                ValidOneVStepSSealedSE,
                InvalidFirstOneVStepSSealedSE,
                ValidFirstOneVStepSSealedSE>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
        secondOneVStepSSealedSE: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedSE,
                ValidOneVStepSSealedSE,
                InvalidSecondOneVStepSSealedSE,
                ValidSecondOneVStepSSealedSE>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
      ),
      iterableEntity: (sSealedModddel) => sSealedModddel.mapOneVStepSSealedIE(
        firstOneVStepSSealedIE: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedIE,
                ValidOneVStepSSealedIE,
                InvalidFirstOneVStepSSealedIE,
                ValidFirstOneVStepSSealedIE>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
        secondOneVStepSSealedIE: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedIE,
                ValidOneVStepSSealedIE,
                InvalidSecondOneVStepSSealedIE,
                ValidSecondOneVStepSSealedIE>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
      ),
      iterable2Entity: (sSealedModddel) => sSealedModddel.mapOneVStepSSealedI2E(
        firstOneVStepSSealedI2E: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedI2E,
                ValidOneVStepSSealedI2E,
                InvalidFirstOneVStepSSealedI2E,
                ValidFirstOneVStepSSealedI2E>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
        secondOneVStepSSealedI2E: (caseModddel) => _checkToEitherGetterResults<
                InvalidOneVStepSSealedI2E,
                ValidOneVStepSSealedI2E,
                InvalidSecondOneVStepSSealedI2E,
                ValidSecondOneVStepSSealedI2E>(
            baseModddel.toEither, sSealedModddel.toEither, caseModddel.toEither,
            isModddelValid: isModddelValid),
      ),
    );
  }
}

class OneVStepSSealedSampleOptions extends SampleOptionsBase
    with OneVStepSampleOptions, SSealedSampleOptions {
  OneVStepSSealedSampleOptions(
    super.name, {
    required this.usedFactoryConstructor,
    required this.lengthValidationPasses,
  });

  @override
  final FactoryConstructor usedFactoryConstructor;

  @override
  final bool lengthValidationPasses;
}

/* ----------------------------------- B2 ----------------------------------- */

class MultipleVStepsSSealedTestSupport extends ModddelsTestSupport<
    MultipleVStepsSSealedTestHelper,
    SampleParams,
    MultipleVStepsSSealedSampleOptions,
    MultipleVStepsSSealedSVO,
    MultipleVStepsSSealedMVO,
    MultipleVStepsSSealedSE,
    MultipleVStepsSSealedIE,
    MultipleVStepsSSealedI2E> {
  MultipleVStepsSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      MultipleVStepsSSealedTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  MultipleVStepsSSealedSVO makeSingleValueObject(
      SampleParams params, MultipleVStepsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleVStepsSSealedSVO.firstMultipleVStepsSSealedSVO(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
      case FactoryConstructor.second:
        return MultipleVStepsSSealedSVO.secondMultipleVStepsSSealedSVO(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
    }
  }

  @override
  MultipleVStepsSSealedMVO makeMultiValueObject(
      SampleParams params, MultipleVStepsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleVStepsSSealedMVO.firstMultipleVStepsSSealedMVO(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
      case FactoryConstructor.second:
        return MultipleVStepsSSealedMVO.secondMultipleVStepsSSealedMVO(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
    }
  }

  @override
  MultipleVStepsSSealedSE makeSimpleEntity(
      SampleParams params, MultipleVStepsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleVStepsSSealedSE.firstMultipleVStepsSSealedSE(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
      case FactoryConstructor.second:
        return MultipleVStepsSSealedSE.secondMultipleVStepsSSealedSE(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
    }
  }

  @override
  MultipleVStepsSSealedIE makeIterableEntity(
      SampleParams params, MultipleVStepsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleVStepsSSealedIE.firstMultipleVStepsSSealedIE(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
      case FactoryConstructor.second:
        return MultipleVStepsSSealedIE.secondMultipleVStepsSSealedIE(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
    }
  }

  @override
  MultipleVStepsSSealedI2E makeIterable2Entity(
      SampleParams params, MultipleVStepsSSealedSampleOptions sampleOptions) {
    switch (sampleOptions.usedFactoryConstructor) {
      case FactoryConstructor.first:
        return MultipleVStepsSSealedI2E.firstMultipleVStepsSSealedI2E(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
      case FactoryConstructor.second:
        return MultipleVStepsSSealedI2E.secondMultipleVStepsSSealedI2E(
            param: params.param.value,
            $lengthValidationPasses: sampleOptions.lengthValidationPasses,
            $sizeValidationPasses: sampleOptions.sizeValidationPasses,
            $formatValidationPasses: sampleOptions.formatValidationPasses);
    }
  }
}

class MultipleVStepsSSealedTestHelper extends ModddelTestHelper<
        SampleParams,
        MultipleVStepsSSealedSampleOptions,
        MultipleVStepsSSealedSVO,
        MultipleVStepsSSealedMVO,
        MultipleVStepsSSealedSE,
        MultipleVStepsSSealedIE,
        MultipleVStepsSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin {
  MultipleVStepsSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName => testSubject.whenAll(
        singleValueObject: (_) => 'MultipleVStepsSSealedSVO',
        multiValueObject: (_) => 'MultipleVStepsSSealedMVO',
        simpleEntity: (_) => 'MultipleVStepsSSealedSE',
        iterableEntity: (_) => 'MultipleVStepsSSealedIE',
        iterable2Entity: (_) => 'MultipleVStepsSSealedI2E',
      );

  @override
  List<String> get vStepsNames => testSubject.map(
      valueObject: (_) => ['Value1', 'Value2'], entity: (_) => ['Mid', 'Late']);

  @override
  void checkAllIsValidGettersResults({
    required bool isModddelValid,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;
    check(baseModddel.isValid).equals(isModddelValid);

    testSubject.whenAll(
      singleValueObject: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapMultipleVStepsSSealedSVO(
          firstMultipleVStepsSSealedSVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondMultipleVStepsSSealedSVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      multiValueObject: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapMultipleVStepsSSealedMVO(
          firstMultipleVStepsSSealedMVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondMultipleVStepsSSealedMVO: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      simpleEntity: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapMultipleVStepsSSealedSE(
          firstMultipleVStepsSSealedSE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondMultipleVStepsSSealedSE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      iterableEntity: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapMultipleVStepsSSealedIE(
          firstMultipleVStepsSSealedIE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondMultipleVStepsSSealedIE: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
      iterable2Entity: (sSealedModddel) {
        check(sSealedModddel.isValid).equals(isModddelValid);

        sSealedModddel.mapMultipleVStepsSSealedI2E(
          firstMultipleVStepsSSealedI2E: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
          secondMultipleVStepsSSealedI2E: (caseModddel) =>
              check(caseModddel.isValid).equals(isModddelValid),
        );
      },
    );
  }

  @override
  void checkAllToEitherGettersResults({
    required bool isModddelValid,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;

    testSubject.whenAll(
      singleValueObject: (sSealedModddel) =>
          sSealedModddel.mapMultipleVStepsSSealedSVO(
        firstMultipleVStepsSSealedSVO: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedSVO,
                    ValidMultipleVStepsSSealedSVO,
                    InvalidFirstMultipleVStepsSSealedSVO,
                    ValidFirstMultipleVStepsSSealedSVO>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
        secondMultipleVStepsSSealedSVO: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedSVO,
                    ValidMultipleVStepsSSealedSVO,
                    InvalidSecondMultipleVStepsSSealedSVO,
                    ValidSecondMultipleVStepsSSealedSVO>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
      ),
      multiValueObject: (sSealedModddel) =>
          sSealedModddel.mapMultipleVStepsSSealedMVO(
        firstMultipleVStepsSSealedMVO: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedMVO,
                    ValidMultipleVStepsSSealedMVO,
                    InvalidFirstMultipleVStepsSSealedMVO,
                    ValidFirstMultipleVStepsSSealedMVO>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
        secondMultipleVStepsSSealedMVO: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedMVO,
                    ValidMultipleVStepsSSealedMVO,
                    InvalidSecondMultipleVStepsSSealedMVO,
                    ValidSecondMultipleVStepsSSealedMVO>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
      ),
      simpleEntity: (sSealedModddel) =>
          sSealedModddel.mapMultipleVStepsSSealedSE(
        firstMultipleVStepsSSealedSE: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedSE,
                    ValidMultipleVStepsSSealedSE,
                    InvalidFirstMultipleVStepsSSealedSE,
                    ValidFirstMultipleVStepsSSealedSE>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
        secondMultipleVStepsSSealedSE: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedSE,
                    ValidMultipleVStepsSSealedSE,
                    InvalidSecondMultipleVStepsSSealedSE,
                    ValidSecondMultipleVStepsSSealedSE>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
      ),
      iterableEntity: (sSealedModddel) =>
          sSealedModddel.mapMultipleVStepsSSealedIE(
        firstMultipleVStepsSSealedIE: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedIE,
                    ValidMultipleVStepsSSealedIE,
                    InvalidFirstMultipleVStepsSSealedIE,
                    ValidFirstMultipleVStepsSSealedIE>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
        secondMultipleVStepsSSealedIE: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedIE,
                    ValidMultipleVStepsSSealedIE,
                    InvalidSecondMultipleVStepsSSealedIE,
                    ValidSecondMultipleVStepsSSealedIE>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
      ),
      iterable2Entity: (sSealedModddel) =>
          sSealedModddel.mapMultipleVStepsSSealedI2E(
        firstMultipleVStepsSSealedI2E: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedI2E,
                    ValidMultipleVStepsSSealedI2E,
                    InvalidFirstMultipleVStepsSSealedI2E,
                    ValidFirstMultipleVStepsSSealedI2E>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
        secondMultipleVStepsSSealedI2E: (caseModddel) =>
            _checkToEitherGetterResults<
                    InvalidMultipleVStepsSSealedI2E,
                    ValidMultipleVStepsSSealedI2E,
                    InvalidSecondMultipleVStepsSSealedI2E,
                    ValidSecondMultipleVStepsSSealedI2E>(baseModddel.toEither,
                sSealedModddel.toEither, caseModddel.toEither,
                isModddelValid: isModddelValid),
      ),
    );
  }
}

class MultipleVStepsSSealedSampleOptions extends SampleOptionsBase
    with MultipleVStepsSampleOptions, SSealedSampleOptions {
  MultipleVStepsSSealedSampleOptions(
    super.name, {
    required this.usedFactoryConstructor,
    required this.lengthValidationPasses,
    required this.sizeValidationPasses,
    required this.formatValidationPasses,
  });

  @override
  final FactoryConstructor usedFactoryConstructor;

  @override
  final bool lengthValidationPasses;

  @override
  final bool sizeValidationPasses;

  @override
  final bool formatValidationPasses;
}

/* -------------------------------------------------------------------------- */
/*                          Common TestHelper Mixins                          */
/* -------------------------------------------------------------------------- */

mixin TestHelperMixin<P extends SampleParamsBase, O extends SampleOptionsBase>
    on TestHelperBase<P, O> {
  /// See [ElementsSoloTestHelperMixin.vStepsNames] /
  /// [ElementsSSealedTestHelperMixin.vStepsNames].
  ///
  List<String> get vStepsNames;

  /// Checks that the provided [invalidStepsClasses] list contains exactly
  /// one class, which name is [invalidStepClassName].
  ///
  void checkIsOneInvalidVStepClass(
    List<InterfaceElement> invalidStepsClasses,
    String invalidStepClassName,
  ) {
    check(invalidStepsClasses)
      ..length.equals(1)
      ..single
          .has((element) => element.name, 'name')
          .equals(invalidStepClassName);
  }

  /// Checks that the provided [invalidStepsClasses] list contains the same
  /// number of classes as the [invalidStepClassesNames] list, and that each
  /// class in the [invalidStepsClasses] list has a name that corresponds
  /// exactly to an element in the [invalidStepClassesNames] list.
  ///
  void checkIsMultipleInvalidVStepsClasses(
    List<InterfaceElement> invalidStepsClasses,
    List<String> invalidStepClassesNames,
  ) {
    check(invalidStepsClasses)
      ..length.equals(vStepsNames.length)
      ..pairwiseComparesTo(
          invalidStepClassesNames,
          (invalidStepClassName) => it()
            ..has((element) => element.name, 'name')
                .equals(invalidStepClassName),
          'has name that equals the invalidStep class name');
  }

  /// Checks the [either] object, which is of type `Either<I, V>`, where:
  ///
  /// - [I] is the type of the Left side of the Either.
  /// - [V] is the type of the Right side of the Either.
  /// - [L] is the type of the value actually held in the Left side.
  /// - [R] is the type of the value actually held in the Right side.
  ///
  /// Depending on the [isModddelValid] flag, it checks whether the [either]
  /// object is an instance of `Right<I, V>` with the Right value being of type
  /// [R], or an instance of `Left<I, V>` with the Left value being of type [L].
  ///
  void _checkEither<I extends InvalidModddel, V extends ValidModddel,
      L extends I, R extends V>(
    Either<I, V> either, {
    required bool isModddelValid,
  }) {
    isModddelValid
        ? check(either)
            .isA<Right<I, V>>()
            .has((right) => right.value, 'right value')
            .isA<R>()
        : check(either)
            .isA<Left<I, V>>()
            .has((left) => left.value, 'left value')
            .isA<L>();
  }
}

mixin SoloTestHelperMixin<P extends SampleParamsBase,
        O extends SampleOptionsBase>
    on TestHelperMixin<P, O>, ElementsSoloTestHelperMixin<P, O> {
  List<String> get invalidStepUnionCasesNames => vStepsNames
      .mapIndexed((index, vStepName) => getInvalidStepUnionCaseName(index))
      .toList();

  /// Returns the generated invalid-step union-cases, without relying on their
  /// names.
  List<ClassElement> getAllGeneratedInvalidStepUnionCases(
      LibraryElement library) {
    return library.topLevelElements
        .whereType<ClassElement>()
        .where((element) =>
            element.name.startsWith(invalidAbstractUnionCaseName) &&
            element.name != invalidAbstractUnionCaseName)
        .toList();
  }

  /// Checks the [baseModddelEither] and [soloModddelEither] objects using
  /// [_checkEither], ensuring they have the correct types and hold the correct
  /// value based on the [isModddelValid] flag.
  ///
  /// [baseModddelEither] is the result of calling `toEither` on the
  /// [BaseModddel] level. [soloModddelEither] is the result of calling
  /// `toEither` on the modddel.
  ///
  void _checkToEitherGettersResults<MI extends InvalidModddel,
      MV extends ValidModddel>(
    Either<InvalidModddel, ValidModddel> baseModddelEither,
    Either<MI, MV> soloModddelEither, {
    required bool isModddelValid,
  }) {
    _checkEither<InvalidModddel, ValidModddel, MI, MV>(
      baseModddelEither,
      isModddelValid: isModddelValid,
    );

    _checkEither<MI, MV, MI, MV>(
      soloModddelEither,
      isModddelValid: isModddelValid,
    );
  }

  /// Checks that calling the `toEither` getter on all possible levels
  /// ([BaseModddel] and the solo modddel) returns the expected
  /// values based on the [isModddelValid] flag.
  ///
  void checkAllToEitherGettersResults({required bool isModddelValid});

  /// Checks that calling the `isValid` getter on all possible levels
  /// ([BaseModddel] and the solo modddel) returns the expected values based on
  /// the [isModddelValid] flag.
  ///
  void checkAllIsValidGettersResults({
    required bool isModddelValid,
  }) {
    final BaseModddel baseModddel = testSubject.modddel;
    check(baseModddel.isValid).equals(isModddelValid);

    testSubject.whenAll(
      singleValueObject: (modddel) =>
          check(modddel.isValid).equals(isModddelValid),
      multiValueObject: (modddel) =>
          check(modddel.isValid).equals(isModddelValid),
      simpleEntity: (modddel) => check(modddel.isValid).equals(isModddelValid),
      iterableEntity: (modddel) =>
          check(modddel.isValid).equals(isModddelValid),
      iterable2Entity: (modddel) =>
          check(modddel.isValid).equals(isModddelValid),
    );
  }
}

mixin SSealedTestHelperMixin<P extends SampleParamsBase,
        O extends SSealedSampleOptions>
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

  List<String> get sSealedInvalidStepsMixinsNames => vStepsNames
      .mapIndexed((index, vStepName) => getSSealedInvalidStepMixinName(index))
      .toList();

  List<String> get modddelInvalidStepUnionCasesNames => vStepsNames
      .mapIndexed(
          (index, vStepName) => getModddelInvalidStepUnionCaseName(index))
      .toList();

  /// Returns the generated ssealed invalid-step mixins, without relying on
  /// their names.
  ///
  List<MixinElement> getAllGeneratedSSealedInvalidStepsMixins(
      LibraryElement library) {
    return library.topLevelElements
        .whereType<MixinElement>()
        .where((element) =>
            element.name.startsWith(sSealedInvalidMixinName) &&
            element.name != sSealedInvalidMixinName)
        .toList();
  }

  /// Returns the generated modddel invalid-step union-cases, without relying on
  /// their names.
  ///
  List<ClassElement> getAllGeneratedModddelInvalidStepUnionCases(
      LibraryElement library) {
    return library.topLevelElements
        .whereType<ClassElement>()
        .where((element) =>
            element.name.startsWith(modddelInvalidAbstractUnionCaseName) &&
            element.name != modddelInvalidAbstractUnionCaseName)
        .toList();
  }

  /// Checks the [baseModddelEither], [sSealedModddelEither] and
  /// [caseModddelEither] objects using [_checkEither], ensuring they have the
  /// correct types and hold the correct value based on the [isModddelValid]
  /// flag.
  ///
  /// [baseModddelEither] is the result of calling `toEither` on the baseModddel
  /// level. [sSealedModddelEither] is the result of calling `toEither` on the
  /// ssealed modddel level. [caseModddelEither] is the result of calling
  /// `toEither` on the case-modddel.
  ///
  void _checkToEitherGetterResults<SI extends InvalidModddel,
      SV extends ValidModddel, CI extends SI, CV extends SV>(
    Either<InvalidModddel, ValidModddel> baseModddelEither,
    Either<SI, SV> sSealedModddelEither,
    Either<CI, CV> caseModddelEither, {
    required bool isModddelValid,
  }) {
    _checkEither<InvalidModddel, ValidModddel, CI, CV>(
      baseModddelEither,
      isModddelValid: isModddelValid,
    );
    _checkEither<SI, SV, CI, CV>(
      sSealedModddelEither,
      isModddelValid: isModddelValid,
    );
    _checkEither<CI, CV, CI, CV>(
      caseModddelEither,
      isModddelValid: isModddelValid,
    );
  }

  /// Checks that calling the `toEither` getter on all possible levels
  /// ([BaseModddel], ssealed modddel and case-modddel) returns the expected
  /// values based on the [isModddelValid] flag.
  ///
  void checkAllToEitherGettersResults({required bool isModddelValid});

  /// Checks that calling the `isValid` getter on all possible levels
  /// ([BaseModddel], ssealed modddel and case-modddel) returns the expected
  /// values based on the [isModddelValid] flag.
  ///
  void checkAllIsValidGettersResults({required bool isModddelValid});
}

/* -------------------------------------------------------------------------- */
/*                         Common SampleOptions Mixins                        */
/* -------------------------------------------------------------------------- */

mixin OneVStepSampleOptions on SampleOptionsBase {
  bool get lengthValidationPasses;
}

mixin MultipleVStepsSampleOptions on SampleOptionsBase {
  bool get lengthValidationPasses;

  bool get sizeValidationPasses;

  bool get formatValidationPasses;
}

mixin SSealedSampleOptions on SampleOptionsBase {
  FactoryConstructor get usedFactoryConstructor;
}

/* -------------------------------------------------------------------------- */
/*                             Common SampleValues                            */
/* -------------------------------------------------------------------------- */

class SampleParams extends SampleParamsBase {
  SampleParams(this.param);

  final ParamWithSource param;
}

/// These sampleValues ensure entities always pass the contentValidation step.
///
final sampleValues = ModddelSampleValues<SampleParams>(
  singleValueObject: SampleParams(AlwaysValidSampleValues.paramInt),
  multiValueObject: SampleParams(AlwaysValidSampleValues.paramInt),
  simpleEntity: SampleParams(AlwaysValidSampleValues.paramModddel),
  iterableEntity: SampleParams(AlwaysValidSampleValues.paramListModddel),
  iterable2Entity: SampleParams(AlwaysValidSampleValues.paramMapModddel),
);
