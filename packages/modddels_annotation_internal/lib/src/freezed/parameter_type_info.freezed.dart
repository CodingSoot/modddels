// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_type_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ParameterTypeInfo {
  TransformedType get nonNullable => throw _privateConstructorUsedError;
  TransformedType get nullable => throw _privateConstructorUsedError;
  TransformedType get valid => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid)
        normal,
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid, String modddelType)
        iterable,
    required TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)
        iterable2,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult? Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NormalParameterTypeInfo value) normal,
    required TResult Function(IterableParameterTypeInfo value) iterable,
    required TResult Function(Iterable2ParameterTypeInfo value) iterable2,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NormalParameterTypeInfo value)? normal,
    TResult? Function(IterableParameterTypeInfo value)? iterable,
    TResult? Function(Iterable2ParameterTypeInfo value)? iterable2,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NormalParameterTypeInfo value)? normal,
    TResult Function(IterableParameterTypeInfo value)? iterable,
    TResult Function(Iterable2ParameterTypeInfo value)? iterable2,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParameterTypeInfoCopyWith<$Res> {
  factory $ParameterTypeInfoCopyWith(
          ParameterTypeInfo value, $Res Function(ParameterTypeInfo) then) =
      _$ParameterTypeInfoCopyWithImpl<$Res, ParameterTypeInfo>;
}

/// @nodoc
class _$ParameterTypeInfoCopyWithImpl<$Res, $Val extends ParameterTypeInfo>
    implements $ParameterTypeInfoCopyWith<$Res> {
  _$ParameterTypeInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NormalParameterTypeInfoCopyWith<$Res> {
  factory _$$NormalParameterTypeInfoCopyWith(_$NormalParameterTypeInfo value,
          $Res Function(_$NormalParameterTypeInfo) then) =
      __$$NormalParameterTypeInfoCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TransformedType nonNullable,
      TransformedType nullable,
      TransformedType valid});
}

/// @nodoc
class __$$NormalParameterTypeInfoCopyWithImpl<$Res>
    extends _$ParameterTypeInfoCopyWithImpl<$Res, _$NormalParameterTypeInfo>
    implements _$$NormalParameterTypeInfoCopyWith<$Res> {
  __$$NormalParameterTypeInfoCopyWithImpl(_$NormalParameterTypeInfo _value,
      $Res Function(_$NormalParameterTypeInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonNullable = null,
    Object? nullable = null,
    Object? valid = null,
  }) {
    return _then(_$NormalParameterTypeInfo(
      nonNullable: null == nonNullable
          ? _value.nonNullable
          : nonNullable // ignore: cast_nullable_to_non_nullable
              as TransformedType,
      nullable: null == nullable
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as TransformedType,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as TransformedType,
    ));
  }
}

/// @nodoc

class _$NormalParameterTypeInfo extends NormalParameterTypeInfo {
  const _$NormalParameterTypeInfo(
      {required this.nonNullable, required this.nullable, required this.valid})
      : super._();

  @override
  final TransformedType nonNullable;
  @override
  final TransformedType nullable;
  @override
  final TransformedType valid;

  @override
  String toString() {
    return 'ParameterTypeInfo.normal(nonNullable: $nonNullable, nullable: $nullable, valid: $valid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NormalParameterTypeInfo &&
            (identical(other.nonNullable, nonNullable) ||
                other.nonNullable == nonNullable) &&
            (identical(other.nullable, nullable) ||
                other.nullable == nullable) &&
            (identical(other.valid, valid) || other.valid == valid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nonNullable, nullable, valid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NormalParameterTypeInfoCopyWith<_$NormalParameterTypeInfo> get copyWith =>
      __$$NormalParameterTypeInfoCopyWithImpl<_$NormalParameterTypeInfo>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid)
        normal,
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid, String modddelType)
        iterable,
    required TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)
        iterable2,
  }) {
    return normal(nonNullable, nullable, valid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult? Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
  }) {
    return normal?.call(nonNullable, nullable, valid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
    required TResult orElse(),
  }) {
    if (normal != null) {
      return normal(nonNullable, nullable, valid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NormalParameterTypeInfo value) normal,
    required TResult Function(IterableParameterTypeInfo value) iterable,
    required TResult Function(Iterable2ParameterTypeInfo value) iterable2,
  }) {
    return normal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NormalParameterTypeInfo value)? normal,
    TResult? Function(IterableParameterTypeInfo value)? iterable,
    TResult? Function(Iterable2ParameterTypeInfo value)? iterable2,
  }) {
    return normal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NormalParameterTypeInfo value)? normal,
    TResult Function(IterableParameterTypeInfo value)? iterable,
    TResult Function(Iterable2ParameterTypeInfo value)? iterable2,
    required TResult orElse(),
  }) {
    if (normal != null) {
      return normal(this);
    }
    return orElse();
  }
}

abstract class NormalParameterTypeInfo extends ParameterTypeInfo {
  const factory NormalParameterTypeInfo(
      {required final TransformedType nonNullable,
      required final TransformedType nullable,
      required final TransformedType valid}) = _$NormalParameterTypeInfo;
  const NormalParameterTypeInfo._() : super._();

  @override
  TransformedType get nonNullable;
  @override
  TransformedType get nullable;
  @override
  TransformedType get valid;
  @JsonKey(ignore: true)
  _$$NormalParameterTypeInfoCopyWith<_$NormalParameterTypeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IterableParameterTypeInfoCopyWith<$Res> {
  factory _$$IterableParameterTypeInfoCopyWith(
          _$IterableParameterTypeInfo value,
          $Res Function(_$IterableParameterTypeInfo) then) =
      __$$IterableParameterTypeInfoCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TransformedType nonNullable,
      TransformedType nullable,
      TransformedType valid,
      String modddelType});
}

/// @nodoc
class __$$IterableParameterTypeInfoCopyWithImpl<$Res>
    extends _$ParameterTypeInfoCopyWithImpl<$Res, _$IterableParameterTypeInfo>
    implements _$$IterableParameterTypeInfoCopyWith<$Res> {
  __$$IterableParameterTypeInfoCopyWithImpl(_$IterableParameterTypeInfo _value,
      $Res Function(_$IterableParameterTypeInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonNullable = null,
    Object? nullable = null,
    Object? valid = null,
    Object? modddelType = null,
  }) {
    return _then(_$IterableParameterTypeInfo(
      nonNullable: null == nonNullable
          ? _value.nonNullable
          : nonNullable // ignore: cast_nullable_to_non_nullable
              as TransformedType,
      nullable: null == nullable
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as TransformedType,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as TransformedType,
      modddelType: null == modddelType
          ? _value.modddelType
          : modddelType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$IterableParameterTypeInfo extends IterableParameterTypeInfo {
  const _$IterableParameterTypeInfo(
      {required this.nonNullable,
      required this.nullable,
      required this.valid,
      required this.modddelType})
      : super._();

  @override
  final TransformedType nonNullable;
  @override
  final TransformedType nullable;
  @override
  final TransformedType valid;

  /// The type of the modddel matching the mask (#1)
  @override
  final String modddelType;

  @override
  String toString() {
    return 'ParameterTypeInfo.iterable(nonNullable: $nonNullable, nullable: $nullable, valid: $valid, modddelType: $modddelType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IterableParameterTypeInfo &&
            (identical(other.nonNullable, nonNullable) ||
                other.nonNullable == nonNullable) &&
            (identical(other.nullable, nullable) ||
                other.nullable == nullable) &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.modddelType, modddelType) ||
                other.modddelType == modddelType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nonNullable, nullable, valid, modddelType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IterableParameterTypeInfoCopyWith<_$IterableParameterTypeInfo>
      get copyWith => __$$IterableParameterTypeInfoCopyWithImpl<
          _$IterableParameterTypeInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid)
        normal,
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid, String modddelType)
        iterable,
    required TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)
        iterable2,
  }) {
    return iterable(nonNullable, nullable, valid, modddelType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult? Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
  }) {
    return iterable?.call(nonNullable, nullable, valid, modddelType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
    required TResult orElse(),
  }) {
    if (iterable != null) {
      return iterable(nonNullable, nullable, valid, modddelType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NormalParameterTypeInfo value) normal,
    required TResult Function(IterableParameterTypeInfo value) iterable,
    required TResult Function(Iterable2ParameterTypeInfo value) iterable2,
  }) {
    return iterable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NormalParameterTypeInfo value)? normal,
    TResult? Function(IterableParameterTypeInfo value)? iterable,
    TResult? Function(Iterable2ParameterTypeInfo value)? iterable2,
  }) {
    return iterable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NormalParameterTypeInfo value)? normal,
    TResult Function(IterableParameterTypeInfo value)? iterable,
    TResult Function(Iterable2ParameterTypeInfo value)? iterable2,
    required TResult orElse(),
  }) {
    if (iterable != null) {
      return iterable(this);
    }
    return orElse();
  }
}

abstract class IterableParameterTypeInfo extends ParameterTypeInfo {
  const factory IterableParameterTypeInfo(
      {required final TransformedType nonNullable,
      required final TransformedType nullable,
      required final TransformedType valid,
      required final String modddelType}) = _$IterableParameterTypeInfo;
  const IterableParameterTypeInfo._() : super._();

  @override
  TransformedType get nonNullable;
  @override
  TransformedType get nullable;
  @override
  TransformedType get valid;

  /// The type of the modddel matching the mask (#1)
  String get modddelType;
  @JsonKey(ignore: true)
  _$$IterableParameterTypeInfoCopyWith<_$IterableParameterTypeInfo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Iterable2ParameterTypeInfoCopyWith<$Res> {
  factory _$$Iterable2ParameterTypeInfoCopyWith(
          _$Iterable2ParameterTypeInfo value,
          $Res Function(_$Iterable2ParameterTypeInfo) then) =
      __$$Iterable2ParameterTypeInfoCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TransformedTypeIter2 nonNullable,
      TransformedTypeIter2 nullable,
      TransformedTypeIter2 valid,
      String modddel1Type,
      String modddel2Type});
}

/// @nodoc
class __$$Iterable2ParameterTypeInfoCopyWithImpl<$Res>
    extends _$ParameterTypeInfoCopyWithImpl<$Res, _$Iterable2ParameterTypeInfo>
    implements _$$Iterable2ParameterTypeInfoCopyWith<$Res> {
  __$$Iterable2ParameterTypeInfoCopyWithImpl(
      _$Iterable2ParameterTypeInfo _value,
      $Res Function(_$Iterable2ParameterTypeInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonNullable = null,
    Object? nullable = null,
    Object? valid = null,
    Object? modddel1Type = null,
    Object? modddel2Type = null,
  }) {
    return _then(_$Iterable2ParameterTypeInfo(
      nonNullable: null == nonNullable
          ? _value.nonNullable
          : nonNullable // ignore: cast_nullable_to_non_nullable
              as TransformedTypeIter2,
      nullable: null == nullable
          ? _value.nullable
          : nullable // ignore: cast_nullable_to_non_nullable
              as TransformedTypeIter2,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as TransformedTypeIter2,
      modddel1Type: null == modddel1Type
          ? _value.modddel1Type
          : modddel1Type // ignore: cast_nullable_to_non_nullable
              as String,
      modddel2Type: null == modddel2Type
          ? _value.modddel2Type
          : modddel2Type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Iterable2ParameterTypeInfo extends Iterable2ParameterTypeInfo {
  const _$Iterable2ParameterTypeInfo(
      {required this.nonNullable,
      required this.nullable,
      required this.valid,
      required this.modddel1Type,
      required this.modddel2Type})
      : super._();

  @override
  final TransformedTypeIter2 nonNullable;
  @override
  final TransformedTypeIter2 nullable;
  @override
  final TransformedTypeIter2 valid;

  /// The type of the modddel matching the mask (#1)
  @override
  final String modddel1Type;

  /// The type of the modddel matching the mask (#2)
  @override
  final String modddel2Type;

  @override
  String toString() {
    return 'ParameterTypeInfo.iterable2(nonNullable: $nonNullable, nullable: $nullable, valid: $valid, modddel1Type: $modddel1Type, modddel2Type: $modddel2Type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Iterable2ParameterTypeInfo &&
            (identical(other.nonNullable, nonNullable) ||
                other.nonNullable == nonNullable) &&
            (identical(other.nullable, nullable) ||
                other.nullable == nullable) &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.modddel1Type, modddel1Type) ||
                other.modddel1Type == modddel1Type) &&
            (identical(other.modddel2Type, modddel2Type) ||
                other.modddel2Type == modddel2Type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, nonNullable, nullable, valid, modddel1Type, modddel2Type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Iterable2ParameterTypeInfoCopyWith<_$Iterable2ParameterTypeInfo>
      get copyWith => __$$Iterable2ParameterTypeInfoCopyWithImpl<
          _$Iterable2ParameterTypeInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid)
        normal,
    required TResult Function(TransformedType nonNullable,
            TransformedType nullable, TransformedType valid, String modddelType)
        iterable,
    required TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)
        iterable2,
  }) {
    return iterable2(nonNullable, nullable, valid, modddel1Type, modddel2Type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult? Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult? Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
  }) {
    return iterable2?.call(
        nonNullable, nullable, valid, modddel1Type, modddel2Type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid)?
        normal,
    TResult Function(TransformedType nonNullable, TransformedType nullable,
            TransformedType valid, String modddelType)?
        iterable,
    TResult Function(
            TransformedTypeIter2 nonNullable,
            TransformedTypeIter2 nullable,
            TransformedTypeIter2 valid,
            String modddel1Type,
            String modddel2Type)?
        iterable2,
    required TResult orElse(),
  }) {
    if (iterable2 != null) {
      return iterable2(
          nonNullable, nullable, valid, modddel1Type, modddel2Type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NormalParameterTypeInfo value) normal,
    required TResult Function(IterableParameterTypeInfo value) iterable,
    required TResult Function(Iterable2ParameterTypeInfo value) iterable2,
  }) {
    return iterable2(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NormalParameterTypeInfo value)? normal,
    TResult? Function(IterableParameterTypeInfo value)? iterable,
    TResult? Function(Iterable2ParameterTypeInfo value)? iterable2,
  }) {
    return iterable2?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NormalParameterTypeInfo value)? normal,
    TResult Function(IterableParameterTypeInfo value)? iterable,
    TResult Function(Iterable2ParameterTypeInfo value)? iterable2,
    required TResult orElse(),
  }) {
    if (iterable2 != null) {
      return iterable2(this);
    }
    return orElse();
  }
}

abstract class Iterable2ParameterTypeInfo extends ParameterTypeInfo {
  const factory Iterable2ParameterTypeInfo(
      {required final TransformedTypeIter2 nonNullable,
      required final TransformedTypeIter2 nullable,
      required final TransformedTypeIter2 valid,
      required final String modddel1Type,
      required final String modddel2Type}) = _$Iterable2ParameterTypeInfo;
  const Iterable2ParameterTypeInfo._() : super._();

  @override
  TransformedTypeIter2 get nonNullable;
  @override
  TransformedTypeIter2 get nullable;
  @override
  TransformedTypeIter2 get valid;

  /// The type of the modddel matching the mask (#1)
  String get modddel1Type;

  /// The type of the modddel matching the mask (#2)
  String get modddel2Type;
  @JsonKey(ignore: true)
  _$$Iterable2ParameterTypeInfoCopyWith<_$Iterable2ParameterTypeInfo>
      get copyWith => throw _privateConstructorUsedError;
}
