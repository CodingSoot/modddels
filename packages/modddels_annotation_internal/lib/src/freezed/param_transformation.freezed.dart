// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'param_transformation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ParamTransformation {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maskNb, String? validationName) makeNonNull,
    required TResult Function() makeValid,
    required TResult Function() makeNull,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maskNb, String? validationName)? makeNonNull,
    TResult? Function()? makeValid,
    TResult? Function()? makeNull,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maskNb, String? validationName)? makeNonNull,
    TResult Function()? makeValid,
    TResult Function()? makeNull,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NonNullParamTransformation value) makeNonNull,
    required TResult Function(ValidParamTransformation value) makeValid,
    required TResult Function(NullParamTransformation value) makeNull,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NonNullParamTransformation value)? makeNonNull,
    TResult? Function(ValidParamTransformation value)? makeValid,
    TResult? Function(NullParamTransformation value)? makeNull,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NonNullParamTransformation value)? makeNonNull,
    TResult Function(ValidParamTransformation value)? makeValid,
    TResult Function(NullParamTransformation value)? makeNull,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParamTransformationCopyWith<$Res> {
  factory $ParamTransformationCopyWith(
          ParamTransformation value, $Res Function(ParamTransformation) then) =
      _$ParamTransformationCopyWithImpl<$Res, ParamTransformation>;
}

/// @nodoc
class _$ParamTransformationCopyWithImpl<$Res, $Val extends ParamTransformation>
    implements $ParamTransformationCopyWith<$Res> {
  _$ParamTransformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NonNullParamTransformationCopyWith<$Res> {
  factory _$$NonNullParamTransformationCopyWith(
          _$NonNullParamTransformation value,
          $Res Function(_$NonNullParamTransformation) then) =
      __$$NonNullParamTransformationCopyWithImpl<$Res>;
  @useResult
  $Res call({int? maskNb, String? validationName});
}

/// @nodoc
class __$$NonNullParamTransformationCopyWithImpl<$Res>
    extends _$ParamTransformationCopyWithImpl<$Res,
        _$NonNullParamTransformation>
    implements _$$NonNullParamTransformationCopyWith<$Res> {
  __$$NonNullParamTransformationCopyWithImpl(
      _$NonNullParamTransformation _value,
      $Res Function(_$NonNullParamTransformation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maskNb = freezed,
    Object? validationName = freezed,
  }) {
    return _then(_$NonNullParamTransformation(
      maskNb: freezed == maskNb
          ? _value.maskNb
          : maskNb // ignore: cast_nullable_to_non_nullable
              as int?,
      validationName: freezed == validationName
          ? _value.validationName
          : validationName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NonNullParamTransformation implements NonNullParamTransformation {
  const _$NonNullParamTransformation(
      {required this.maskNb, required this.validationName});

  /// The maskNb of the modddel type on which this transformation should be
  /// applied.
  ///
  /// This should be provided for Iterable2Entities member parameters.
  ///
  @override
  final int? maskNb;

  /// If the transformation is related to a specific `@NullFailure`
  /// annotation, this [validationName] equals [NullFailure.validationName].
  ///
  /// If, in the context of an annotated super-sealed class, the
  /// transformation is related to multiple `@NullFailure` annotations (one in
  /// each case-modddel, excluding the case-modddels where the parameter's
  /// type (or modddelType) is already non-nullable) : If all
  /// [NullFailure.validationName] are the same value, then this
  /// [validationName] equals it. Otherwise equals null.
  ///
  @override
  final String? validationName;

  @override
  String toString() {
    return 'ParamTransformation.makeNonNull(maskNb: $maskNb, validationName: $validationName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NonNullParamTransformation &&
            (identical(other.maskNb, maskNb) || other.maskNb == maskNb) &&
            (identical(other.validationName, validationName) ||
                other.validationName == validationName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maskNb, validationName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NonNullParamTransformationCopyWith<_$NonNullParamTransformation>
      get copyWith => __$$NonNullParamTransformationCopyWithImpl<
          _$NonNullParamTransformation>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maskNb, String? validationName) makeNonNull,
    required TResult Function() makeValid,
    required TResult Function() makeNull,
  }) {
    return makeNonNull(maskNb, validationName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maskNb, String? validationName)? makeNonNull,
    TResult? Function()? makeValid,
    TResult? Function()? makeNull,
  }) {
    return makeNonNull?.call(maskNb, validationName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maskNb, String? validationName)? makeNonNull,
    TResult Function()? makeValid,
    TResult Function()? makeNull,
    required TResult orElse(),
  }) {
    if (makeNonNull != null) {
      return makeNonNull(maskNb, validationName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NonNullParamTransformation value) makeNonNull,
    required TResult Function(ValidParamTransformation value) makeValid,
    required TResult Function(NullParamTransformation value) makeNull,
  }) {
    return makeNonNull(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NonNullParamTransformation value)? makeNonNull,
    TResult? Function(ValidParamTransformation value)? makeValid,
    TResult? Function(NullParamTransformation value)? makeNull,
  }) {
    return makeNonNull?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NonNullParamTransformation value)? makeNonNull,
    TResult Function(ValidParamTransformation value)? makeValid,
    TResult Function(NullParamTransformation value)? makeNull,
    required TResult orElse(),
  }) {
    if (makeNonNull != null) {
      return makeNonNull(this);
    }
    return orElse();
  }
}

abstract class NonNullParamTransformation implements ParamTransformation {
  const factory NonNullParamTransformation(
      {required final int? maskNb,
      required final String? validationName}) = _$NonNullParamTransformation;

  /// The maskNb of the modddel type on which this transformation should be
  /// applied.
  ///
  /// This should be provided for Iterable2Entities member parameters.
  ///
  int? get maskNb;

  /// If the transformation is related to a specific `@NullFailure`
  /// annotation, this [validationName] equals [NullFailure.validationName].
  ///
  /// If, in the context of an annotated super-sealed class, the
  /// transformation is related to multiple `@NullFailure` annotations (one in
  /// each case-modddel, excluding the case-modddels where the parameter's
  /// type (or modddelType) is already non-nullable) : If all
  /// [NullFailure.validationName] are the same value, then this
  /// [validationName] equals it. Otherwise equals null.
  ///
  String? get validationName;
  @JsonKey(ignore: true)
  _$$NonNullParamTransformationCopyWith<_$NonNullParamTransformation>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidParamTransformationCopyWith<$Res> {
  factory _$$ValidParamTransformationCopyWith(_$ValidParamTransformation value,
          $Res Function(_$ValidParamTransformation) then) =
      __$$ValidParamTransformationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ValidParamTransformationCopyWithImpl<$Res>
    extends _$ParamTransformationCopyWithImpl<$Res, _$ValidParamTransformation>
    implements _$$ValidParamTransformationCopyWith<$Res> {
  __$$ValidParamTransformationCopyWithImpl(_$ValidParamTransformation _value,
      $Res Function(_$ValidParamTransformation) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ValidParamTransformation implements ValidParamTransformation {
  const _$ValidParamTransformation();

  @override
  String toString() {
    return 'ParamTransformation.makeValid()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidParamTransformation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maskNb, String? validationName) makeNonNull,
    required TResult Function() makeValid,
    required TResult Function() makeNull,
  }) {
    return makeValid();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maskNb, String? validationName)? makeNonNull,
    TResult? Function()? makeValid,
    TResult? Function()? makeNull,
  }) {
    return makeValid?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maskNb, String? validationName)? makeNonNull,
    TResult Function()? makeValid,
    TResult Function()? makeNull,
    required TResult orElse(),
  }) {
    if (makeValid != null) {
      return makeValid();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NonNullParamTransformation value) makeNonNull,
    required TResult Function(ValidParamTransformation value) makeValid,
    required TResult Function(NullParamTransformation value) makeNull,
  }) {
    return makeValid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NonNullParamTransformation value)? makeNonNull,
    TResult? Function(ValidParamTransformation value)? makeValid,
    TResult? Function(NullParamTransformation value)? makeNull,
  }) {
    return makeValid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NonNullParamTransformation value)? makeNonNull,
    TResult Function(ValidParamTransformation value)? makeValid,
    TResult Function(NullParamTransformation value)? makeNull,
    required TResult orElse(),
  }) {
    if (makeValid != null) {
      return makeValid(this);
    }
    return orElse();
  }
}

abstract class ValidParamTransformation implements ParamTransformation {
  const factory ValidParamTransformation() = _$ValidParamTransformation;
}

/// @nodoc
abstract class _$$NullParamTransformationCopyWith<$Res> {
  factory _$$NullParamTransformationCopyWith(_$NullParamTransformation value,
          $Res Function(_$NullParamTransformation) then) =
      __$$NullParamTransformationCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NullParamTransformationCopyWithImpl<$Res>
    extends _$ParamTransformationCopyWithImpl<$Res, _$NullParamTransformation>
    implements _$$NullParamTransformationCopyWith<$Res> {
  __$$NullParamTransformationCopyWithImpl(_$NullParamTransformation _value,
      $Res Function(_$NullParamTransformation) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NullParamTransformation implements NullParamTransformation {
  const _$NullParamTransformation();

  @override
  String toString() {
    return 'ParamTransformation.makeNull()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NullParamTransformation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? maskNb, String? validationName) makeNonNull,
    required TResult Function() makeValid,
    required TResult Function() makeNull,
  }) {
    return makeNull();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? maskNb, String? validationName)? makeNonNull,
    TResult? Function()? makeValid,
    TResult? Function()? makeNull,
  }) {
    return makeNull?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? maskNb, String? validationName)? makeNonNull,
    TResult Function()? makeValid,
    TResult Function()? makeNull,
    required TResult orElse(),
  }) {
    if (makeNull != null) {
      return makeNull();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NonNullParamTransformation value) makeNonNull,
    required TResult Function(ValidParamTransformation value) makeValid,
    required TResult Function(NullParamTransformation value) makeNull,
  }) {
    return makeNull(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NonNullParamTransformation value)? makeNonNull,
    TResult? Function(ValidParamTransformation value)? makeValid,
    TResult? Function(NullParamTransformation value)? makeNull,
  }) {
    return makeNull?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NonNullParamTransformation value)? makeNonNull,
    TResult Function(ValidParamTransformation value)? makeValid,
    TResult Function(NullParamTransformation value)? makeNull,
    required TResult orElse(),
  }) {
    if (makeNull != null) {
      return makeNull(this);
    }
    return orElse();
  }
}

abstract class NullParamTransformation implements ParamTransformation {
  const factory NullParamTransformation() = _$NullParamTransformation;
}
