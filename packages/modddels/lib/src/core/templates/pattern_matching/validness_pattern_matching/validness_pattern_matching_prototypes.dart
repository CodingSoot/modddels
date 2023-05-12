import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/arguments/argument.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/parameters/callback_parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_prototypes.dart';

/// The [PatternMatchingPrototype] of a "validness pattern matching" method.
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
abstract class ValidnessPatternMatchingPrototype
    extends PatternMatchingPrototype {
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

class MapValidnessPrototype extends ValidnessPatternMatchingPrototype {
  MapValidnessPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'map';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        _validNamedCallbackParameter(
          classInfo: classInfo,
          isRequired: true,
        ),
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: true,
          patternMatchKind: patternMatchKind,
        )
      ];
}

class MaybeMapValidnessPrototype extends ValidnessPatternMatchingPrototype {
  MaybeMapValidnessPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'maybeMap';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        _validNamedCallbackParameter(
          classInfo: classInfo,
          isRequired: false,
        ),
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: false,
          patternMatchKind: patternMatchKind,
        ),
        orElseNamedCallbackParameter(),
      ];
}

class MapOrNullValidnessPrototype extends ValidnessPatternMatchingPrototype {
  MapOrNullValidnessPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'mapOrNull';

  @override
  final isReturnTypeNullable = true;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        _validNamedCallbackParameter(
          classInfo: classInfo,
          isRequired: false,
        ),
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: false,
          patternMatchKind: patternMatchKind,
        )
      ];
}

class MapValidityPrototype extends ValidnessPatternMatchingPrototype {
  MapValidityPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'mapValidity';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        _validCallbackParameter,
        _invalidCallbackParameter,
      ];

  CallbackParameter get _validCallbackParameter => _validNamedCallbackParameter(
        classInfo: classInfo,
        isRequired: true,
      );

  CallbackParameter get _invalidCallbackParameter =>
      _invalidNamedCallbackParameter(
        classInfo: classInfo,
        isRequired: true,
      );

  ArgumentsTemplate makeArgumentsTemplate({
    required String Function(CallbackParameter validCallbackParameter)
        validArgument,
    required String Function(CallbackParameter invalidCallbackParameter)
        invalidArgument,
  }) {
    final validCallbackParam = _validCallbackParameter;
    final invalidCallbackParam = _invalidCallbackParameter;

    final validArg = Argument(
      parameter: validCallbackParam.toExpandedParameter(),
      argument: validArgument(validCallbackParam),
    );

    final invalidArg = Argument(
      parameter: invalidCallbackParam.toExpandedParameter(),
      argument: invalidArgument(invalidCallbackParam),
    );

    return ArgumentsTemplate(namedArguments: [
      validArg,
      invalidArg,
    ]);
  }
}

class MaybeMapValidityPrototype extends ValidnessPatternMatchingPrototype {
  MaybeMapValidityPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'maybeMapValidity';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        _validNamedCallbackParameter(
          classInfo: classInfo,
          isRequired: true,
        ),
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: false,
          patternMatchKind: patternMatchKind,
        ),
        orElseNamedCallbackParameter(
          parameters: ParametersTemplate(
            requiredPositionalParameters: [
              classInfo.classIdentifiers.invalidParameter,
            ],
          ),
        ),
      ];
}

class MapInvalidPrototype extends ValidnessPatternMatchingPrototype {
  MapInvalidPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'mapInvalid';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: true,
          patternMatchKind: patternMatchKind,
        ),
      ];
}

class MaybeMapInvalidPrototype extends ValidnessPatternMatchingPrototype {
  MaybeMapInvalidPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'maybeMapInvalid';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: false,
          patternMatchKind: patternMatchKind,
        ),
        orElseNamedCallbackParameter(),
      ];
}

class MapOrNullInvalidPrototype extends ValidnessPatternMatchingPrototype {
  MapOrNullInvalidPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'mapOrNullInvalid';

  @override
  final isReturnTypeNullable = true;

  @override
  final patternMatchKind = PatternMatchKind.map;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: false,
          patternMatchKind: patternMatchKind,
        ),
      ];
}

class WhenInvalidPrototype extends ValidnessPatternMatchingPrototype {
  WhenInvalidPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'whenInvalid';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.when;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: true,
          patternMatchKind: patternMatchKind,
        ),
      ];
}

class MaybeWhenInvalidPrototype extends ValidnessPatternMatchingPrototype {
  MaybeWhenInvalidPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'maybeWhenInvalid';

  @override
  final isReturnTypeNullable = false;

  @override
  final patternMatchKind = PatternMatchKind.when;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: false,
          patternMatchKind: patternMatchKind,
        ),
        orElseNamedCallbackParameter(),
      ];
}

class WhenOrNullInvalidPrototype extends ValidnessPatternMatchingPrototype {
  WhenOrNullInvalidPrototype({
    required this.classInfo,
    required this.validationSteps,
  });

  @override
  final String methodName = 'whenOrNullInvalid';

  @override
  final isReturnTypeNullable = true;

  @override
  final patternMatchKind = PatternMatchKind.when;

  @override
  final ClassInfo classInfo;

  @override
  final List<ValidationStepInfo> validationSteps;

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        ..._vStepsNamedCallbackParameters(
          validationSteps,
          classInfo: classInfo,
          areRequired: false,
          patternMatchKind: patternMatchKind,
        ),
      ];
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

/// Returns a "valid" named callback parameter.
///
/// For example : `required TResult Function(ValidSunny validSunny) valid`.
///
/// If [isRequired] is true, the named callback parameter is required and has a
/// non-nullable type. If not, it is optional and has a nullable type.
///
CallbackParameter _validNamedCallbackParameter({
  required ClassInfo classInfo,
  required bool isRequired,
}) {
  return CallbackParameter(
    name: GlobalIdentifiers.validCallbackParamName,
    returnType: 'TResult',
    hasRequired: isRequired,
    isNullable: !isRequired,
    decorators: const [],
    parameters: ParametersTemplate(requiredPositionalParameters: [
      classInfo.classIdentifiers.validParameter,
    ]),
  );
}

/// Returns an "invalid" named callback parameter.
///
/// For example : `required TResult Function(InvalidSunny invalidSunny) invalid`
///
/// If [isRequired] is true, the named callback parameter is required and has a
/// non-nullable type. If not, it is optional and has a nullable type.
///
CallbackParameter _invalidNamedCallbackParameter({
  required ClassInfo classInfo,
  required bool isRequired,
}) {
  return CallbackParameter(
    name: GlobalIdentifiers.invalidCallbackParamName,
    returnType: 'TResult',
    hasRequired: isRequired,
    isNullable: !isRequired,
    decorators: const [],
    parameters: ParametersTemplate(
      requiredPositionalParameters: [
        classInfo.classIdentifiers.invalidParameter,
      ],
    ),
  );
}

/// Returns the named callback parameters representing the given
/// [validationSteps].
///
/// If [areRequired] is true, the named callback parameters are required and
/// have a non-nullable type. If not, they are optional and have a nullable
/// type.
///
/// If [patternMatchKind] equals :
/// - [PatternMatchKind.map] : The parameters of those callback parameters are
///   the invalid-step union-cases names. The callback names are
///   [ValidationStepInfo.invalidCallbackParamName].
///
///   Example : `required TResult Function(InvalidSunnyValue invalidSunnyValue)
///   invalidValue`
///
/// - [PatternMatchKind.when] : The parameters of those callback parameters are
///   the failures. The callback names are
///   [ValidationStepInfo.failuresCallbackParamName].
///
///   Example : `required TResult Function(WeatherHabitableFailure
///   habitableFailure) valueFailures`
///
List<CallbackParameter> _vStepsNamedCallbackParameters(
  List<ValidationStepInfo> validationSteps, {
  required ClassInfo classInfo,
  required bool areRequired,
  required PatternMatchKind patternMatchKind,
}) {
  // Returns the [CallbackParameter.parameters] for the [validationStep].
  ParametersTemplate makeParameters(ValidationStepInfo validationStep) {
    final List<Parameter> parameters;
    switch (patternMatchKind) {
      case PatternMatchKind.map:
        parameters = [
          classInfo.classIdentifiers.getInvalidStepParameter(validationStep)
        ];
        break;

      case PatternMatchKind.when:
        final validations = validationStep.validations;

        // If there's more than one failure, their types should be nullable.
        bool areParamsNullable = validations.length > 1;

        parameters = validations
            .map((validation) =>
                classInfo.generalIdentifiers.getFailureParameter(
                  validation,
                  hasNullableType: areParamsNullable,
                ))
            .toList();
        break;
    }

    return ParametersTemplate(requiredPositionalParameters: parameters);
  }

  return validationSteps
      .map((vStep) => CallbackParameter(
            name: patternMatchKind == PatternMatchKind.when
                ? classInfo.generalIdentifiers
                    .getFailuresCallbackParamName(vStep)
                : classInfo.generalIdentifiers
                    .getInvalidStepCallbackParamName(vStep),
            returnType: 'TResult',
            hasRequired: areRequired,
            isNullable: !areRequired,
            decorators: const [],
            parameters: makeParameters(vStep),
          ))
      .toList();
}
