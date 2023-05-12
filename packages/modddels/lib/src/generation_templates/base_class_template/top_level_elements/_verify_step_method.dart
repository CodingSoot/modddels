import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';

/// The verifyStep method is a method that checks that a validationStep is
/// passed. It returns an `Either`, with :
///
/// - On the left : The invalid-step union-case of the validationStep. This is
///   returned if there is at least one failure.
/// - On the right : The holder of the next validationStep, or the valid
///   union-case if it's the last validationStep. This is returned if there is
///   no failure.
///
/// For example :
///
/// ```dart
/// // 1.
/// static Either<InvalidPersonLate, ValidPerson> _verifyLateStep(
///     _$PersonLateHolder holder, _$PersonDependencies dependencies) {
///
///   // 2.
///   // ignore: unused_local_variable
///   final instance = _instance();
///
///   // 3.
///   final blackListFailure = holder.verifyBlackListNullables().fold(
///         (l) => l,
///         (r) => instance.validateBlackList(r).toNullable(),
///       );
///
///   // 4.
///   if (blackListFailure == null) {
///     return right<InvalidPersonLate, ValidPerson>(
///       ValidPerson._(
///         age: holder.age,
///         name: holder.name!,
///       ).._init(dependencies),
///     );
///   }
///
///   // 5.
///   return left<InvalidPersonLate, ValidPerson>(
///     InvalidPersonLate._(
///         age: holder.age,
///         name: holder.name,
///         blackListFailure: blackListFailure).._init(dependencies),
///   );
/// }
/// ```
///
/// As you can see, it has 5 parts :
///
/// 1. The [methodDeclaration]
/// 2. The [instanceDeclaration]
/// 3. The [failuresDeclaration]
/// 4. The if block : [ifFailuresAreNull] and [returnRight]
/// 5. The [returnRight]
///
class VerifyStepMethod extends ModddelGenerationTemplate {
  VerifyStepMethod({
    required this.modddelInfo,
    required this.sSealedInfo,
    required this.validationStep,
    required this.nextValidationStep,
    required this.verifyNullablesHasInstanceArg,
    required this.validateContentHasInstanceArg,
    required this.cast,
  });

  @override
  final ModddelInfo modddelInfo;

  @override
  final SSealedInfo? sSealedInfo;

  /// Casts the argument [castedArgument] from the type of [fromParamType] to
  /// the type of [toParamType].
  ///
  final String Function(
    String castedArgument, {
    required Parameter fromParamType,
    required Parameter toParamType,
  }) cast;

  /// Represents the validationStep that comes after [validationStep].
  ///
  /// Null if [validationStep] is the last validationStep.
  ///
  final ValidationStepInfo? nextValidationStep;

  /// Whether the "validateContent" method receives an "instance" argument.
  ///
  final bool validateContentHasInstanceArg;

  /// The validationStep that is checked by this [VerifyStepMethod].
  ///
  final ValidationStepInfo validationStep;

  /// Whether the "verifyNullables" methods receive an "instance" argument.
  ///
  final bool verifyNullablesHasInstanceArg;

  @override
  String toString() {
    return '''
    $methodDeclaration {
      $instanceDeclaration

      $failuresDeclaration

      $ifFailuresAreNull {
        $returnRight
      }

      $returnLeft
    }
    ''';
  }

  String get methodDeclaration {
    final methodName =
        modddelClassIdentifiers.getVerifyMethodName(validationStep);

    final parameters = ParametersTemplate(
      requiredPositionalParameters: [
        _holderParameter,
        if (hasDependencies) _dependenciesParameter,
      ],
    );

    return '''
    static Either<$_leftType, $_rightType> $methodName($parameters)
    ''';
  }

  String get instanceDeclaration {
    final instanceMethodName =
        generalIdentifiers.topLevelMixinIdentifiers.instanceMethodName;

    return '''
    // ignore: unused_local_variable
    final $_instanceVariableName = $instanceMethodName();
    ''';
  }

  String get failuresDeclaration {
    final failures =
        validationStep.validations.map(_makeFailureDeclaration).toList();

    return failures.join('\n');
  }

  String get ifFailuresAreNull {
    final conditions = validationStep.validations.map((validation) {
      final failureVariableName =
          generalIdentifiers.getFailureVariableName(validation);

      return '$failureVariableName == null';
    }).join(' && ');

    return 'if($conditions)';
  }

  String get returnRight {
    final rightArguments =
        ArgumentsTemplate.fromParametersTemplate(_vStepParametersTemplate)
            .asNamed()
            .asAssignedWith((parameter) {
      final parameterInNext = _nextParametersTemplate.allParameters.firstWhere(
        (p) => p.name == parameter.name,
      );

      final argument = cast(
        '$_holderVariableName.${parameter.name}',
        fromParamType: parameter,
        toParamType: parameterInNext,
      );

      return argument;
    });

    final String rightValue;

    if (_isLastVStep) {
      rightValue = '$_rightType._($rightArguments)$_initDependencies,';
    } else {
      rightValue = '$_rightType($rightArguments),';
    }

    return '''
    return right<$_leftType, $_rightType>(
      $rightValue
    );
    ''';
  }

  String get returnLeft {
    final failuresArguments = validationStep.validations
        .map((validation) => generalIdentifiers
            .getFailureParameter(
              validation,
              hasNullableType: validationStep.validations.length > 1,
            )
            .toArgument())
        .toList();

    final leftArguments = ArgumentsTemplate.fromParametersTemplate(
            _vStepParametersTemplate)
        .asNamed()
        .asAssignedWith((parameter) => '$_holderVariableName.${parameter.name}')
        .appendArguments(namedArguments: failuresArguments);

    return '''
    return left<$_leftType, $_rightType>(
            $_leftType._($leftArguments)$_initDependencies,
          );
    ''';
  }

  /// Whether the [validationStep] is the last validationStep.
  ///
  bool get _isLastVStep => nextValidationStep == null;

  /// The parameters template of the [validationStep].
  ///
  ParametersTemplate get _vStepParametersTemplate =>
      validationStep.parametersTemplate;

  /// The parameters template of the [nextValidationStep], or of the valid
  /// union-case if the [validationStep] is the last one.
  ///
  ParametersTemplate get _nextParametersTemplate => _isLastVStep
      ? modddelInfo.modddelValidationInfo.validParametersTemplate
      : nextValidationStep!.parametersTemplate;

  /// The "left" return type of the verifyStep method.
  ///
  /// It's the invalid-step union-case of the [validationStep].
  ///
  String get _leftType =>
      modddelClassIdentifiers.getInvalidStepClassName(validationStep);

  /// The "right" return type of the verifyStep method.
  ///
  /// It's the holder of the [nextValidationStep], or the valid union-case if
  /// the [validationStep] is the last one.
  ///
  String get _rightType => _isLastVStep
      ? modddelClassIdentifiers.validClassName
      : modddelClassIdentifiers.getHolderClassName(nextValidationStep!);

  String get _holderVariableName =>
      modddelClassIdentifiers.getHolderVariableName(validationStep);

  ExpandedParameter get _holderParameter =>
      modddelClassIdentifiers.getHolderParameter(validationStep);

  ExpandedParameter get _dependenciesParameter =>
      modddelClassIdentifiers.dependenciesParameter;

  String get _instanceVariableName =>
      generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

  ExpandedParameter get _instanceParameter =>
      generalIdentifiers.topLevelMixinIdentifiers.instanceParameter;

  String _makeFailureDeclaration(ValidationInfo validation) {
    final validateMethodName = validation.isContentValidation
        ? modddelClassIdentifiers.getValidateContentMethodName(validation)
        : generalIdentifiers.topLevelMixinIdentifiers
            .getValidateMethodName(validation);

    final String value;

    // (A) The validation is the contentValidation
    if (validation.isContentValidation) {
      final validateContentArgs = ArgumentsTemplate(
        positionalArguments: [
          _holderParameter.toArgument(),
          if (validateContentHasInstanceArg) _instanceParameter.toArgument(),
        ],
      );

      value = '$validateMethodName($validateContentArgs).toNullable();';
    }
    // (B) The validation has nullFailures
    else if (validation.hasNullFailures) {
      final verifyNullablesMethodName = generalIdentifiers.holderIdentifiers
          .getVerifyNullablesMethodName(validation);

      final verifyNullablesArgs = ArgumentsTemplate(
        positionalArguments: [
          if (verifyNullablesHasInstanceArg) _instanceParameter.toArgument(),
          if (hasDependencies) _dependenciesParameter.toArgument(),
        ],
      );

      value = '''
        $_holderVariableName.$verifyNullablesMethodName($verifyNullablesArgs).fold(
          (l) => l,
          (r) => $_instanceVariableName.$validateMethodName(r).toNullable(),
        );
        ''';
    }
    // (C) The validation is neither of (A) nor (B)
    else {
      final toSubHolderMethodName = generalIdentifiers.holderIdentifiers
          .getToSubHolderMethodName(validation);

      final toSubHolderArgs = ArgumentsTemplate(
        positionalArguments: [
          if (hasDependencies) _dependenciesParameter.toArgument(),
        ],
      );

      value = '''
        $_instanceVariableName
          .$validateMethodName(
              $_holderVariableName.$toSubHolderMethodName($toSubHolderArgs))
          .toNullable();
        ''';
    }

    final failureVariableName =
        generalIdentifiers.getFailureVariableName(validation);

    return 'final $failureVariableName = $value';
  }

  String get _initDependencies {
    if (!hasDependencies) {
      return '';
    }

    final initMethodName =
        generalIdentifiers.topLevelMixinIdentifiers.initMethodName;

    final dependenciesVariableName =
        modddelClassIdentifiers.dependenciesVariableName;

    return '..$initMethodName($dependenciesVariableName)';
  }
}
