import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// A [ParamTransformation] with the index of the validationStep after which
/// it is applied.
///
/// The [vStepIndex] is '-1' if the [transformation] is preexistent.
///
class IndexedParamTransformation {
  IndexedParamTransformation(this.vStepIndex, this.transformation);

  /// The index of the validationStep of the transformation.
  ///
  final int vStepIndex;

  final ParamTransformation transformation;

  IndexedParamTransformation copyWith({
    int? vStepIndex,
    ParamTransformation? transformation,
  }) {
    return IndexedParamTransformation(
      vStepIndex ?? this.vStepIndex,
      transformation ?? this.transformation,
    );
  }
}

extension ParamTransformationsAsIndexed on List<ParamTransformation> {
  /// Converts this list of [ParamTransformation]s to a list of
  /// [IndexedParamTransformation]s with the given [vStepIndex].
  ///
  List<IndexedParamTransformation> asIndexed(int vStepIndex) {
    return map((transformation) =>
        IndexedParamTransformation(vStepIndex, transformation)).toList();
  }
}

/// This class holds a list of parameters (only their names) and the
/// transformations that will be applied on them across all validationSteps (if
/// any). The transformations are indexed, meaning they include the index of the
/// validationStep after which they are applied (See
/// [IndexedParamTransformation]).
///
/// Use [TotalTransformations.empty] to create an instance from a list of the
/// parameters you want to track, and then use [addTransformation] and
/// [addAllTransformations] to populate the parameters' transformations.
///
class TotalTransformations {
  /// Creates an empty [TotalTransformations] for keeping track of the
  /// transformations of the [trackedParameters].
  ///
  TotalTransformations.empty({
    required List<Parameter> trackedParameters,
  }) : _map = <String, List<IndexedParamTransformation>>{
          for (final param in trackedParameters) param.name: [],
        } {
    final paramNames = trackedParameters.map((param) => param.name).toList();

    if (paramNames.toSet().length != paramNames.length) {
      throw ArgumentError('The tracked parameters should have unique names',
          'trackedParameters');
    }
  }

  /// A map where the keys are the names of the tracked parameters, and the
  /// values are the transformations that will be applied on them across all
  /// validationSteps, or an empty list if there are none.
  ///
  /// The transformations are indexed, meaning they include the index of the
  /// validationStep after which they are applied (See
  /// [IndexedParamTransformation]).
  ///
  final Map<String, List<IndexedParamTransformation>> _map;

  /// The list of the names of the parameters for which we are tracking their
  /// transformations.
  ///
  List<String> get parametersNames => _map.keys.toList();

  /// Adds the [indexedTransformation] of the parameter named [paramName].
  ///
  /// The [paramName] must be a tracked parameter's name.
  ///
  void addTransformation(
      String paramName, IndexedParamTransformation indexedTransformation) {
    _map.update(
      paramName,
      (value) => [...value, indexedTransformation],
      ifAbsent: () => throw ArgumentError.value(
          paramName, 'paramName', 'Not a tracked parameter.'),
    );
  }

  /// Adds all the [indexedTransformations] of the parameter named [paramName].
  ///
  /// The [paramName] must be a tracked parameter's name.
  ///
  void addAllTransformations(
    String paramName,
    List<IndexedParamTransformation> indexedTransformations,
  ) {
    _map.update(
      paramName,
      (value) => [...value, ...indexedTransformations],
      ifAbsent: () => throw ArgumentError.value(
          paramName, 'paramName', 'Not a tracked parameter.'),
    );
  }

  /// Returns all the indexed transformations of the parameter named
  /// [paramName].
  ///
  /// The [paramName] must be a tracked parameter's name.
  ///
  List<IndexedParamTransformation> getTransformations(String paramName) {
    final result = _map[paramName];

    if (result == null) {
      throw ArgumentError.value(
          paramName, 'paramName', 'Not a tracked parameter.');
    }

    return result;
  }
}
