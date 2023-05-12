import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_type_info.freezed.dart';

/// Holds information about the type of a member parameter of a Modddel.
///
@freezed
class ParameterTypeInfo with _$ParameterTypeInfo {
  const ParameterTypeInfo._();

  /// This is the type info of a member parameter of a ValueObject or
  /// SimpleEntity. This kind of member parameters is "normal", meaning that
  /// it is not a collection of other modddels.
  ///
  /// Example : For a parameter which type is 'Username?' :
  ///
  /// - [nonNullable.all] == 'Username'
  /// - [nullable.all] == 'Username?'
  /// - [valid.all] == 'ValidUsername?'
  ///
  const factory ParameterTypeInfo.normal({
    required TransformedType nonNullable,
    required TransformedType nullable,
    required TransformedType valid,
  }) = NormalParameterTypeInfo;

  /// This is the type info of the member parameter of an IterableEntity.
  ///
  /// Example : For a member parameter which type is 'KtList<Username>' in a
  /// KtListEntity :
  ///
  /// - [nonNullable.all] == 'KtList<Username>'
  /// - [nullable.all] == 'KtList<Username?>'
  /// - [valid.all] == 'KtList<ValidUsername>'
  /// - [modddelType] == 'Username'
  ///
  const factory ParameterTypeInfo.iterable({
    required TransformedType nonNullable,
    required TransformedType nullable,
    required TransformedType valid,

    /// The type of the modddel matching the mask (#1)
    required String modddelType,
  }) = IterableParameterTypeInfo;

  /// This is the type info of the member parameter of an [Iterable2Entity].
  ///
  /// Each of [nonNullable], [nullable] and [valid] has 3 different fields :
  /// - `all` : The type of the parameter with both modddels are
  ///   nonNullable/nullable/valid
  /// - `modddel1` : The type of the parameter with modddel1 being
  ///   nonNullable/nullable/valid
  /// - `modddel2` : The type of the parameter with modddel2 being
  ///   nonNullable/nullable/valid
  ///
  /// Example : For a member parameter which type is 'KtMap<Username?, User?>'
  /// in a KtMapEntity :
  ///
  /// - [nonNullable.all] == 'KtMap<Username, User>'
  /// - [nonNullable.modddel1] == 'KtMap<Username, User?>'
  /// - [nonNullable.modddel2] == 'KtMap<Username?, User>'
  /// - [nullable.all] == [nullable.modddel1] == [nullable.modddel2] ==
  ///   'KtMap<Username?, User?>'
  /// - [valid.all] == 'KtMap<ValidUsername?, ValidUser?>'
  /// - [valid.modddel1] == 'KtMap<ValidUsername?, User?>'
  /// - [valid.modddel2] == 'KtMap<Username?, ValidUser?>'
  /// - [modddel1Type] == 'Username?'
  /// - [modddel2Type] == 'User?'
  ///
  const factory ParameterTypeInfo.iterable2({
    required TransformedTypeIter2 nonNullable,
    required TransformedTypeIter2 nullable,
    required TransformedTypeIter2 valid,

    /// The type of the modddel matching the mask (#1)
    required String modddel1Type,

    /// The type of the modddel matching the mask (#2)
    required String modddel2Type,
  }) = Iterable2ParameterTypeInfo;
}

class TransformedType {
  TransformedType({
    required this.all,
  });

  final String all;
}

class TransformedTypeIter2 extends TransformedType {
  TransformedTypeIter2({
    required String all,
    required this.modddel1,
    required this.modddel2,
  }) : super(all: all);

  final String modddel1;

  final String modddel2;
}
