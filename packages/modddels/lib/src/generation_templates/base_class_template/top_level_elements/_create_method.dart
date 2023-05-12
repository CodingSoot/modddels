import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';

/// The "create" method is the entry point for creating an instance of a
/// modddel.
///
/// For example :
///
///  ```dart
///  // 1.
///  static Person _create(
///      {required Age age,
///      required FullName? name,
///      required MyService myService}) {
///    // 2.
///    final $personDependencies = _$PersonDependencies(myService: myService);
///
///    // 3.
///    final personMidHolder = _$PersonMidHolder(age: age, name: name);
///
///    // 4.
///    return _verifyMidStep(personMidHolder, $personDependencies).fold(
///      (invalidPersonMid) => invalidPersonMid,
///      (personLateHolder) => _verifyLateStep(personLateHolder, $personDependencies)
///          .fold((invalidPersonLate) => invalidPersonLate,
///              (validPerson) => validPerson),
///    );
///  }
///  ```
///
/// As you can see, it has 4 parts :
///
/// 1. The [methodDeclaration]
/// 2. If the modddel has dependencies : The [dependenciesDeclaration]
/// 3. The [firstHolderDeclaration]
/// 4. The [returnResult]
///
class CreateMethod extends ModddelGenerationTemplate {
  CreateMethod({
    required this.modddelInfo,
    required this.sSealedInfo,
    required this.firstHolderArgumentsTemplate,
  });

  @override
  final ModddelInfo modddelInfo;

  @override
  final SSealedInfo? sSealedInfo;

  final ArgumentsTemplate firstHolderArgumentsTemplate;

  @override
  String toString() {
    return '''
    $methodDeclaration {

      ${hasDependencies ? dependenciesDeclaration : ''}

      $firstHolderDeclaration

      $returnResult
    }
    ''';
  }

  String get methodDeclaration {
    final methodName = modddelClassIdentifiers.createMethodName;

    final parameters = modddelInfo
        .modddelParametersInfo.constructorParametersTemplate
        .asNamed(optionality: Optionality.makeAllRequired);

    return 'static ${modddelClassIdentifiers.className} $methodName($parameters)';
  }

  String get dependenciesDeclaration {
    assert(hasDependencies);

    final dependenciesVariableName =
        modddelClassIdentifiers.dependenciesVariableName;

    final dependenciesClassName = modddelClassIdentifiers.dependenciesClassName;

    final dependenciesArguments = ArgumentsTemplate.fromParametersTemplate(
            modddelInfo.modddelParametersInfo.dependencyParametersTemplate)
        .asNamed();

    return '''
    final $dependenciesVariableName = $dependenciesClassName(
        $dependenciesArguments
      );
    ''';
  }

  String get firstHolderDeclaration {
    final firstValidationStep = _allValidationSteps.first;

    final firstHolderVariableName =
        modddelClassIdentifiers.getHolderVariableName(firstValidationStep);

    final firstHolderClassName =
        modddelClassIdentifiers.getHolderClassName(firstValidationStep);

    return '''
    final $firstHolderVariableName = 
        $firstHolderClassName($firstHolderArgumentsTemplate);
    ''';
  }

  String get returnResult {
    final result = _verifyRecursive(
      _allValidationSteps.length,
      _allValidationSteps,
    );

    return 'return $result';
  }

  List<ValidationStepInfo> get _allValidationSteps =>
      modddelInfo.modddelValidationInfo.allValidationSteps;

  String _verifyRecursive(
      int totalValidationStepsCount, List<ValidationStepInfo> validationSteps) {
    final comma =
        validationSteps.length == totalValidationStepsCount ? ';' : ',';

    if (validationSteps.isEmpty) {
      return modddelClassIdentifiers.validVariableName;
    }

    final validationStep = validationSteps.first;

    final nextValidationStep =
        validationSteps.length > 1 ? validationSteps[1] : null;

    final verifyMethodName =
        modddelClassIdentifiers.getVerifyMethodName(validationStep);

    final verifyMethodArguments = ArgumentsTemplate(
      positionalArguments: [
        modddelClassIdentifiers.getHolderParameter(validationStep).toArgument(),
        if (hasDependencies)
          modddelClassIdentifiers.dependenciesParameter.toArgument(),
      ],
    );

    final leftParameterName =
        modddelClassIdentifiers.getInvalidStepVariableName(validationStep);

    final rightParameterName = nextValidationStep != null
        ? modddelClassIdentifiers.getHolderVariableName(nextValidationStep)
        : modddelClassIdentifiers.validVariableName;

    final recurse = _verifyRecursive(
      totalValidationStepsCount,
      [...validationSteps]..removeAt(0),
    );

    return '''
      $verifyMethodName($verifyMethodArguments).fold(
        ($leftParameterName) => $leftParameterName,
        ($rightParameterName) => $recurse
      )$comma
      ''';
  }
}
