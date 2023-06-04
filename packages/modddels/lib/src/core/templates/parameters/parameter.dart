import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_null_failure.dart';
import 'package:modddels/src/core/templates/annotations.dart';
import 'package:modddels/src/core/templates/arguments/argument.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/class_members/property.dart';
import 'package:modddels/src/core/tools/element.dart';

/// This class represents a parameter of a constructor or a function/method. A
/// [Parameter] can either be an [ExpandedParameter] or a [LocalParameter].
///
abstract class Parameter {
  /// If this parameter was constructed from a [ParameterElement] using
  /// [ExpandedParameter.fromParameterElement], then returns that
  /// parameterElement.
  ///
  /// Otherwise returns null.
  ///
  ParameterElement? get parameterElement;

  /// The name of this parameter.
  ///
  String get name;

  /// The type of this parameter.
  ///
  String get type;

  /// The default value of this parameter, if any.
  ///
  String? get defaultValue;

  /// Whether the parameter is preceded with the "required" keyword.
  ///
  bool get hasRequired;

  /// The list of decorators of this parameter.
  ///
  List<String> get decorators;

  /// Whether to show the [defaultValue] of the parameter when possible.
  ///
  /// See [ExpandedParameter.showDefaultValue] and
  /// [LocalParameter.showDefaultValue].
  ///
  bool get showDefaultValue;

  /// The documentation of this parameter.
  ///
  /// It is not included in the [toString] of the parameter, since the parameter
  /// itself doesn't need to be documented. However, when converting the
  /// parameter to a [Getter] or a [Property], the documentation is included in
  /// their `toString` output.
  ///
  String get doc;

  /// Whether the parameter has the `@validParam` annotation or the
  /// `@validWithGetter` annotation.
  ///
  bool get hasValidAnnotation;

  /// Whether the parameter has the `@invalidParam` annotation or the
  /// `@invalidWithGetter` annotation.
  ///
  bool get hasInvalidAnnotation;

  /// Whether the parameter has the `@withGetter` annotation, the
  /// `@validWithGetter` annotation, or the `@invalidWithGetter` annotation.
  ///
  bool get hasWithGetterAnnotation;

  /// Whether the parameter has the `@NullFailure` annotation.
  ///
  bool get hasNullFailureAnnotation => nullFailures.isNotEmpty;

  /// Whether the parameter has the `@dependencyParam` annotation.
  ///
  bool get hasDependencyAnnotation;

  /// The list of the `@NullFailure` annotations of the parameter.
  ///
  List<ParsedNullFailure> get nullFailures;

  /// Whether the parameter has a default value.
  ///
  bool get hasDefaultValue => defaultValue != null;

  /// Whether this parameter is an [ExpandedParameter] or a [LocalParameter].
  ///
  bool get isExpandedParameter;

  /// Converts this parameter to an [ExpandedParameter].
  ///
  ExpandedParameter toExpandedParameter({bool showDefaultValue = false}) {
    return ExpandedParameter(
      parameterElement: parameterElement,
      name: name,
      type: type,
      defaultValue: defaultValue,
      hasRequired: hasRequired,
      decorators: decorators,
      doc: doc,
      showDefaultValue: showDefaultValue,
      hasValidAnnotation: hasValidAnnotation,
      hasInvalidAnnotation: hasInvalidAnnotation,
      hasWithGetterAnnotation: hasWithGetterAnnotation,
      hasDependencyAnnotation: hasDependencyAnnotation,
      nullFailures: nullFailures,
    );
  }

  /// Converts this parameter to a [LocalParameter].
  ///
  LocalParameter toLocalParameter() {
    return LocalParameter(
      parameterElement: parameterElement,
      name: name,
      type: type,
      defaultValue: defaultValue,
      hasRequired: hasRequired,
      decorators: decorators,
      doc: doc,
      hasValidAnnotation: hasValidAnnotation,
      hasInvalidAnnotation: hasInvalidAnnotation,
      hasWithGetterAnnotation: hasWithGetterAnnotation,
      hasDependencyAnnotation: hasDependencyAnnotation,
      nullFailures: nullFailures,
    );
  }

  /// Creates an [Argument] that is assigned to this [Parameter].
  ///
  /// If [argument] is not provided, the argument is simply the name of the
  /// parameter.
  ///
  Argument toArgument({String? argument}) {
    return Argument(
      parameter: this,
      argument: argument ?? name,
    );
  }

  /// **NB :** Copying with null values is not implemented.
  ///
  Parameter copyWith({
    ParameterElement? parameterElement,
    String? name,
    String? type,
    String? defaultValue,
    bool? hasRequired,
    List<String>? decorators,
    bool? showDefaultValue,
    String? doc,
    bool? hasValidAnnotation,
    bool? hasInvalidAnnotation,
    bool? hasWithGetterAnnotation,
    bool? hasDependencyAnnotation,
    List<ParsedNullFailure>? nullFailures,
  }) {
    return isExpandedParameter
        ? ExpandedParameter(
            parameterElement: parameterElement ?? this.parameterElement,
            name: name ?? this.name,
            type: type ?? this.type,
            defaultValue: defaultValue ?? this.defaultValue,
            hasRequired: hasRequired ?? this.hasRequired,
            decorators: decorators ?? this.decorators,
            showDefaultValue: showDefaultValue ?? this.showDefaultValue,
            doc: doc ?? this.doc,
            hasValidAnnotation: hasValidAnnotation ?? this.hasValidAnnotation,
            hasInvalidAnnotation:
                hasInvalidAnnotation ?? this.hasInvalidAnnotation,
            hasWithGetterAnnotation:
                hasWithGetterAnnotation ?? this.hasWithGetterAnnotation,
            hasDependencyAnnotation:
                hasDependencyAnnotation ?? this.hasDependencyAnnotation,
            nullFailures: nullFailures ?? this.nullFailures,
          )
        : LocalParameter(
            parameterElement: parameterElement ?? this.parameterElement,
            name: name ?? this.name,
            type: type ?? this.type,
            defaultValue: defaultValue ?? this.defaultValue,
            hasRequired: hasRequired ?? this.hasRequired,
            decorators: decorators ?? this.decorators,
            doc: doc ?? this.doc,
            hasValidAnnotation: hasValidAnnotation ?? this.hasValidAnnotation,
            hasInvalidAnnotation:
                hasInvalidAnnotation ?? this.hasInvalidAnnotation,
            hasWithGetterAnnotation:
                hasWithGetterAnnotation ?? this.hasWithGetterAnnotation,
            hasDependencyAnnotation:
                hasDependencyAnnotation ?? this.hasDependencyAnnotation,
            nullFailures: nullFailures ?? this.nullFailures,
          );
  }
}

extension ParametersListAs on List<Parameter> {
  /// Converts the list of parameters to a list of properties.
  ///
  /// If [isLate] is true, the resulting properties are late.
  ///
  List<Property> asPropreties({bool isLate = false}) {
    return map((p) => Property.fromParameter(p, isLate: isLate)).toList();
  }

  /// Converts the list of parameters to a list of getters.
  ///
  /// All returned getters have the same [implementation]. You can provide it,
  /// or keep it null if they don't have an implementation. See
  /// [Getter.implementation].
  ///
  List<Getter> asGetters({
    required String? implementation,
  }) {
    return map((p) => Getter.fromParameter(p, implementation: implementation))
        .toList();
  }
}

/// An [ExpandedParameter] represents a parameter which type is displayed. For
/// example : `String name`
///
/// **The [toString] adapts to the provided arguments :**
///
/// If [hasRequired] is true, then the 'required' keyword is added. For example
/// : `required String name`
///
/// If [defaultValue] is provided, and [showDefaultValue] is set to true, and
/// [hasRequired] is false, then the default value of the parameter is appended.
/// For example : `String name = 'Dash'`
///
/// If [decorators] are provided, then those are included too. For example :
/// `@deprecated String name`
///
class ExpandedParameter extends Parameter {
  ExpandedParameter({
    this.parameterElement,
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.hasRequired,
    required this.decorators,
    required this.doc,
    this.showDefaultValue = false,
    required this.hasValidAnnotation,
    required this.hasInvalidAnnotation,
    required this.hasWithGetterAnnotation,
    required this.hasDependencyAnnotation,
    required this.nullFailures,
  });

  ExpandedParameter.empty({
    this.parameterElement,
    required this.name,
    this.type = 'dynamic', // TODO see if it shouldn't be empty instead.
    this.defaultValue,
    this.hasRequired = false,
    this.decorators = const [],
    this.doc = '',
    this.showDefaultValue = false,
    this.hasValidAnnotation = false,
    this.hasInvalidAnnotation = false,
    this.hasWithGetterAnnotation = false,
    this.hasDependencyAnnotation = false,
    this.nullFailures = const [],
  });

  @override
  final ParameterElement? parameterElement;

  @override
  final String name;

  @override
  final String type;

  @override
  final String? defaultValue;

  @override
  final bool hasRequired;

  @override
  final List<String> decorators;

  /// Whether to show the [defaultValue] if it's provided.
  ///
  /// Defaults to `false`.
  ///
  /// NB : If [hasRequired] is true, then the [defaultValue] is never shown
  /// because a required parameter can't have a default value.
  ///
  @override
  final bool showDefaultValue;

  @override
  final String doc;

  @override
  final bool hasValidAnnotation;

  @override
  final bool hasInvalidAnnotation;

  @override
  final bool hasWithGetterAnnotation;

  @override
  final bool hasDependencyAnnotation;

  @override
  final List<ParsedNullFailure> nullFailures;

  @override
  bool get isExpandedParameter => true;

  @override
  String toString() {
    var res = ' $type $name';
    if (hasRequired) {
      res = 'required $res';
    }
    if (decorators.isNotEmpty) {
      res = '${decorators.join()} $res';
    }

    // A required parameter can't have a default value
    if (showDefaultValue && defaultValue != null && !hasRequired) {
      res = '$res = $defaultValue';
    }
    return res;
  }

  @factory
  static Future<ExpandedParameter> fromParameterElement({
    required LibraryElement originLibrary,
    required ParameterElement parameterElement,
    required BuildStep buildStep,
    required bool expandTypeAliases,
    bool showDefaultValue = false,
  }) async {
    final doc = await documentationOf(parameterElement, buildStep);
    return ExpandedParameter(
      parameterElement: parameterElement,
      name: parameterElement.name,
      type: parseTypeSource(
        originLibrary,
        parameterElement,
        expandTypeAliases: expandTypeAliases,
      ),
      defaultValue: parameterElement.defaultValueCode,
      hasRequired: parameterElement.isRequiredNamed,
      decorators: parseDecorators(parameterElement),
      doc: doc,
      showDefaultValue: showDefaultValue,
      hasValidAnnotation: parameterElement.hasValidAnnotation,
      hasInvalidAnnotation: parameterElement.hasInvalidAnnotation,
      hasWithGetterAnnotation: parameterElement.hasWithGetterAnnotation,
      hasDependencyAnnotation: parameterElement.hasDependencyAnnotation,
      nullFailures:
          await parameterElement.getParsedNullFailures(buildStep: buildStep),
    );
  }
}

/// A [LocalParameter] represents a parameter which is assigned to "this". For
/// example : `this.name`
///
/// **The [toString] adapts to the provided arguments :**
///
/// If [hasRequired] is true, then the 'required' keyword is added. For example
/// : `required this.name`
///
/// If [defaultValue] is provided, and [hasRequired] is false, then the default
/// value of the parameter is appended. For example : `this.name = 'Dash'`
///
/// If [decorators] are provided, then those are included too. For example :
/// `@deprecated String name`
///
class LocalParameter extends Parameter {
  LocalParameter({
    this.parameterElement,
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.hasRequired,
    required this.decorators,
    required this.doc,
    required this.hasValidAnnotation,
    required this.hasInvalidAnnotation,
    required this.hasWithGetterAnnotation,
    required this.hasDependencyAnnotation,
    required this.nullFailures,
  });

  LocalParameter.empty({
    this.parameterElement,
    required this.name,
    this.type = 'dynamic',
    this.defaultValue,
    this.hasRequired = false,
    this.decorators = const [],
    this.doc = '',
    this.hasValidAnnotation = false,
    this.hasInvalidAnnotation = false,
    this.hasWithGetterAnnotation = false,
    this.hasDependencyAnnotation = false,
    this.nullFailures = const [],
  });

  @override
  final ParameterElement? parameterElement;

  @override
  final String name;

  @override
  final String type;

  @override
  final String? defaultValue;

  @override
  final bool hasRequired;

  @override
  final List<String> decorators;

  /// For a [LocalParameter], the [defaultValue] is always shown when it's
  /// provided.
  ///
  /// NB : If [hasRequired] is true, then the [defaultValue] is not shown
  /// because a required parameter can't have a default value.
  ///
  @override
  bool get showDefaultValue => true;

  @override
  final String doc;

  @override
  final bool hasValidAnnotation;

  @override
  final bool hasInvalidAnnotation;

  @override
  final bool hasWithGetterAnnotation;

  @override
  final bool hasDependencyAnnotation;

  @override
  final List<ParsedNullFailure> nullFailures;

  @override
  bool get isExpandedParameter => false;

  @override
  String toString() {
    var res = 'this.$name';
    if (hasRequired) {
      res = 'required $res';
    }
    if (decorators.isNotEmpty) {
      res = '${decorators.join()} $res';
    }

    // A required parameter can't have a default value
    if (showDefaultValue && defaultValue != null && !hasRequired) {
      res = '$res = $defaultValue';
    }
    return res;
  }
}

/// Returns the decorators except `@required` and all modddels annotations.
///
List<String> parseDecorators(ParameterElement parameterElement) {
  return parameterElement.metadata
      .where((annotation) =>
          !annotation.isRequired &&
          [
            validAnnotationInfo,
            invalidAnnotationInfo,
            withGetterAnnotationInfo,
            validWithGetterAnnotationInfo,
            invalidWithGetterAnnotationInfo,
            nullFailureAnnotationInfo,
            dependencyParamAnnotationInfo,
          ].every((annotationInfo) => !annotationInfo.matches(
                annotation,
                annotatedElement: parameterElement,
              )))
      .map((annotation) => annotation.toSource())
      .toList();
}
