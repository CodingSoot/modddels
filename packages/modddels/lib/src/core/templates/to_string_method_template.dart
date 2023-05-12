import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/utils.dart';

/// Template for the "toString" method, which is overridden in all concrete
/// subclasses of the annotated class.
///
class ToStringMethodTemplate {
  ToStringMethodTemplate({
    required this.concreteClassName,
    required this.fields,
  });

  /// The name of the class where the "toString" method is overridden. It's
  /// included at the beginning of the "toString" output.
  ///
  /// If null, it is omitted from the "toString" output.
  ///
  final String? concreteClassName;

  /// The fields that should be included in the "toString" output.
  ///
  final List<Parameter> fields;

  @override
  String toString() {
    final className = concreteClassName?.escaped() ?? '';

    return '''
    @override
    String toString() => '$className($parametersString)';

    ''';
  }

  String get parametersString {
    return fields.map((parameter) {
      final paramName = parameter.name;

      return '${paramName.escaped()}: ${_interpolate(paramName)}';
    }).join(', ');
  }

  /// String interpolation for a parameter named [paramName].
  ///
  /// If the parameter name contains the '$' symbol, the braces are used for the
  /// string interpolation.
  ///
  String _interpolate(String paramName) {
    if (paramName.contains(r'$')) {
      return '\${$paramName}';
    }
    return '\$$paramName';
  }
}
