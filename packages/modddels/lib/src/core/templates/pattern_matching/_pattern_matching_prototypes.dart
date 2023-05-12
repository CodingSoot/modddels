import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/templates/parameters/callback_parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';

/// The kind of the pattern matching method. It can either be :
/// - A [map] method : The callback parameters are the union-cases.
/// - A [when] method : The callback parameters are the failures of the invalid
///   union-cases.
///
enum PatternMatchKind {
  map,
  when,
}

/// The prototype of a pattern matching method.
///
/// For example :
///
/// ```dart
/// TResult maybeMapWeather<TResult extends Object?>({
///   TResult Function(InvalidSunny invalidSunny)? sunny,
///   TResult Function(InvalidRainy invalidRainy)? rainy,
///   required TResult Function() orElse,
/// });
/// ```
///
abstract class PatternMatchingPrototype {
  /// The name of the pattern matching method.
  ///
  String get methodName;

  /// The return type of the pattern matching method.
  ///
  bool get isReturnTypeNullable;

  /// The kind of the pattern matching method. See [PatternMatchKind].
  ///
  PatternMatchKind get patternMatchKind;

  /// The list of named callback parameters.
  ///
  List<CallbackParameter> get namedCallbackParameters;

  /// The list of positional callback parameters. All positional callback
  /// parameters are required.
  ///
  List<CallbackParameter> get positionalCallbackParameters => [];

  /// The [ParametersTemplate] that represents all the parameters of the
  /// pattern matching method.
  ///
  ParametersTemplate get parametersTemplate => ParametersTemplate(
      requiredPositionalParameters: positionalCallbackParameters
          .map((p) => p.toExpandedParameter())
          .toList(),
      namedParameters:
          namedCallbackParameters.map((p) => p.toExpandedParameter()).toList());

  @override
  String toString() {
    final returnType = isReturnTypeNullable ? 'TResult?' : 'TResult';

    return '$returnType $methodName<TResult extends Object?>($parametersTemplate)';
  }
}

/// Returns an "orElse" named required callback parameter.
///
/// For example : `required TResult Function() orElse`.
///
/// You can optionally provide the [parameters] of the callback function.
///
CallbackParameter orElseNamedCallbackParameter({
  ParametersTemplate parameters = const ParametersTemplate(),
}) {
  return CallbackParameter(
    name: GlobalIdentifiers.orElseCallbackParamName,
    returnType: 'TResult',
    hasRequired: true,
    isNullable: false,
    decorators: const [],
    parameters: parameters,
  );
}
