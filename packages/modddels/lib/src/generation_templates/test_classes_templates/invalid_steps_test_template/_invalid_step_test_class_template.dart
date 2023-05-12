import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/arguments/argument.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/utils.dart';

/// The template for an "InvalidStepTest" for a [validationStep].
///
/// It's a callable class that tests that a modddel instance is invalid, and
/// more precisely an instance of the invalid-step union-case matching the
/// [validationStep].
///
class InvalidStepTestClassTemplate {
  InvalidStepTestClassTemplate({
    required this.classInfo,
    required this.validationStep,
  });

  final ClassInfo classInfo;
  final ValidationStepInfo validationStep;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $callMethod
    }
    ''';
  }

  GeneralIdentifiers get generalIdentifiers => classInfo.generalIdentifiers;

  ClassIdentifiers get classIdentifiers => classInfo.classIdentifiers;

  /// The declaration of the InvalidStepTest class.
  ///
  /// For example :
  ///
  /// ```dart
  /// class InvalidWeatherValueTest
  ///    extends InvalidStepTest<Weather, InvalidWeather, ValidWeather>
  /// ```
  ///
  String get classDeclaration {
    final invalidStepTestBaseClassName = GlobalIdentifiers
        .invalidStepTestBaseIdentifiers.invalidStepTestBaseClassName;

    final className = classIdentifiers.className;
    final invalidClassName = classIdentifiers.invalidClassName;
    final validClassName = classIdentifiers.validClassName;

    final declaration = ClassDeclarationTemplate(
      className: _invalidStepTestClassName,
      isAbstract: false,
      extendsClasses: [
        '$invalidStepTestBaseClassName<$className, $invalidClassName, $validClassName>'
      ],
    );

    return declaration.toString();
  }

  /// The constructor of the InvalidStepTest class.
  ///
  String get constructor {
    final testerParameter =
        GlobalIdentifiers.invalidStepTestBaseIdentifiers.istTesterParameter;
    final vStepNameParameter =
        GlobalIdentifiers.invalidStepTestBaseIdentifiers.istVStepNameParameter;

    final constructorParams = ParametersTemplate(
      requiredPositionalParameters: [
        testerParameter.copyWith(
            type: generalIdentifiers.testerIdentifiers.testerClassName)
      ],
    );

    final superArguments = ArgumentsTemplate(
      positionalArguments: [testerParameter.toArgument()],
      namedArguments: [
        vStepNameParameter.toArgument(
            argument: "'${validationStep.name.escaped()}'")
      ],
    );

    return '$_invalidStepTestClassName($constructorParams) : super($superArguments);';
  }

  /// The "call" method.
  ///
  String get callMethod {
    final invalidStepTestClassIdentifiers =
        generalIdentifiers.invalidStepTestClassIdentifiers;

    final validations = validationStep.validations;

    final modddelParamsParameter = ExpandedParameter.empty(
      name: 'params',
      type:
          '${GlobalIdentifiers.modddelParamsBaseIdentifiers.modddelParamsBaseClassName}'
          '<${classIdentifiers.className}>',
    );

    final maxTestInfoLengthParameter =
        invalidStepTestClassIdentifiers.maxTestInfoLengthParameter;

    final allStepsLocalVarName = 'allSteps';

    final descriptionLocalVarName = 'description';

    ParametersTemplate getCallMethodParameters() {
      final failureParameters = validations
          .map((validation) => generalIdentifiers
              .getFailureParameter(validation,
                  hasNullableType: !validationStep.hasOneValidation)
              .copyWith(hasRequired: true))
          .toList();

      return ParametersTemplate(
        requiredPositionalParameters: [modddelParamsParameter],
        namedParameters: [
          ...failureParameters,
          maxTestInfoLengthParameter,
          invalidStepTestClassIdentifiers.testOnParameter,
          invalidStepTestClassIdentifiers.timeoutParameter,
          invalidStepTestClassIdentifiers.skipParameter,
          invalidStepTestClassIdentifiers.tagsParameter,
          invalidStepTestClassIdentifiers.onPlatformParameter,
          invalidStepTestClassIdentifiers.retryParameter,
        ],
      );
    }

    String getDescriptionDeclaration() {
      final commonStepsMethodName = GlobalIdentifiers
          .invalidStepTestBaseIdentifiers.istCommonStepsMethodName;

      final commonStepsArgs = ArgumentsTemplate(
        positionalArguments: [
          modddelParamsParameter.toArgument(),
          maxTestInfoLengthParameter.toArgument(),
        ],
      );

      final hasFailureStepMethodName = GlobalIdentifiers
          .invalidStepTestBaseIdentifiers.istHasFailureStepMethodName;

      final hasFailureSteps = validations.map((validation) {
        final failureVariableName =
            generalIdentifiers.getFailureVariableName(validation);

        return '$hasFailureStepMethodName(\'${validation.failureType.escaped()}\', '
            '$failureVariableName, ${maxTestInfoLengthParameter.name})';
      }).join(',');

      return '''
      final $allStepsLocalVarName = [
        ...$commonStepsMethodName($commonStepsArgs),
        $hasFailureSteps
      ];

      final $descriptionLocalVarName = $allStepsLocalVarName.join('\\n');
      ''';
    }

    ArgumentsTemplate getTestArgs() {
      final modddelLocalVarName =
          GlobalIdentifiers.modddelParamsBaseIdentifiers.modddelLocalVarName;

      final toModddelMethodName =
          GlobalIdentifiers.modddelParamsBaseIdentifiers.toModddelMethodName;

      final invalidStepClassName =
          classIdentifiers.getInvalidStepClassName(validationStep);

      final isValidGetterName =
          GlobalIdentifiers.baseModddelIdentifiers.isValidGetterName;

      String getExpectSameFailures(ValidationInfo validation) {
        final failureVariableName =
            generalIdentifiers.getFailureVariableName(validation);

        final modddelFailure =
            '($modddelLocalVarName as $invalidStepClassName).$failureVariableName';

        // For the contentValidation, two ContentFailures are equal if they hold
        // the same invalidMembers, no matter their order.
        if (validation.isContentValidation) {
          final invalidMembersPropName = GlobalIdentifiers
              .failuresBaseIdentifiers.cfInvalidMembersPropName;

          if (validationStep.hasOneValidation) {
            return 'expect($modddelFailure.$invalidMembersPropName, '
                'unorderedEquals($failureVariableName.$invalidMembersPropName));';
          }
          return '''
          if($failureVariableName != null) {
            expect($modddelFailure?.$invalidMembersPropName, unorderedEquals($failureVariableName.$invalidMembersPropName));
          } else {
            expect($modddelFailure, null);
          }
          ''';
        }
        return 'expect($modddelFailure, $failureVariableName);';
      }

      final expectSameFailures =
          validations.map(getExpectSameFailures).join('\n');

      final testBodyArg = '''
      () {
        final $modddelLocalVarName = ${modddelParamsParameter.name}.$toModddelMethodName();
        expect($modddelLocalVarName, isA<$invalidStepClassName>());
        expect($modddelLocalVarName.$isValidGetterName, false);
        $expectSameFailures
      }
      ''';

      return ArgumentsTemplate(positionalArguments: [
        Argument.fromName(descriptionLocalVarName),
        Argument.fromName(testBodyArg),
      ], namedArguments: [
        invalidStepTestClassIdentifiers.testOnParameter.toArgument(),
        invalidStepTestClassIdentifiers.timeoutParameter.toArgument(),
        invalidStepTestClassIdentifiers.skipParameter.toArgument(),
        invalidStepTestClassIdentifiers.tagsParameter.toArgument(),
        invalidStepTestClassIdentifiers.onPlatformParameter.toArgument(),
        invalidStepTestClassIdentifiers.retryParameter.toArgument(),
      ]);
    }

    return '''
    void call(${getCallMethodParameters()}) {
      ${getDescriptionDeclaration()}

      test(${getTestArgs()});
    }
    ''';
  }

  /// The name of the InvalidStepTest class.
  ///
  String get _invalidStepTestClassName =>
      generalIdentifiers.invalidStepTestClassIdentifiers
          .getInvalidStepTestClassName(validationStep);
}
