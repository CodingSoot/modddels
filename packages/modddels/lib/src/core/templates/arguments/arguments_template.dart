import 'package:modddels/src/core/templates/arguments/argument.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';

/// The [ArgumentsTemplate] is a template that represents the arguments that are
/// being assigned to the parameters of a constructor or a function.
///
/// Example :
///
/// ```dart
/// // The part between parenthesis is the template part.
///
/// sayHello('John', intensity: 10);
/// ```
///
class ArgumentsTemplate {
  ArgumentsTemplate({
    this.positionalArguments = const [],
    this.namedArguments = const [],
  });

  /// The list of arguments being assigned to positional parameters.
  ///
  final List<Argument> positionalArguments;

  /// The list of arguments being assigned to named parameters.
  ///
  final List<Argument> namedArguments;

  /// By default : The arguments are the names of the parameters they are
  /// assigned to. We say that they are "assigned to self".
  ///
  /// For example : If a parameter is named "name", then the argument is also
  /// "name".
  ///
  factory ArgumentsTemplate.fromParametersTemplate(
      ParametersTemplate parametersTemplate) {
    return ArgumentsTemplate(
      positionalArguments: [
        ...parametersTemplate.requiredPositionalParameters
            .map(Argument.assignedToSelf)
            .toList(),
        ...parametersTemplate.optionalPositionalParameters
            .map(Argument.assignedToSelf)
            .toList(),
      ],
      namedArguments: parametersTemplate.namedParameters
          .map(Argument.assignedToSelf)
          .toList(),
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeAll(positionalArguments.map((e) => e.argument), ', ');

    if (buffer.isNotEmpty && namedArguments.isNotEmpty) {
      buffer.write(', ');
    }

    buffer.writeAll(
        namedArguments.map((e) => '${e.parameter.name}: ${e.argument}'), ', ');

    return buffer.toString();
  }

  /// Returns a copy of this [ArgumentsTemplate] with the arguments replaced by
  /// the names of the parameters they are assigned to.
  ///
  /// For example : If a parameter is named "name", then the argument becomes
  /// "name".
  ///
  ArgumentsTemplate asAssignedToSelf() {
    Argument assignToSelf(Argument argument) {
      return argument.copyWith(argument: argument.parameter.name);
    }

    return ArgumentsTemplate(
      positionalArguments: positionalArguments.map(assignToSelf).toList(),
      namedArguments: namedArguments.map(assignToSelf).toList(),
    );
  }

  /// Returns a copy of this [ArgumentsTemplate] with the arguments replaced by
  /// the result of calling [setArgument] on each parameter they are assigned
  /// to.
  ///
  ArgumentsTemplate asAssignedWith(
      String Function(Parameter parameter) setArgument) {
    Argument assignWith(Argument argument) {
      return argument.copyWith(argument: setArgument(argument.parameter));
    }

    return ArgumentsTemplate(
      positionalArguments: positionalArguments.map(assignWith).toList(),
      namedArguments: namedArguments.map(assignWith).toList(),
    );
  }

  /// Returns a copy of this [ParametersTemplate] with all the arguments
  /// converted to being assigned to named parameters.
  ///
  ArgumentsTemplate asNamed() {
    return ArgumentsTemplate(
      namedArguments: [
        ...positionalArguments,
        ...namedArguments,
      ],
    );
  }

  /// Appends the arguments of the given [argumentsTemplate] to this
  /// [ArgumentsTemplate]'s lists of arguments.
  ///
  ArgumentsTemplate append(ArgumentsTemplate argumentsTemplate) {
    return appendArguments(
      namedArguments: argumentsTemplate.namedArguments,
      positionalArguments: argumentsTemplate.positionalArguments,
    );
  }

  /// Adds the given arguments to the end of this [ArgumentsTemplate]'s lists
  /// of arguments.
  ///
  ArgumentsTemplate appendArguments({
    List<Argument>? positionalArguments,
    List<Argument>? namedArguments,
  }) {
    return ArgumentsTemplate(
      positionalArguments: [
        ...this.positionalArguments,
        ...?positionalArguments,
      ],
      namedArguments: [
        ...this.namedArguments,
        ...?namedArguments,
      ],
    );
  }

  /// Adds the given [argument] to the end of the list of [namedArguments].
  ///
  ArgumentsTemplate appendNamedArgument(
    Argument argument,
  ) {
    return appendArguments(namedArguments: [argument]);
  }

  /// Adds the given [argument] to the end of the list of [positionalArguments].
  ///
  ArgumentsTemplate appendPositionalArgument(
    Argument argument,
  ) {
    return appendArguments(positionalArguments: [argument]);
  }

  ArgumentsTemplate copyWith({
    List<Argument>? positionalArguments,
    List<Argument>? namedArguments,
  }) {
    return ArgumentsTemplate(
      positionalArguments: positionalArguments ?? this.positionalArguments,
      namedArguments: namedArguments ?? this.namedArguments,
    );
  }
}
