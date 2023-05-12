import 'package:modddels/src/core/info/parameters_info/_parameter_kind.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// Holds information about a shared parameter (or shared property), which
/// is a property that has been defined as being shared between all the
/// case-modddels of an annotated super-sealed class.
///
class SharedParameter {
  SharedParameter({
    required this.name,
    required this.type,
    required this.ignoreValidTransformation,
    required this.ignoreNonNullTransformation,
    required this.ignoreNullTransformation,
    required this.caseParameters,
    required this.parameterKind,
  });

  /// See [SharedProp.name]
  ///
  final String name;

  /// See [SharedProp.type]
  ///
  final String type;

  /// See [SharedProp.ignoreValidTransformation]
  ///
  final bool ignoreValidTransformation;

  /// See [SharedProp.ignoreNonNullTransformation]
  ///
  final bool ignoreNonNullTransformation;

  /// See [SharedProp.ignoreNullTransformation]
  ///
  final bool ignoreNullTransformation;

  /// A shared property has a parameter in all factory constructors (i.e in all
  /// case-modddels). This is the list of those parameters.
  ///
  /// For example : If the property 'username' is shared, then this list
  /// consists of the 'username' parameter in each case-modddel.
  ///
  final List<Parameter> caseParameters;

  /// The [caseParameters] are always of the same kind, which is
  /// [parameterKind].
  ///
  final ParameterKind parameterKind;

  /// Whether the [caseParameters] have the same type as this shared property's
  /// [type].
  ///
  bool get caseParametersHaveSameType {
    if (caseParameters.map((p) => p.type).toSet().length == 1) {
      final commonCaseType = caseParameters.first.type;
      return type == commonCaseType;
    }
    return false;
  }

  /// Converts this [SharedParameter] to an [ExpandedParameter].
  ///
  /// [ExpandedParameter.hasWithGetterAnnotation] is true if all the
  /// [caseParameters] are annotated with either `@withGetter`,
  /// `@validWithGetter` or `@invalidWithGetter`.
  ///
  ExpandedParameter toExpandedParameter() {
    return ExpandedParameter.empty(
        name: name,
        type: type,
        hasWithGetterAnnotation:
            caseParameters.all((p) => p.hasWithGetterAnnotation));
  }
}

extension SharedParametersAsExpandedParameters on List<SharedParameter> {
  /// Converts this list of [SharedParameter]s to a list of
  /// [ExpandedParameter]s.
  ///
  /// For more details, see [SharedParameter.toExpandedParameter].
  ///
  List<ExpandedParameter> asExpandedParameters() {
    return map((sharedParameter) => sharedParameter.toExpandedParameter())
        .toList();
  }
}
