import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/templates/annotations.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';

/// A parameter's "optionality" refers to whether it is required or optional.
///
/// This enum describes the changes you want to make to the parameters of a
/// [ParametersTemplate] :
///
/// - Use [keepSame] if you want to keep the same optionality of the parameters.
/// - Use [makeAllRequired] if you want to make all parameters required.
/// - Use [makeAllOptional] if you want to make all parameters optional.
///
enum Optionality {
  keepSame,
  makeAllRequired,
  makeAllOptional,
}

/// The [ParametersTemplate] is a template that represents the parameters of a
/// constructor or a function.
///
/// The parameters can either be :
/// - (A) All [ExpandedParameter]s with [ExpandedParameter.showDefaultValue] set
///   to false. **This is the default.**
/// - (B) All [ExpandedParameter]s with [ExpandedParameter.showDefaultValue] set
///   to true.
/// - (C) All [LocalParameter]s.
///
/// Example :
///
/// ```dart
/// // The part between parenthesis is the template part.
///
/// // (A)
/// void sayHello(String name, {int? intensity});
///
/// // (B)
/// void sayHello(String name, {int? intensity = 0,})
///
/// // (C)
/// const Hello(this.name, {this.intensity = 0,})
/// ```
///
class ParametersTemplate {
  const ParametersTemplate({
    this.requiredPositionalParameters = const [],
    this.optionalPositionalParameters = const [],
    this.namedParameters = const [],
  });

  /// By default : The Parameters template is made of [ExpandedParameter]s,
  /// with [ExpandedParameter.showDefaultValue] set to false.
  ///
  @factory
  static Future<ParametersTemplate> fromParameterElements({
    required LibraryElement originLibrary,
    required BuildStep buildStep,
    required List<ParameterElement> parameters,
  }) async {
    Future<Parameter> asParameter(ParameterElement param) async {
      // Unless the parameter is a dependency param, we need to expand the type
      // aliases so that later on we properly interpret the type (whether it's
      // nullable or not, how to make it valid or nonNullable...)
      final expandTypeAliases = !param.hasDependencyAnnotation;
      return await ExpandedParameter.fromParameterElement(
        originLibrary: originLibrary,
        buildStep: buildStep,
        parameterElement: param,
        expandTypeAliases: expandTypeAliases,
        showDefaultValue: false,
      );
    }

    return ParametersTemplate(
      requiredPositionalParameters: await Future.wait(
        parameters.where((p) => p.isRequiredPositional).map(asParameter),
      ),
      optionalPositionalParameters: await Future.wait(
        parameters.where((p) => p.isOptionalPositional).map(asParameter),
      ),
      namedParameters: await Future.wait(
        parameters.where((p) => p.isNamed).map(asParameter),
      ),
    );
  }

  final List<Parameter> requiredPositionalParameters;
  final List<Parameter> optionalPositionalParameters;
  final List<Parameter> namedParameters;

  /// The list of all the positional parameters (required and optional).
  ///
  List<Parameter> get allPositionalParameters => [
        ...requiredPositionalParameters,
        ...optionalPositionalParameters,
      ];

  /// The list of all the parameters.
  ///
  List<Parameter> get allParameters => [
        ...requiredPositionalParameters,
        ...optionalPositionalParameters,
        ...namedParameters,
      ];

  @override
  String toString() {
    final buffer = StringBuffer()..writeAll(requiredPositionalParameters, ', ');

    if (buffer.isNotEmpty &&
        (optionalPositionalParameters.isNotEmpty ||
            namedParameters.isNotEmpty)) {
      buffer.write(', ');
    }
    if (optionalPositionalParameters.isNotEmpty) {
      buffer
        ..write('[')
        ..writeAll(optionalPositionalParameters, ', ')
        ..write(']');
    }
    if (namedParameters.isNotEmpty) {
      buffer
        ..write('{')
        ..writeAll(namedParameters, ', ')
        ..write('}');
    }

    return buffer.toString();
  }

  /// Returns a copy of this [ParametersTemplate] with all the parameters
  /// converted to [LocalParameter]s.
  ///
  ParametersTemplate asLocal() {
    List<Parameter> asLocal(List<Parameter> parameters) {
      return parameters.map((e) => e.toLocalParameter()).toList();
    }

    return ParametersTemplate(
      requiredPositionalParameters: asLocal(requiredPositionalParameters),
      optionalPositionalParameters: asLocal(optionalPositionalParameters),
      namedParameters: asLocal(namedParameters),
    );
  }

  /// Returns a copy of this [ParametersTemplate] with all the parameters
  /// converted to [ExpandedParameter]s.
  ///
  ParametersTemplate asExpanded({bool showDefaultValue = false}) {
    List<Parameter> asExpanded(List<Parameter> parameters) {
      return parameters
          .map((p) => p.toExpandedParameter(showDefaultValue: showDefaultValue))
          .toList();
    }

    return ParametersTemplate(
      requiredPositionalParameters: asExpanded(requiredPositionalParameters),
      optionalPositionalParameters: asExpanded(optionalPositionalParameters),
      namedParameters: asExpanded(namedParameters),
    );
  }

  /// Returns a copy of this [ParametersTemplate] with all the parameters
  /// converted to named parameters, with the desired [optionality].
  ///
  ParametersTemplate asNamed({required Optionality optionality}) {
    List<Parameter> asHasRequired(List<Parameter> parameters) =>
        parameters.map((p) => p.copyWith(hasRequired: true)).toList();

    List<Parameter> applyOptionality(List<Parameter> parameters) {
      return parameters.map((p) {
        switch (optionality) {
          case Optionality.keepSame:
            return p;
          case Optionality.makeAllRequired:
            return p.copyWith(hasRequired: true);
          case Optionality.makeAllOptional:
            return p.copyWith(hasRequired: false);
        }
      }).toList();
    }

    return ParametersTemplate(
      namedParameters: [
        ...applyOptionality(asHasRequired(requiredPositionalParameters)),
        ...applyOptionality(optionalPositionalParameters),
        ...applyOptionality(namedParameters),
      ],
    );
  }

  /// Returns a copy of this [ParametersTemplate] with the [transformParameter]
  /// callback applied to every parameter.
  ///
  ParametersTemplate transformParameters(
      Parameter Function(Parameter parameter) transformParameter) {
    return ParametersTemplate(
      requiredPositionalParameters:
          requiredPositionalParameters.map(transformParameter).toList(),
      optionalPositionalParameters:
          optionalPositionalParameters.map(transformParameter).toList(),
      namedParameters: namedParameters.map(transformParameter).toList(),
    );
  }

  /// Appends the parameters of the given [parametersTemplate] to this
  /// [ParametersTemplate]'s lists of parameters.
  ///
  ParametersTemplate append(ParametersTemplate parametersTemplate) {
    return appendParameters(
      requiredPositionalParameters:
          parametersTemplate.requiredPositionalParameters,
      optionalPositionalParameters:
          parametersTemplate.optionalPositionalParameters,
      namedParameters: parametersTemplate.namedParameters,
    );
  }

  /// Adds the given parameters to the end of this [ParametersTemplate]'s lists
  /// of parameters.
  ///
  ParametersTemplate appendParameters({
    List<Parameter>? requiredPositionalParameters,
    List<Parameter>? optionalPositionalParameters,
    List<Parameter>? namedParameters,
  }) {
    return ParametersTemplate(
      requiredPositionalParameters: [
        ...this.requiredPositionalParameters,
        ...?requiredPositionalParameters,
      ],
      optionalPositionalParameters: [
        ...this.optionalPositionalParameters,
        ...?optionalPositionalParameters,
      ],
      namedParameters: [
        ...this.namedParameters,
        ...?namedParameters,
      ],
    );
  }

  /// Returns a new [ParametersTemplate] with all parameters that satisfy the
  /// predicate [test].
  ///
  ParametersTemplate filter(bool Function(Parameter parameter) test) {
    return ParametersTemplate(
      requiredPositionalParameters:
          requiredPositionalParameters.where(test).toList(),
      optionalPositionalParameters:
          optionalPositionalParameters.where(test).toList(),
      namedParameters: namedParameters.where(test).toList(),
    );
  }

  ParametersTemplate copyWith({
    List<Parameter>? requiredPositionalParameters,
    List<Parameter>? optionalPositionalParameters,
    List<Parameter>? namedParameters,
  }) {
    return ParametersTemplate(
      requiredPositionalParameters:
          requiredPositionalParameters ?? this.requiredPositionalParameters,
      optionalPositionalParameters:
          optionalPositionalParameters ?? this.optionalPositionalParameters,
      namedParameters: namedParameters ?? this.namedParameters,
    );
  }
}
