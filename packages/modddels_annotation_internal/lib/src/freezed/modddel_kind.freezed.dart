// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modddel_kind.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModddelKind {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ValueObjectKind valueObjectKind) valueObject,
    required TResult Function(EntityKind entityKind) entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ValueObjectKind valueObjectKind)? valueObject,
    TResult? Function(EntityKind entityKind)? entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ValueObjectKind valueObjectKind)? valueObject,
    TResult Function(EntityKind entityKind)? entity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueObjectMK value) valueObject,
    required TResult Function(EntityMK value) entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueObjectMK value)? valueObject,
    TResult? Function(EntityMK value)? entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueObjectMK value)? valueObject,
    TResult Function(EntityMK value)? entity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModddelKindCopyWith<$Res> {
  factory $ModddelKindCopyWith(
          ModddelKind value, $Res Function(ModddelKind) then) =
      _$ModddelKindCopyWithImpl<$Res, ModddelKind>;
}

/// @nodoc
class _$ModddelKindCopyWithImpl<$Res, $Val extends ModddelKind>
    implements $ModddelKindCopyWith<$Res> {
  _$ModddelKindCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ValueObjectMKCopyWith<$Res> {
  factory _$$ValueObjectMKCopyWith(
          _$ValueObjectMK value, $Res Function(_$ValueObjectMK) then) =
      __$$ValueObjectMKCopyWithImpl<$Res>;
  @useResult
  $Res call({ValueObjectKind valueObjectKind});

  $ValueObjectKindCopyWith<$Res> get valueObjectKind;
}

/// @nodoc
class __$$ValueObjectMKCopyWithImpl<$Res>
    extends _$ModddelKindCopyWithImpl<$Res, _$ValueObjectMK>
    implements _$$ValueObjectMKCopyWith<$Res> {
  __$$ValueObjectMKCopyWithImpl(
      _$ValueObjectMK _value, $Res Function(_$ValueObjectMK) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valueObjectKind = null,
  }) {
    return _then(_$ValueObjectMK(
      valueObjectKind: null == valueObjectKind
          ? _value.valueObjectKind
          : valueObjectKind // ignore: cast_nullable_to_non_nullable
              as ValueObjectKind,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ValueObjectKindCopyWith<$Res> get valueObjectKind {
    return $ValueObjectKindCopyWith<$Res>(_value.valueObjectKind, (value) {
      return _then(_value.copyWith(valueObjectKind: value));
    });
  }
}

/// @nodoc

class _$ValueObjectMK extends ValueObjectMK {
  const _$ValueObjectMK({required this.valueObjectKind}) : super._();

  @override
  final ValueObjectKind valueObjectKind;

  @override
  String toString() {
    return 'ModddelKind.valueObject(valueObjectKind: $valueObjectKind)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueObjectMK &&
            (identical(other.valueObjectKind, valueObjectKind) ||
                other.valueObjectKind == valueObjectKind));
  }

  @override
  int get hashCode => Object.hash(runtimeType, valueObjectKind);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueObjectMKCopyWith<_$ValueObjectMK> get copyWith =>
      __$$ValueObjectMKCopyWithImpl<_$ValueObjectMK>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ValueObjectKind valueObjectKind) valueObject,
    required TResult Function(EntityKind entityKind) entity,
  }) {
    return valueObject(valueObjectKind);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ValueObjectKind valueObjectKind)? valueObject,
    TResult? Function(EntityKind entityKind)? entity,
  }) {
    return valueObject?.call(valueObjectKind);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ValueObjectKind valueObjectKind)? valueObject,
    TResult Function(EntityKind entityKind)? entity,
    required TResult orElse(),
  }) {
    if (valueObject != null) {
      return valueObject(valueObjectKind);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueObjectMK value) valueObject,
    required TResult Function(EntityMK value) entity,
  }) {
    return valueObject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueObjectMK value)? valueObject,
    TResult? Function(EntityMK value)? entity,
  }) {
    return valueObject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueObjectMK value)? valueObject,
    TResult Function(EntityMK value)? entity,
    required TResult orElse(),
  }) {
    if (valueObject != null) {
      return valueObject(this);
    }
    return orElse();
  }
}

abstract class ValueObjectMK extends ModddelKind {
  const factory ValueObjectMK(
      {required final ValueObjectKind valueObjectKind}) = _$ValueObjectMK;
  const ValueObjectMK._() : super._();

  ValueObjectKind get valueObjectKind;
  @JsonKey(ignore: true)
  _$$ValueObjectMKCopyWith<_$ValueObjectMK> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EntityMKCopyWith<$Res> {
  factory _$$EntityMKCopyWith(
          _$EntityMK value, $Res Function(_$EntityMK) then) =
      __$$EntityMKCopyWithImpl<$Res>;
  @useResult
  $Res call({EntityKind entityKind});

  $EntityKindCopyWith<$Res> get entityKind;
}

/// @nodoc
class __$$EntityMKCopyWithImpl<$Res>
    extends _$ModddelKindCopyWithImpl<$Res, _$EntityMK>
    implements _$$EntityMKCopyWith<$Res> {
  __$$EntityMKCopyWithImpl(_$EntityMK _value, $Res Function(_$EntityMK) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityKind = null,
  }) {
    return _then(_$EntityMK(
      entityKind: null == entityKind
          ? _value.entityKind
          : entityKind // ignore: cast_nullable_to_non_nullable
              as EntityKind,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $EntityKindCopyWith<$Res> get entityKind {
    return $EntityKindCopyWith<$Res>(_value.entityKind, (value) {
      return _then(_value.copyWith(entityKind: value));
    });
  }
}

/// @nodoc

class _$EntityMK extends EntityMK {
  const _$EntityMK({required this.entityKind}) : super._();

  @override
  final EntityKind entityKind;

  @override
  String toString() {
    return 'ModddelKind.entity(entityKind: $entityKind)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntityMK &&
            (identical(other.entityKind, entityKind) ||
                other.entityKind == entityKind));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entityKind);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntityMKCopyWith<_$EntityMK> get copyWith =>
      __$$EntityMKCopyWithImpl<_$EntityMK>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ValueObjectKind valueObjectKind) valueObject,
    required TResult Function(EntityKind entityKind) entity,
  }) {
    return entity(entityKind);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ValueObjectKind valueObjectKind)? valueObject,
    TResult? Function(EntityKind entityKind)? entity,
  }) {
    return entity?.call(entityKind);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ValueObjectKind valueObjectKind)? valueObject,
    TResult Function(EntityKind entityKind)? entity,
    required TResult orElse(),
  }) {
    if (entity != null) {
      return entity(entityKind);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueObjectMK value) valueObject,
    required TResult Function(EntityMK value) entity,
  }) {
    return entity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValueObjectMK value)? valueObject,
    TResult? Function(EntityMK value)? entity,
  }) {
    return entity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueObjectMK value)? valueObject,
    TResult Function(EntityMK value)? entity,
    required TResult orElse(),
  }) {
    if (entity != null) {
      return entity(this);
    }
    return orElse();
  }
}

abstract class EntityMK extends ModddelKind {
  const factory EntityMK({required final EntityKind entityKind}) = _$EntityMK;
  const EntityMK._() : super._();

  EntityKind get entityKind;
  @JsonKey(ignore: true)
  _$$EntityMKCopyWith<_$EntityMK> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ValueObjectKind {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() singleValueObject,
    required TResult Function() multiValueObject,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? singleValueObject,
    TResult? Function()? multiValueObject,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? singleValueObject,
    TResult Function()? multiValueObject,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SingleValueObject value) singleValueObject,
    required TResult Function(_MultiValueObject value) multiValueObject,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SingleValueObject value)? singleValueObject,
    TResult? Function(_MultiValueObject value)? multiValueObject,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SingleValueObject value)? singleValueObject,
    TResult Function(_MultiValueObject value)? multiValueObject,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueObjectKindCopyWith<$Res> {
  factory $ValueObjectKindCopyWith(
          ValueObjectKind value, $Res Function(ValueObjectKind) then) =
      _$ValueObjectKindCopyWithImpl<$Res, ValueObjectKind>;
}

/// @nodoc
class _$ValueObjectKindCopyWithImpl<$Res, $Val extends ValueObjectKind>
    implements $ValueObjectKindCopyWith<$Res> {
  _$ValueObjectKindCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SingleValueObjectCopyWith<$Res> {
  factory _$$_SingleValueObjectCopyWith(_$_SingleValueObject value,
          $Res Function(_$_SingleValueObject) then) =
      __$$_SingleValueObjectCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SingleValueObjectCopyWithImpl<$Res>
    extends _$ValueObjectKindCopyWithImpl<$Res, _$_SingleValueObject>
    implements _$$_SingleValueObjectCopyWith<$Res> {
  __$$_SingleValueObjectCopyWithImpl(
      _$_SingleValueObject _value, $Res Function(_$_SingleValueObject) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SingleValueObject extends _SingleValueObject {
  const _$_SingleValueObject() : super._();

  @override
  String toString() {
    return 'ValueObjectKind.singleValueObject()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SingleValueObject);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() singleValueObject,
    required TResult Function() multiValueObject,
  }) {
    return singleValueObject();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? singleValueObject,
    TResult? Function()? multiValueObject,
  }) {
    return singleValueObject?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? singleValueObject,
    TResult Function()? multiValueObject,
    required TResult orElse(),
  }) {
    if (singleValueObject != null) {
      return singleValueObject();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SingleValueObject value) singleValueObject,
    required TResult Function(_MultiValueObject value) multiValueObject,
  }) {
    return singleValueObject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SingleValueObject value)? singleValueObject,
    TResult? Function(_MultiValueObject value)? multiValueObject,
  }) {
    return singleValueObject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SingleValueObject value)? singleValueObject,
    TResult Function(_MultiValueObject value)? multiValueObject,
    required TResult orElse(),
  }) {
    if (singleValueObject != null) {
      return singleValueObject(this);
    }
    return orElse();
  }
}

abstract class _SingleValueObject extends ValueObjectKind {
  const factory _SingleValueObject() = _$_SingleValueObject;
  const _SingleValueObject._() : super._();
}

/// @nodoc
abstract class _$$_MultiValueObjectCopyWith<$Res> {
  factory _$$_MultiValueObjectCopyWith(
          _$_MultiValueObject value, $Res Function(_$_MultiValueObject) then) =
      __$$_MultiValueObjectCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_MultiValueObjectCopyWithImpl<$Res>
    extends _$ValueObjectKindCopyWithImpl<$Res, _$_MultiValueObject>
    implements _$$_MultiValueObjectCopyWith<$Res> {
  __$$_MultiValueObjectCopyWithImpl(
      _$_MultiValueObject _value, $Res Function(_$_MultiValueObject) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_MultiValueObject extends _MultiValueObject {
  const _$_MultiValueObject() : super._();

  @override
  String toString() {
    return 'ValueObjectKind.multiValueObject()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_MultiValueObject);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() singleValueObject,
    required TResult Function() multiValueObject,
  }) {
    return multiValueObject();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? singleValueObject,
    TResult? Function()? multiValueObject,
  }) {
    return multiValueObject?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? singleValueObject,
    TResult Function()? multiValueObject,
    required TResult orElse(),
  }) {
    if (multiValueObject != null) {
      return multiValueObject();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SingleValueObject value) singleValueObject,
    required TResult Function(_MultiValueObject value) multiValueObject,
  }) {
    return multiValueObject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SingleValueObject value)? singleValueObject,
    TResult? Function(_MultiValueObject value)? multiValueObject,
  }) {
    return multiValueObject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SingleValueObject value)? singleValueObject,
    TResult Function(_MultiValueObject value)? multiValueObject,
    required TResult orElse(),
  }) {
    if (multiValueObject != null) {
      return multiValueObject(this);
    }
    return orElse();
  }
}

abstract class _MultiValueObject extends ValueObjectKind {
  const factory _MultiValueObject() = _$_MultiValueObject;
  const _MultiValueObject._() : super._();
}

/// @nodoc
mixin _$EntityKind {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() simpleEntity,
    required TResult Function() iterableEntity,
    required TResult Function() iterable2Entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? simpleEntity,
    TResult? Function()? iterableEntity,
    TResult? Function()? iterable2Entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? simpleEntity,
    TResult Function()? iterableEntity,
    TResult Function()? iterable2Entity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SimpleEntity value) simpleEntity,
    required TResult Function(_IterableEntity value) iterableEntity,
    required TResult Function(_Iterable2Entity value) iterable2Entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SimpleEntity value)? simpleEntity,
    TResult? Function(_IterableEntity value)? iterableEntity,
    TResult? Function(_Iterable2Entity value)? iterable2Entity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SimpleEntity value)? simpleEntity,
    TResult Function(_IterableEntity value)? iterableEntity,
    TResult Function(_Iterable2Entity value)? iterable2Entity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntityKindCopyWith<$Res> {
  factory $EntityKindCopyWith(
          EntityKind value, $Res Function(EntityKind) then) =
      _$EntityKindCopyWithImpl<$Res, EntityKind>;
}

/// @nodoc
class _$EntityKindCopyWithImpl<$Res, $Val extends EntityKind>
    implements $EntityKindCopyWith<$Res> {
  _$EntityKindCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SimpleEntityCopyWith<$Res> {
  factory _$$_SimpleEntityCopyWith(
          _$_SimpleEntity value, $Res Function(_$_SimpleEntity) then) =
      __$$_SimpleEntityCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SimpleEntityCopyWithImpl<$Res>
    extends _$EntityKindCopyWithImpl<$Res, _$_SimpleEntity>
    implements _$$_SimpleEntityCopyWith<$Res> {
  __$$_SimpleEntityCopyWithImpl(
      _$_SimpleEntity _value, $Res Function(_$_SimpleEntity) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SimpleEntity extends _SimpleEntity {
  const _$_SimpleEntity() : super._();

  @override
  String toString() {
    return 'EntityKind.simpleEntity()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SimpleEntity);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() simpleEntity,
    required TResult Function() iterableEntity,
    required TResult Function() iterable2Entity,
  }) {
    return simpleEntity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? simpleEntity,
    TResult? Function()? iterableEntity,
    TResult? Function()? iterable2Entity,
  }) {
    return simpleEntity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? simpleEntity,
    TResult Function()? iterableEntity,
    TResult Function()? iterable2Entity,
    required TResult orElse(),
  }) {
    if (simpleEntity != null) {
      return simpleEntity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SimpleEntity value) simpleEntity,
    required TResult Function(_IterableEntity value) iterableEntity,
    required TResult Function(_Iterable2Entity value) iterable2Entity,
  }) {
    return simpleEntity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SimpleEntity value)? simpleEntity,
    TResult? Function(_IterableEntity value)? iterableEntity,
    TResult? Function(_Iterable2Entity value)? iterable2Entity,
  }) {
    return simpleEntity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SimpleEntity value)? simpleEntity,
    TResult Function(_IterableEntity value)? iterableEntity,
    TResult Function(_Iterable2Entity value)? iterable2Entity,
    required TResult orElse(),
  }) {
    if (simpleEntity != null) {
      return simpleEntity(this);
    }
    return orElse();
  }
}

abstract class _SimpleEntity extends EntityKind {
  const factory _SimpleEntity() = _$_SimpleEntity;
  const _SimpleEntity._() : super._();
}

/// @nodoc
abstract class _$$_IterableEntityCopyWith<$Res> {
  factory _$$_IterableEntityCopyWith(
          _$_IterableEntity value, $Res Function(_$_IterableEntity) then) =
      __$$_IterableEntityCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_IterableEntityCopyWithImpl<$Res>
    extends _$EntityKindCopyWithImpl<$Res, _$_IterableEntity>
    implements _$$_IterableEntityCopyWith<$Res> {
  __$$_IterableEntityCopyWithImpl(
      _$_IterableEntity _value, $Res Function(_$_IterableEntity) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_IterableEntity extends _IterableEntity {
  const _$_IterableEntity() : super._();

  @override
  String toString() {
    return 'EntityKind.iterableEntity()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_IterableEntity);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() simpleEntity,
    required TResult Function() iterableEntity,
    required TResult Function() iterable2Entity,
  }) {
    return iterableEntity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? simpleEntity,
    TResult? Function()? iterableEntity,
    TResult? Function()? iterable2Entity,
  }) {
    return iterableEntity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? simpleEntity,
    TResult Function()? iterableEntity,
    TResult Function()? iterable2Entity,
    required TResult orElse(),
  }) {
    if (iterableEntity != null) {
      return iterableEntity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SimpleEntity value) simpleEntity,
    required TResult Function(_IterableEntity value) iterableEntity,
    required TResult Function(_Iterable2Entity value) iterable2Entity,
  }) {
    return iterableEntity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SimpleEntity value)? simpleEntity,
    TResult? Function(_IterableEntity value)? iterableEntity,
    TResult? Function(_Iterable2Entity value)? iterable2Entity,
  }) {
    return iterableEntity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SimpleEntity value)? simpleEntity,
    TResult Function(_IterableEntity value)? iterableEntity,
    TResult Function(_Iterable2Entity value)? iterable2Entity,
    required TResult orElse(),
  }) {
    if (iterableEntity != null) {
      return iterableEntity(this);
    }
    return orElse();
  }
}

abstract class _IterableEntity extends EntityKind {
  const factory _IterableEntity() = _$_IterableEntity;
  const _IterableEntity._() : super._();
}

/// @nodoc
abstract class _$$_Iterable2EntityCopyWith<$Res> {
  factory _$$_Iterable2EntityCopyWith(
          _$_Iterable2Entity value, $Res Function(_$_Iterable2Entity) then) =
      __$$_Iterable2EntityCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_Iterable2EntityCopyWithImpl<$Res>
    extends _$EntityKindCopyWithImpl<$Res, _$_Iterable2Entity>
    implements _$$_Iterable2EntityCopyWith<$Res> {
  __$$_Iterable2EntityCopyWithImpl(
      _$_Iterable2Entity _value, $Res Function(_$_Iterable2Entity) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Iterable2Entity extends _Iterable2Entity {
  const _$_Iterable2Entity() : super._();

  @override
  String toString() {
    return 'EntityKind.iterable2Entity()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Iterable2Entity);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() simpleEntity,
    required TResult Function() iterableEntity,
    required TResult Function() iterable2Entity,
  }) {
    return iterable2Entity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? simpleEntity,
    TResult? Function()? iterableEntity,
    TResult? Function()? iterable2Entity,
  }) {
    return iterable2Entity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? simpleEntity,
    TResult Function()? iterableEntity,
    TResult Function()? iterable2Entity,
    required TResult orElse(),
  }) {
    if (iterable2Entity != null) {
      return iterable2Entity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SimpleEntity value) simpleEntity,
    required TResult Function(_IterableEntity value) iterableEntity,
    required TResult Function(_Iterable2Entity value) iterable2Entity,
  }) {
    return iterable2Entity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SimpleEntity value)? simpleEntity,
    TResult? Function(_IterableEntity value)? iterableEntity,
    TResult? Function(_Iterable2Entity value)? iterable2Entity,
  }) {
    return iterable2Entity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SimpleEntity value)? simpleEntity,
    TResult Function(_IterableEntity value)? iterableEntity,
    TResult Function(_Iterable2Entity value)? iterable2Entity,
    required TResult orElse(),
  }) {
    if (iterable2Entity != null) {
      return iterable2Entity(this);
    }
    return orElse();
  }
}

abstract class _Iterable2Entity extends EntityKind {
  const factory _Iterable2Entity() = _$_Iterable2Entity;
  const _Iterable2Entity._() : super._();
}
