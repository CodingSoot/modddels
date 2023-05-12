import 'package:checks/checks.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart'
    hide isA;

import 'integration_test_utils.dart';

abstract class TestHelperBase<P extends SampleParamsBase,
    O extends SampleOptionsBase> {
  TestSubject get testSubject;

  P get sampleParams;

  O get sampleOptions;
}

/// This is a wrapper class for the [testSubject] (the modddel being tested,
/// which can be one of the five modddel kinds), along with the [sampleParams]
/// and [sampleOptions] that were used to create it.
///
/// Along with the [ModddelsTestSupport], you should extend this class to create
/// a custom test helper that contains the common testing functionality and
/// utilities that are specific to the modddel types.
///
/// Example :
///
/// ```dart
/// class MyTestHelper extends ModddelTestHelper<
///         SoloSampleParams, // SampleParams
///         MySampleOptions, // SampleOptions
///         MySVO, // SingleValueObject
///         MyMVO, // ...
///         MySE,
///         MyIE,
///         MyI2E> {
///   MyTestHelper(
///       super.testSubject, super.sampleOptions, super.sampleParams);
///
///   void checkSomething({
///     required bool isModddelValid,
///   }) {
///     testSubject.whenAll(
///         singleValueObject: (modddel) => //...,
///         multiValueObject: (modddel) => //...,
///         simpleEntity: (modddel) => //...,
///         iterableEntity: (modddel) => //...,
///         iterable2Entity: (modddel) => //...,
///     );
///   }
/// }
/// ```
///
class ModddelTestHelper<
    P extends SampleParamsBase,
    O extends SampleOptionsBase,
    SVO extends SingleValueObject,
    MVO extends MultiValueObject,
    SE extends SimpleEntity,
    IE extends IterableEntity,
    I2E extends Iterable2Entity> extends TestHelperBase<P, O> {
  ModddelTestHelper(this.testSubject, this.sampleOptions, this.sampleParams);

  @override
  final TestSubject<SVO, MVO, SE, IE, I2E> testSubject;

  @override
  final O sampleOptions;

  @override
  final P sampleParams;

  void checkIsModddelOfType<
      TypeSVO extends SingleValueObject,
      TypeMVO extends MultiValueObject,
      TypeSE extends SimpleEntity,
      TypeIE extends IterableEntity,
      TypeI2E extends Iterable2Entity>() {
    testSubject.whenAll(
      singleValueObject: (singleValueObject) =>
          check(singleValueObject).isA<TypeSVO>(),
      multiValueObject: (multiValueObject) =>
          check(multiValueObject).isA<TypeMVO>(),
      simpleEntity: (simpleEntity) => check(simpleEntity).isA<TypeSE>(),
      iterableEntity: (iterableEntity) => check(iterableEntity).isA<TypeIE>(),
      iterable2Entity: (iterable2Entity) =>
          check(iterable2Entity).isA<TypeI2E>(),
    );
  }
}

/// Same as [ModddelTestHelper], but for ValueObjects only.
///
/// Example :
///
/// ```dart
/// class MyTestHelper extends ValueObjectTestHelper<
///         SoloSampleParams, // SampleParams
///         MySampleOptions, // SampleOptions
///         MySVO, // SingleValueObject...
///         MyMVO> {
///   MyTestHelper(
///       super.testSubject, super.sampleOptions, super.sampleParams);
///
///   void checkSomething({
///     required bool isModddelValid,
///   }) {
///     valueObjectTestSubject.when(
///         singleValueObject: (modddel) => //...,
///         multiValueObject: (modddel) => //...,
///     );
///   }
/// }
/// ```
///
class ValueObjectTestHelper<
    P extends SampleParamsBase,
    O extends SampleOptionsBase,
    SVO extends SingleValueObject,
    MVO extends MultiValueObject> extends TestHelperBase<P, O> {
  ValueObjectTestHelper(
      this.testSubject, this.sampleOptions, this.sampleParams);

  @override
  final ValueObjectTestSubject<SVO, MVO, SimpleEntity, IterableEntity,
      Iterable2Entity> testSubject;

  @override
  final O sampleOptions;

  @override
  final P sampleParams;

  ValueObjectTS<SVO, MVO> get valueObjectTestSubject =>
      testSubject.valueObjectTestSubject;

  void checkIsValueObjectOfType<TypeSVO extends SingleValueObject,
      TypeMVO extends MultiValueObject>() {
    valueObjectTestSubject.when(
      singleValueObject: (singleValueObject) =>
          check(singleValueObject).isA<TypeSVO>(),
      multiValueObject: (multiValueObject) =>
          check(multiValueObject).isA<TypeMVO>(),
    );
  }
}

/// Same as [ModddelTestHelper], but for Entities only.
///
/// Example :
///
/// ```dart
/// class MyTestHelper extends EntityTestHelper<
///         SoloSampleParams, // SampleParams
///         MySampleOptions, // SampleOptions
///         MySE, // SingleValueObject
///         MyIE, // ...
///         MyI2E> {
///   MyTestHelper(
///       super.testSubject, super.sampleOptions, super.sampleParams);
///
///   void checkSomething({
///     required bool isModddelValid,
///   }) {
///     entityTestSubject.when(
///         simpleEntity: (modddel) => //...,
///         iterableEntity: (modddel) => //...,
///         iterable2Entity: (modddel) => //...,
///     );
///   }
/// }
/// ```
///
class EntityTestHelper<
    P extends SampleParamsBase,
    O extends SampleOptionsBase,
    SE extends SimpleEntity,
    IE extends IterableEntity,
    I2E extends Iterable2Entity> extends TestHelperBase<P, O> {
  EntityTestHelper(this.testSubject, this.sampleOptions, this.sampleParams);

  @override
  final EntityTestSubject<SingleValueObject, MultiValueObject, SE, IE, I2E>
      testSubject;

  @override
  final O sampleOptions;

  @override
  final P sampleParams;

  EntityTS<SE, IE, I2E> get entityTestSubject => testSubject.entityTestSubject;

  void checkIsEntityOfType<TypeSE extends SimpleEntity,
      TypeIE extends IterableEntity, TypeI2E extends Iterable2Entity>() {
    testSubject.entityTestSubject.when(
      simpleEntity: (simpleEntity) => check(simpleEntity).isA<TypeSE>(),
      iterableEntity: (iterableEntity) => check(iterableEntity).isA<TypeIE>(),
      iterable2Entity: (iterable2Entity) =>
          check(iterable2Entity).isA<TypeI2E>(),
    );
  }
}
