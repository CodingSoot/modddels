import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';
import 'members_access.dart';

// Modddels groups :
//
// - A1. Solo modddels created with the private constructor
// - A2. Solo modddels created with the factory constructor
// - B1. SSealed modddels created with the private constructor
// - B2. SSealed modddels created with the factory constructor
//

/* -------------------------------------------------------------------------- */
/*                   TestSupports and Helpers for each group                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

class PrivateConstructorMembersAccessSoloTestSupport
    extends ModddelsTestSupport<
        PrivateConstructorMembersAccessSoloTestHelper,
        NoSampleParams,
        NoSampleOptions,
        MembersAccessSoloSVO,
        MembersAccessSoloMVO,
        MembersAccessSoloSE,
        MembersAccessSoloIE,
        MembersAccessSoloI2E> {
  PrivateConstructorMembersAccessSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      PrivateConstructorMembersAccessSoloTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  MembersAccessSoloSVO makeSingleValueObject(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSoloSVO.privateConstructor();

  @override
  MembersAccessSoloMVO makeMultiValueObject(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSoloMVO.privateConstructor();

  @override
  MembersAccessSoloSE makeSimpleEntity(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSoloSE.privateConstructor();

  @override
  MembersAccessSoloIE makeIterableEntity(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSoloIE.privateConstructor();

  @override
  MembersAccessSoloI2E makeIterable2Entity(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSoloI2E.privateConstructor();
}

class PrivateConstructorMembersAccessSoloTestHelper
    extends SoloTestHelper<NoSampleParams, NoSampleOptions> {
  PrivateConstructorMembersAccessSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);
}

/* ----------------------------------- A2 ----------------------------------- */

class FactoryConstructorMembersAccessSoloTestSupport
    extends ModddelsTestSupport<
        FactoryConstructorMembersAccessSoloTestHelper,
        FactorySampleParams,
        FactorySampleOptions,
        MembersAccessSoloSVO,
        MembersAccessSoloMVO,
        MembersAccessSoloSE,
        MembersAccessSoloIE,
        MembersAccessSoloI2E> {
  FactoryConstructorMembersAccessSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      FactoryConstructorMembersAccessSoloTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  MembersAccessSoloSVO makeSingleValueObject(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSoloSVO(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSoloMVO makeMultiValueObject(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSoloMVO(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSoloSE makeSimpleEntity(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSoloSE(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSoloIE makeIterableEntity(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSoloIE(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSoloI2E makeIterable2Entity(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSoloI2E(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );
}

class FactoryConstructorMembersAccessSoloTestHelper
    extends SoloTestHelper<FactorySampleParams, FactorySampleOptions> {
  FactoryConstructorMembersAccessSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);
}

/* ----------------------------------- B1 ----------------------------------- */

class PrivateConstructorMembersAccessSSealedTestSupport
    extends ModddelsTestSupport<
        PrivateConstructorMembersAccessSSealedTestHelper,
        NoSampleParams,
        NoSampleOptions,
        MembersAccessSSealedSVO,
        MembersAccessSSealedMVO,
        MembersAccessSSealedSE,
        MembersAccessSSealedIE,
        MembersAccessSSealedI2E> {
  PrivateConstructorMembersAccessSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      PrivateConstructorMembersAccessSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  MembersAccessSSealedSVO makeSingleValueObject(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSSealedSVO.privateConstructor();

  @override
  MembersAccessSSealedMVO makeMultiValueObject(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSSealedMVO.privateConstructor();

  @override
  MembersAccessSSealedSE makeSimpleEntity(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSSealedSE.privateConstructor();

  @override
  MembersAccessSSealedIE makeIterableEntity(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSSealedIE.privateConstructor();

  @override
  MembersAccessSSealedI2E makeIterable2Entity(
          NoSampleParams params, NoSampleOptions sampleOptions) =>
      MembersAccessSSealedI2E.privateConstructor();
}

class PrivateConstructorMembersAccessSSealedTestHelper
    extends SSealedTestHelper<NoSampleParams, NoSampleOptions> {
  PrivateConstructorMembersAccessSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);
}

/* ----------------------------------- B2 ----------------------------------- */

class FactoryConstructorMembersAccessSSealedTestSupport
    extends ModddelsTestSupport<
        FactoryConstructorMembersAccessSSealedTestHelper,
        FactorySampleParams,
        FactorySampleOptions,
        MembersAccessSSealedSVO,
        MembersAccessSSealedMVO,
        MembersAccessSSealedSE,
        MembersAccessSSealedIE,
        MembersAccessSSealedI2E> {
  FactoryConstructorMembersAccessSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      FactoryConstructorMembersAccessSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  MembersAccessSSealedSVO makeSingleValueObject(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSSealedSVO.namedMembersAccessSSealedSVO(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSSealedMVO makeMultiValueObject(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSSealedMVO.namedMembersAccessSSealedMVO(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSSealedSE makeSimpleEntity(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSSealedSE.namedMembersAccessSSealedSE(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSSealedIE makeIterableEntity(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSSealedIE.namedMembersAccessSSealedIE(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );

  @override
  MembersAccessSSealedI2E makeIterable2Entity(
          FactorySampleParams params, FactorySampleOptions sampleOptions) =>
      MembersAccessSSealedI2E.namedMembersAccessSSealedI2E(
        param: params.param.value,
        dependency: params.dependency.value,
        $validateMethodShouldThrowInfos:
            sampleOptions.validateMethodShouldThrowInfos,
      );
}

class FactoryConstructorMembersAccessSSealedTestHelper
    extends SSealedTestHelper<FactorySampleParams, FactorySampleOptions> {
  FactoryConstructorMembersAccessSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);
}

/* -------------------------------------------------------------------------- */
/*                     Common TestHelper Mixins & Classes                     */
/* -------------------------------------------------------------------------- */

mixin TestHelperMixin<P extends SampleParamsBase, O extends SampleOptionsBase>
    on TestHelperBase<P, O> {
  /// Accesses the member parameter named "param".
  ///
  void accessParam();

  /// Accesses the dependency parameter named "dependency".
  ///
  void accessDependency();

  /// Accesses the `copyWith` getter.
  ///
  void accessCopyWith();

  /// Accesses the `map` method.
  ///
  void accessMap();

  /// Accesses the `maybeMap` method.
  ///
  void accessMaybeMap();

  /// Accesses the `mapOrNull` method.
  ///
  void accessMapOrNull();

  /// Accesses the `maybeMapValidity` method.
  ///
  void accessMaybeMapValidity();
}

abstract class SoloTestHelper<P extends SampleParamsBase,
        O extends SampleOptionsBase>
    extends ModddelTestHelper<
        P,
        O,
        MembersAccessSoloSVO,
        MembersAccessSoloMVO,
        MembersAccessSoloSE,
        MembersAccessSoloIE,
        MembersAccessSoloI2E> with TestHelperMixin<P, O> {
  SoloTestHelper(super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  void accessParam() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.param,
      multiValueObject: (multiValueObject) => multiValueObject.param,
      simpleEntity: (simpleEntity) => simpleEntity.param,
      iterableEntity: (iterableEntity) => iterableEntity.param,
      iterable2Entity: (iterable2Entity) => iterable2Entity.param,
    );
  }

  @override
  void accessDependency() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.dependency,
      multiValueObject: (multiValueObject) => multiValueObject.dependency,
      simpleEntity: (simpleEntity) => simpleEntity.dependency,
      iterableEntity: (iterableEntity) => iterableEntity.dependency,
      iterable2Entity: (iterable2Entity) => iterable2Entity.dependency,
    );
  }

  @override
  void accessCopyWith() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.copyWith(),
      multiValueObject: (multiValueObject) => multiValueObject.copyWith(),
      simpleEntity: (simpleEntity) => simpleEntity.copyWith(),
      iterableEntity: (iterableEntity) => iterableEntity.copyWith(),
      iterable2Entity: (iterable2Entity) => iterable2Entity.copyWith(),
    );
  }

  @override
  void accessMap() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.map(valid: (_) {}, invalidValue: (_) {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.map(valid: (_) {}, invalidValue: (_) {}),
      simpleEntity: (simpleEntity) =>
          simpleEntity.map(valid: (_) {}, invalidMid: (_) {}),
      iterableEntity: (iterableEntity) =>
          iterableEntity.map(valid: (_) {}, invalidMid: (_) {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.map(valid: (_) {}, invalidMid: (_) {}),
    );
  }

  @override
  void accessMaybeMap() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.maybeMap(orElse: () {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.maybeMap(orElse: () {}),
      simpleEntity: (simpleEntity) => simpleEntity.maybeMap(orElse: () {}),
      iterableEntity: (iterableEntity) =>
          iterableEntity.maybeMap(orElse: () {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.maybeMap(orElse: () {}),
    );
  }

  @override
  void accessMapOrNull() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.mapOrNull(),
      multiValueObject: (multiValueObject) => multiValueObject.mapOrNull(),
      simpleEntity: (simpleEntity) => simpleEntity.mapOrNull(),
      iterableEntity: (iterableEntity) => iterableEntity.mapOrNull(),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapOrNull(),
    );
  }

  @override
  void accessMaybeMapValidity() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      simpleEntity: (simpleEntity) =>
          simpleEntity.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      iterableEntity: (iterableEntity) =>
          iterableEntity.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
    );
  }
}

abstract class SSealedTestHelper<P extends SampleParamsBase,
        O extends SampleOptionsBase>
    extends ModddelTestHelper<
        P,
        O,
        MembersAccessSSealedSVO,
        MembersAccessSSealedMVO,
        MembersAccessSSealedSE,
        MembersAccessSSealedIE,
        MembersAccessSSealedI2E> with TestHelperMixin<P, O> {
  SSealedTestHelper(super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  void accessParam() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.param,
      multiValueObject: (multiValueObject) => multiValueObject.param,
      simpleEntity: (simpleEntity) => simpleEntity.param,
      iterableEntity: (iterableEntity) => iterableEntity.param,
      iterable2Entity: (iterable2Entity) => iterable2Entity.param,
    );
  }

  @override
  void accessDependency() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.dependency,
      multiValueObject: (multiValueObject) => multiValueObject.dependency,
      simpleEntity: (simpleEntity) => simpleEntity.dependency,
      iterableEntity: (iterableEntity) => iterableEntity.dependency,
      iterable2Entity: (iterable2Entity) => iterable2Entity.dependency,
    );
  }

  @override
  void accessCopyWith() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.copyWith(),
      multiValueObject: (multiValueObject) => multiValueObject.copyWith(),
      simpleEntity: (simpleEntity) => simpleEntity.copyWith(),
      iterableEntity: (iterableEntity) => iterableEntity.copyWith(),
      iterable2Entity: (iterable2Entity) => iterable2Entity.copyWith(),
    );
  }

  @override
  void accessMap() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.map(valid: (_) {}, invalidValue: (_) {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.map(valid: (_) {}, invalidValue: (_) {}),
      simpleEntity: (simpleEntity) =>
          simpleEntity.map(valid: (_) {}, invalidMid: (_) {}),
      iterableEntity: (iterableEntity) =>
          iterableEntity.map(valid: (_) {}, invalidMid: (_) {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.map(valid: (_) {}, invalidMid: (_) {}),
    );
  }

  @override
  void accessMaybeMap() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.maybeMap(orElse: () {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.maybeMap(orElse: () {}),
      simpleEntity: (simpleEntity) => simpleEntity.maybeMap(orElse: () {}),
      iterableEntity: (iterableEntity) =>
          iterableEntity.maybeMap(orElse: () {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.maybeMap(orElse: () {}),
    );
  }

  @override
  void accessMapOrNull() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject.mapOrNull(),
      multiValueObject: (multiValueObject) => multiValueObject.mapOrNull(),
      simpleEntity: (simpleEntity) => simpleEntity.mapOrNull(),
      iterableEntity: (iterableEntity) => iterableEntity.mapOrNull(),
      iterable2Entity: (iterable2Entity) => iterable2Entity.mapOrNull(),
    );
  }

  @override
  void accessMaybeMapValidity() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      simpleEntity: (simpleEntity) =>
          simpleEntity.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      iterableEntity: (iterableEntity) =>
          iterableEntity.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.maybeMapValidity(valid: (_) {}, orElse: (_) {}),
    );
  }

  /// Accesses the "mapModddels" method.
  ///
  void accessMapModddels() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) => singleValueObject
          .mapMembersAccessSSealedSVO(namedMembersAccessSSealedSVO: (_) {}),
      multiValueObject: (multiValueObject) => multiValueObject
          .mapMembersAccessSSealedMVO(namedMembersAccessSSealedMVO: (_) {}),
      simpleEntity: (simpleEntity) => simpleEntity.mapMembersAccessSSealedSE(
          namedMembersAccessSSealedSE: (_) {}),
      iterableEntity: (iterableEntity) => iterableEntity
          .mapMembersAccessSSealedIE(namedMembersAccessSSealedIE: (_) {}),
      iterable2Entity: (iterable2Entity) => iterable2Entity
          .mapMembersAccessSSealedI2E(namedMembersAccessSSealedI2E: (_) {}),
    );
  }

  /// Accesses the "maybeMapModddels" method.
  ///
  void accessMaybeMapModddels() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.maybeMapMembersAccessSSealedSVO(
              namedMembersAccessSSealedSVO: (_) {}, orElse: () {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.maybeMapMembersAccessSSealedMVO(
              namedMembersAccessSSealedMVO: (_) {}, orElse: () {}),
      simpleEntity: (simpleEntity) =>
          simpleEntity.maybeMapMembersAccessSSealedSE(
              namedMembersAccessSSealedSE: (_) {}, orElse: () {}),
      iterableEntity: (iterableEntity) =>
          iterableEntity.maybeMapMembersAccessSSealedIE(
              namedMembersAccessSSealedIE: (_) {}, orElse: () {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.maybeMapMembersAccessSSealedI2E(
              namedMembersAccessSSealedI2E: (_) {}, orElse: () {}),
    );
  }

  /// Accesses the "mapOrNullModddels" method.
  ///
  void accessMapOrNullModddels() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          singleValueObject.mapOrNullMembersAccessSSealedSVO(
              namedMembersAccessSSealedSVO: (_) {}),
      multiValueObject: (multiValueObject) =>
          multiValueObject.mapOrNullMembersAccessSSealedMVO(
              namedMembersAccessSSealedMVO: (_) {}),
      simpleEntity: (simpleEntity) => simpleEntity
          .mapOrNullMembersAccessSSealedSE(namedMembersAccessSSealedSE: (_) {}),
      iterableEntity: (iterableEntity) => iterableEntity
          .mapOrNullMembersAccessSSealedIE(namedMembersAccessSSealedIE: (_) {}),
      iterable2Entity: (iterable2Entity) =>
          iterable2Entity.mapOrNullMembersAccessSSealedI2E(
              namedMembersAccessSSealedI2E: (_) {}),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            Common SampleOptions                            */
/* -------------------------------------------------------------------------- */

class FactorySampleOptions extends SampleOptionsBase {
  FactorySampleOptions(
    super.name, {
    required this.validateMethodShouldThrowInfos,
  });

  final bool validateMethodShouldThrowInfos;
}

/* -------------------------------------------------------------------------- */
/*                             Common SampleValues                            */
/* -------------------------------------------------------------------------- */

class FactorySampleParams extends SampleParamsBase {
  FactorySampleParams({
    required this.param,
    required this.dependency,
  });

  final ParamWithSource param;

  final ParamWithSource dependency;
}

final noParamsSampleValues = ModddelSampleValues(
    singleValueObject: NoSampleParams(),
    multiValueObject: NoSampleParams(),
    simpleEntity: NoSampleParams(),
    iterableEntity: NoSampleParams(),
    iterable2Entity: NoSampleParams());

final factoryParamsSampleValues = ModddelSampleValues(
  singleValueObject: FactorySampleParams(
      param: SampleValues1.paramString, dependency: SampleValues1.dependency),
  multiValueObject: FactorySampleParams(
      param: SampleValues1.paramString, dependency: SampleValues1.dependency),
  simpleEntity: FactorySampleParams(
      param: SampleValues1.paramModddel, dependency: SampleValues1.dependency),
  iterableEntity: FactorySampleParams(
      param: SampleValues1.paramListModddel,
      dependency: SampleValues1.dependency),
  iterable2Entity: FactorySampleParams(
      param: SampleValues1.paramMapModddel,
      dependency: SampleValues1.dependency),
);
