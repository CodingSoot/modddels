import 'package:modddels/src/core/templates/parameters/parameter.dart';

/// This class represents an [argument] that will is assigned to a [parameter].
///
/// ```dart
/// myFunction(text : 'hello');
/// // The parameter is "text", and the argument is "'hello'"
/// ```
///
class Argument {
  Argument({
    required this.parameter,
    required this.argument,
  });

  /// Creates an argument that is assigned to [parameter] and is simply
  /// its name.
  ///
  /// For example : If the parameter is named "name", then the argument is also
  /// "name".
  ///
  factory Argument.assignedToSelf(Parameter parameter) {
    return Argument(parameter: parameter, argument: parameter.name);
  }

  /// Creates an argument named [name] and that is assigned to a parameter
  /// also named [name].
  ///
  /// This is a useful shortcut to quickly create a named argument (for example
  /// 'orElse: orElse'), or when the [parameter] doesn't matter because the
  /// argument is known to be positional.
  ///
  factory Argument.fromName(String name) {
    final parameter = ExpandedParameter.empty(name: name);

    return Argument(parameter: parameter, argument: name);
  }

  /// The parameter this [Argument] is assigned to.
  ///
  final Parameter parameter;

  /// The string representing the argument.
  ///
  /// Anything can be an argument : a function invocation, a variable name,
  /// literals...
  ///
  /// For example : `age` - `14` - `doThings()` ...
  ///
  final String argument;

  @override
  String toString() {
    return argument;
  }

  Argument copyWith({
    Parameter? parameter,
    String? argument,
  }) {
    return Argument(
      parameter: parameter ?? this.parameter,
      argument: argument ?? this.argument,
    );
  }
}
