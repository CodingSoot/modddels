import 'package:freezed_annotation/freezed_annotation.dart';

part 'param_transformation.freezed.dart';

/// A [ParamTransformation] represents a change that should be applied on the
/// type (or a modddel type) of a member parameter.
///
@freezed
class ParamTransformation with _$ParamTransformation {
  /// Creates a [NonNullParamTransformation]. It represents a transformation
  /// where the type (or a modddel type) of the member parameter should become
  /// non-nullable.
  ///
  const factory ParamTransformation.makeNonNull({
    /// The maskNb of the modddel type on which this transformation should be
    /// applied.
    ///
    /// This should be provided for Iterable2Entities member parameters.
    ///
    required int? maskNb,

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
    required String? validationName,
  }) = NonNullParamTransformation;

  /// Creates a [ValidParamTransformation]. It represents a transformation where
  /// the modddel type(s) of the member parameter should become "valid" (i.e it
  /// must become prefixed with 'Valid').
  ///
  /// NB : [ValidParamTransformation]s are specific to Entities (because only
  /// they have the contentValidation).
  ///
  /// NB 2 : There is no maskNb here, because this transformation is always
  /// applied on all modddel types at once (because the contentValidation
  /// verifies all modddels at once during the same validationStep).
  ///
  const factory ParamTransformation.makeValid() = ValidParamTransformation;

  /// Creates a [NullParamTransformation]. It represents a transformation where
  /// the type of the member parameter should become 'Null'.
  ///
  /// NB : [NullParamTransformation]s are specific to SimpleEntities (because
  /// only they support the '@invalidParam' annotation).
  ///
  const factory ParamTransformation.makeNull() = NullParamTransformation;
}
