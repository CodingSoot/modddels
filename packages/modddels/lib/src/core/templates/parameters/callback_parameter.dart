import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';

/// This class represents a callback parameter, which is a parameter which type
/// is a function.
///
class CallbackParameter {
  CallbackParameter({
    required this.name,
    required this.returnType,
    required this.hasRequired,
    required this.isNullable,
    required this.decorators,
    required this.parameters,
  });

  /// The name of the callback parameter.
  ///
  final String name;

  /// The returnType of the function.
  ///
  /// Example :
  ///
  /// For `String Function(int a, int b) additionCallback` : The returnType is
  /// 'String'.
  ///
  final String returnType;

  /// Whether the callback parameter is preceded with the "required" keyword.
  ///
  final bool hasRequired;

  /// Whether the type of the callback parameter is nullable.
  ///
  /// Example :
  ///
  /// For `String Function(int a, int b)? additionCallback` : The type is
  /// nullable.
  ///
  final bool isNullable;

  /// The list of decorators of this callback parameter.
  ///
  final List<String> decorators;

  /// The parameters of the function.
  ///
  /// Example :
  ///
  /// For `String Function(int a, int b) additionCallback` : The parameters are
  /// `int a, int b`.
  ///
  final ParametersTemplate parameters;

  /// The type of the callback parameter.
  ///
  /// Example : `String Function(int a, int b)?`
  ///
  String get fullType {
    var res = '$returnType Function($parameters)';

    if (isNullable) {
      res = '$res?';
    }

    return res;
  }

  /// Converts this callback parameter to an [ExpandedParameter].
  ///
  ExpandedParameter toExpandedParameter() {
    return ExpandedParameter.empty(
      name: name,
      type: fullType,
      hasRequired: hasRequired,
      decorators: decorators,
    );
  }

  @override
  String toString() {
    var res = fullType;

    if (hasRequired) {
      res = 'required $res';
    }
    if (decorators.isNotEmpty) {
      res = '${decorators.join()} $res';
    }

    return '$res  $name';
  }
}
