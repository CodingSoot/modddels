import 'package:modddels_annotation_internal/modddels_freezed_files.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:fpdart/fpdart.dart';

/// This class holds a list of parameters (only their names) and the
/// transformations that will be applied on them after a validationStep is
/// passed (if any).
///
/// Use [VStepTransformations.empty] to create an instance from a list of the
/// parameters you want to track, and then use [addTransformation] and
/// [addAllTransformations] to populate the parameters' transformations.
///
class VStepTransformations {
  VStepTransformations._(this._map);

  /// Creates an empty [VStepTransformations] for keeping track of the
  /// transformations of the [trackedParameters].
  ///
  VStepTransformations.empty({
    required List<Parameter> trackedParameters,
  }) : _map = <String, List<ParamTransformation>>{
          for (final param in trackedParameters) param.name: [],
        } {
    final paramNames = trackedParameters.map((param) => param.name).toList();

    if (paramNames.toSet().length != paramNames.length) {
      throw ArgumentError('The tracked parameters should have unique names',
          'trackedParameters');
    }
  }

  /// A map where the keys are the names of the tracked parameters, and the
  /// values are the transformations that will be applied on them after the
  /// validationStep is passed, or an empty list if there are none.
  ///
  final Map<String, List<ParamTransformation>> _map;

  /// The list of the names of the parameters for which we are tracking their
  /// transformations.
  ///
  List<String> get parametersNames => _map.keys.toList();

  /// The list of the names of the parameters that have at least one
  /// transformation.
  ///
  List<String> get parametersWithTransformationsNames =>
      _map.filter((value) => value.isNotEmpty).keys.toList();

  /// Returns the parameters among [parameters] that have at least one
  /// transformation.
  ///
  /// NB : All parameters in [parameters] must be tracked.
  ///
  List<Parameter> getParametersWithTransformations(List<Parameter> parameters) {
    final parametersAreTracked = parameters
        .every((parameter) => parametersNames.contains(parameter.name));

    if (!parametersAreTracked) {
      throw ArgumentError('The parameters must all be tracked.', 'parameters');
    }

    return parameters
        .where((parameter) =>
            parametersWithTransformationsNames.contains(parameter.name))
        .toList();
  }

  /// Adds the [transformation] of the parameter named [paramName].
  ///
  /// The [paramName] must be a tracked parameter's name.
  ///
  void addTransformation(String paramName, ParamTransformation transformation) {
    _map.update(
      paramName,
      (value) => [...value, transformation],
      ifAbsent: () => throw ArgumentError.value(
          paramName, 'paramName', 'Not a tracked parameter.'),
    );
  }

  /// Adds all the [transformations] of the parameter named [paramName].
  ///
  /// The [paramName] must be a tracked parameter's name.
  ///
  void addAllTransformations(
    String paramName,
    List<ParamTransformation> transformations,
  ) {
    _map.update(
      paramName,
      (value) => [...value, ...transformations],
      ifAbsent: () => throw ArgumentError.value(
          paramName, 'paramName', 'Not a tracked parameter.'),
    );
  }

  /// Returns the transformations of the parameter named [paramName].
  ///
  /// The [paramName] must be a tracked parameter's name.
  ///
  List<ParamTransformation> getTransformations(String paramName) {
    final result = _map[paramName];

    if (result == null) {
      throw ArgumentError.value(
          paramName, 'paramName', 'Not a tracked parameter.');
    }

    return result;
  }

  /// Returns a [VStepTransformations] where the transformations of the
  /// parameters are filtered so as to only keep the
  /// [NonNullParamTransformation] transformations that satisfy [predicate].
  ///
  /// NB : The tracked parameters remain the same.
  ///
  VStepTransformations whereNonNullTransformations([
    bool Function(NonNullParamTransformation makeNonNull)? predicate,
  ]) {
    final newMap = _map.mapValue((paramTransformations) {
      return paramTransformations
          .where((pt) => pt.maybeMap(
              makeNonNull: (makeNonNull) =>
                  predicate != null ? predicate(makeNonNull) : true,
              orElse: () => false))
          .toList();
    });

    return VStepTransformations._(newMap);
  }
}
