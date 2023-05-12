import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/arguments/argument.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_prototypes.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_prototypes.dart';

/// This is a mixin for "validness pattern matching" methods.
///
/// As a reminder : "Validness pattern matching" is the pattern matching between
/// the different union-cases that represent the "validness" state of a _sealed
/// class_ : Valid, Invalid, etc...
///
/// This _sealed class_ can either be :
///
/// - **A modddel :** For example `Sunny` is a modddel with union-cases
///   `ValidSunny`, `InvalidSunny` and others.
/// - **The annotated ssealed class :** For example `Weather` is an annotated
///   ssealed class with ssealed union-cases `ValidWeather`, `InvalidWeather`
///   and others.
///
mixin _ValidnessPatternMatchingMixin {
  /// The [ClassInfo] of the modddel / the annotated ssealed class.
  ///
  ClassInfo get classInfo;

  /// The list of all the [ValidationStepInfo]s of the modddel / the annotated
  /// ssealed class.
  ///
  List<ValidationStepInfo> get validationSteps;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

class MapValidnessMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MapValidnessMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MapValidnessPrototype get prototype => MapValidnessPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseThrowArgumentsTemplate(prototype);
}

class MaybeMapValidnessMethod extends MaybeMapMethod
    with _ValidnessPatternMatchingMixin {
  MaybeMapValidnessMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
    required this.unionCaseParamName,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;
  @override
  final MethodBodyKind bodyKind;

  @override
  final String? unionCaseParamName;

  @override
  MaybeMapValidnessPrototype get prototype => MaybeMapValidnessPrototype(
        classInfo: classInfo,
        validationSteps: validationSteps,
      );
}

class MapOrNullValidnessMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MapOrNullValidnessMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MapOrNullValidnessPrototype get prototype => MapOrNullValidnessPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseReturnNullArgumentsTemplate(prototype);
}

class MapValidityMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MapValidityMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MapValidityPrototype get prototype => MapValidityPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments => ArgumentsTemplate(
        namedArguments: [
          Argument.fromName(GlobalIdentifiers.validCallbackParamName),
          orElseNamedCallbackParameter().toExpandedParameter().toArgument(
              argument:
                  '() => ${GlobalIdentifiers.invalidCallbackParamName}(this as ${classInfo.classIdentifiers.invalidClassName})'),
        ],
      );
}

class MaybeMapValidityMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MaybeMapValidityMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MaybeMapValidityPrototype get prototype => MaybeMapValidityPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments {
    final orElseCallbackParamName = GlobalIdentifiers.orElseCallbackParamName;

    final invalidClassName = classInfo.classIdentifiers.invalidClassName;

    return ArgumentsTemplate.fromParametersTemplate(
            prototype.parametersTemplate)
        .asAssignedWith((param) {
      if (param.name == orElseCallbackParamName) {
        return '() => $orElseCallbackParamName(this as $invalidClassName)';
      }
      return param.name;
    });
  }
}

class MapInvalidMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MapInvalidMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MapInvalidPrototype get prototype => MapInvalidPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseThrowArgumentsTemplate(prototype);
}

class MaybeMapInvalidMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MaybeMapInvalidMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MaybeMapInvalidPrototype get prototype => MaybeMapInvalidPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      ArgumentsTemplate.fromParametersTemplate(prototype.parametersTemplate);
}

class MapOrNullInvalidMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MapOrNullInvalidMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MapOrNullInvalidPrototype get prototype => MapOrNullInvalidPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseReturnNullArgumentsTemplate(prototype);
}

class WhenInvalidMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  WhenInvalidMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  WhenInvalidPrototype get prototype => WhenInvalidPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeWhenInvalidPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseThrowArgumentsTemplate(prototype);
}

class MaybeWhenInvalidMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  MaybeWhenInvalidMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  MaybeWhenInvalidPrototype get prototype => MaybeWhenInvalidPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeMapValidnessPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments {
    final vStepsArguments = validationSteps.map((vStep) {
      final invalidStepCallbackParamName =
          classInfo.generalIdentifiers.getInvalidStepCallbackParamName(vStep);

      final failuresCallbackParamName =
          classInfo.generalIdentifiers.getFailuresCallbackParamName(vStep);

      final failuresArgs = ArgumentsTemplate(
        positionalArguments: vStep.validations.map((validation) {
          final failureVariableName =
              classInfo.generalIdentifiers.getFailureVariableName(validation);

          return Argument.fromName(
              '$invalidStepCallbackParamName.$failureVariableName');
        }).toList(),
      );

      final argument = '''
      $failuresCallbackParamName != null
          ? ($invalidStepCallbackParamName) => $failuresCallbackParamName($failuresArgs)
          : null
      ''';

      return Argument(
        parameter: ExpandedParameter.empty(name: invalidStepCallbackParamName),
        argument: argument,
      );
    }).toList();

    final arguments = ArgumentsTemplate(
      namedArguments: [
        ...vStepsArguments,
        orElseNamedCallbackParameter().toExpandedParameter().toArgument(),
      ],
    );

    return arguments;
  }
}

class WhenOrNullInvalidMethod extends StandardPatternMatchingMethod
    with _ValidnessPatternMatchingMixin {
  WhenOrNullInvalidMethod({
    required this.classInfo,
    required this.validationSteps,
    required this.bodyKind,
  });

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  final MethodBodyKind bodyKind;

  @override
  WhenOrNullInvalidPrototype get prototype => WhenOrNullInvalidPrototype(
      classInfo: classInfo, validationSteps: validationSteps);

  @override
  String get maybeMapMethodName => MaybeWhenInvalidPrototype(
          classInfo: classInfo, validationSteps: validationSteps)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseReturnNullArgumentsTemplate(prototype);
}
