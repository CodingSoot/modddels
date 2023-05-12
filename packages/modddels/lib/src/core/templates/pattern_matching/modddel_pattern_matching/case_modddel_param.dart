import 'package:modddels/src/core/templates/parameters/parameter.dart';

/// A [CaseModddelParam] is a parameter that represents a case-modddel. It is
/// used as a parameter inside a callback parameter of a modddel pattern
/// matching method.
///
/// For example :
///
/// ```dart
/// TResult mapWeather<TResult extends Object?>({
///    required TResult Function(InvalidSunny invalidSunny) sunny,
///    required TResult Function(InvalidRainy invalidRainy) rainy,
///  }) //...
/// ```
///
/// In this example, the two [CaseModddelParam]s are `InvalidSunny invalidSunny`
/// and `InvalidRainy invalidRainy`.
///
class CaseModddelParam {
  CaseModddelParam({
    required this.name,
    required this.type,
  });

  CaseModddelParam.fromParameter(Parameter parameter)
      : name = parameter.name,
        type = parameter.type;

  final String name;
  final String type;

  ExpandedParameter toExpandedParameter() {
    return ExpandedParameter.empty(name: name, type: type);
  }
}
