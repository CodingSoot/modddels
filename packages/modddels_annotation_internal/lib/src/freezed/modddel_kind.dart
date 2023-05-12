import 'package:freezed_annotation/freezed_annotation.dart';

part 'modddel_kind.freezed.dart';

/// The two kinds of modddels : ValueObjects and Entities
///
@freezed
class ModddelKind with _$ModddelKind {
  const ModddelKind._();

  const factory ModddelKind.valueObject({
    required ValueObjectKind valueObjectKind,
  }) = ValueObjectMK;

  const factory ModddelKind.entity({
    required EntityKind entityKind,
  }) = EntityMK;

  String get name => when(
        valueObject: (valueObjectKind) => valueObjectKind.name,
        entity: (entityKind) => entityKind.name,
      );
}

/// The two kinds of ValueObjects : SingleValueObjects and MultiValueObjects.
///
@freezed
class ValueObjectKind with _$ValueObjectKind {
  const ValueObjectKind._();

  const factory ValueObjectKind.singleValueObject() = _SingleValueObject;
  const factory ValueObjectKind.multiValueObject() = _MultiValueObject;

  String get name => when(
        singleValueObject: () => 'SingleValueObject',
        multiValueObject: () => 'MultiValueObject',
      );
}

/// The three kinds of Entities : SimpleEntities, IterableEntities and
/// Iterable2Entities.
///
@freezed
class EntityKind with _$EntityKind {
  const EntityKind._();

  const factory EntityKind.simpleEntity() = _SimpleEntity;
  const factory EntityKind.iterableEntity() = _IterableEntity;
  const factory EntityKind.iterable2Entity() = _Iterable2Entity;

  String get name => when(
        simpleEntity: () => 'SimpleEntity',
        iterableEntity: () => 'IterableEntity',
        iterable2Entity: () => 'Iterable2Entity',
      );
}
