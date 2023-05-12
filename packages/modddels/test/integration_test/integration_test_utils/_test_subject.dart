import 'package:freezed_annotation/freezed_annotation.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part '_test_subject.freezed.dart';

/// A [TestSubject] represents a tested modddel that can be of any of the five
/// possible kinds.
///
/// It's a freezed class which union-cases are the five possible modddel kinds.
///
@freezed
class TestSubject<
    SVO extends SingleValueObject,
    MVO extends MultiValueObject,
    SE extends SimpleEntity,
    IE extends IterableEntity,
    I2E extends Iterable2Entity> with _$TestSubject<SVO, MVO, SE, IE, I2E> {
  const TestSubject._();

  const factory TestSubject.valueObject(
          ValueObjectTS<SVO, MVO> valueObjectTestSubject) =
      ValueObjectTestSubject<SVO, MVO, SE, IE, I2E>;

  const factory TestSubject.entity(EntityTS<SE, IE, I2E> entityTestSubject) =
      EntityTestSubject<SVO, MVO, SE, IE, I2E>;

  @optionalTypeArgs
  TResult whenAll<TResult extends Object?>({
    required TResult Function(SVO singleValueObject) singleValueObject,
    required TResult Function(MVO multiValueObject) multiValueObject,
    required TResult Function(SE simpleEntity) simpleEntity,
    required TResult Function(IE iterableEntity) iterableEntity,
    required TResult Function(I2E iterable2Entity) iterable2Entity,
  }) {
    return when(
      valueObject: (valueObjectTestSubject) => valueObjectTestSubject.when(
        singleValueObject: (svo) => singleValueObject(svo),
        multiValueObject: (mvo) => multiValueObject(mvo),
      ),
      entity: (entityTestSubject) => entityTestSubject.when(
        simpleEntity: (se) => simpleEntity(se),
        iterableEntity: (ie) => iterableEntity(ie),
        iterable2Entity: (i2e) => iterable2Entity(i2e),
      ),
    );
  }

  BaseModddel get modddel => whenAll(
        singleValueObject: (singleValueObject) => singleValueObject,
        multiValueObject: (multiValueObject) => multiValueObject,
        simpleEntity: (simpleEntity) => simpleEntity,
        iterableEntity: (iterableEntity) => iterableEntity,
        iterable2Entity: (iterable2Entity) => iterable2Entity,
      );

  String get modddelKind => whenAll(
        singleValueObject: (singleValueObject) => 'SingleValueObject',
        multiValueObject: (multiValueObject) => 'MultiValueObject',
        simpleEntity: (simpleEntity) => 'SimpleEntity',
        iterableEntity: (iterableEntity) => 'IterableEntity',
        iterable2Entity: (iterable2Entity) => 'Iterable2Entity',
      );
}

/// Represents a [TestSubject] that is a ValueObject, holding either a
/// SingleValueObject or a MultiValueObject.
///
@freezed
class ValueObjectTS<SVO extends SingleValueObject, MVO extends MultiValueObject>
    with _$ValueObjectTS<SVO, MVO> {
  const factory ValueObjectTS.singleValueObject(SVO singleValueObject) =
      _SingleValueObject<SVO, MVO>;

  const factory ValueObjectTS.multiValueObject(MVO multiValueObject) =
      _MultiValueObject<SVO, MVO>;
}

/// Represents a [TestSubject] that is an Entity, holding either a
/// SimpleEntity, an IterableEntity or an Iterable2Entity.
///
@freezed
class EntityTS<SE extends SimpleEntity, IE extends IterableEntity,
    I2E extends Iterable2Entity> with _$EntityTS<SE, IE, I2E> {
  const factory EntityTS.simpleEntity(SE simpleEntity) =
      _SimpleEntity<SE, IE, I2E>;

  const factory EntityTS.iterableEntity(IE iterableEntity) =
      _IterableEntity<SE, IE, I2E>;

  const factory EntityTS.iterable2Entity(I2E iterable2Entity) =
      _Iterable2Entity<SE, IE, I2E>;
}
