import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/shared_parameter.dart';
import 'package:modddels/src/core/info/validation_info/_validation_step_info_resolver.dart';
import 'package:modddels/src/core/info/validation_info/_vstep_transformations.dart';
import 'package:modddels/src/core/info/validation_info/modddel/modddel_validation_info.dart';
import 'package:modddels/src/core/info/validation_info/ssealed/_ssealed_vsteps_transformations_computer.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:collection/collection.dart';

/// This is a resolver that creates the [ValidationStepInfo]s and the
/// [validParametersTemplate] of the annotated super-sealed class.
///
class SSealedValidationInfoResolver {
  SSealedValidationInfoResolver._({
    required this.validationSteps,
    required this.validParametersTemplate,
  });

  /// Creates the [ValidationStepInfo]s and the [validParametersTemplate] of the
  /// annotated super-sealed class.
  ///
  /// ## Parameters :
  ///
  /// - [caseModddelsInfos] : A list that contains the [ModddelInfo] of each
  ///   case-modddel.
  ///
  /// ## How it works :
  ///
  /// 1. We replace the names of the validationSteps with the ones that have
  ///    already been resolved for the case-modddels.
  /// 2. We use the [SSealedVStepsTransformationsComputer] to compute the
  ///    "common" transformations of all the validationSteps.
  /// 3. We create the `sharedMemberParametersTemplate`, which contains the
  ///    shared member parameters as named and required parameters, and will be
  ///    used as the parameters template of the first validationStep of the
  ///    annotated super-sealed class (See
  ///    [ValidationStepInfo.parametersTemplate]).
  /// 4. We iteratively pass the computed transformations and the
  ///    `sharedMemberParametersTemplate` to a [ValidationStepInfoResolver] in
  ///    order to create the [ValidationStepInfo]s and the
  ///    [validParametersTemplate] of the annotated super-sealed class.
  ///
  factory SSealedValidationInfoResolver.resolve({
    required List<ParsedValidationStep> parsedVSteps,
    required List<SharedParameter> sharedMemberParameters,
    required List<ModddelInfo> caseModddelsInfos,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
  }) {
    // 1.
    final caseModddelsValidationInfos = caseModddelsInfos
        .map((modddelInfo) => modddelInfo.modddelValidationInfo)
        .toList();

    final resolvedNames =
        _resolveNames(parsedVSteps, caseModddelsValidationInfos);

    // 2.
    final computer = SSealedVStepsTransformationsComputer.compute(
      sharedMemberParameters: sharedMemberParameters,
      caseModddelsInfos: caseModddelsInfos,
      vStepsCount: parsedVSteps.length,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    // 3.
    final sharedMemberParametersTemplate = ParametersTemplate(
      namedParameters: sharedMemberParameters.asExpandedParameters(),
    ).asNamed(optionality: Optionality.makeAllRequired);

    // 4.
    final resolvedInfo = _resolveInfo(
      resolvedNames,
      computer.vStepsTransformations,
      sharedMemberParametersTemplate: sharedMemberParametersTemplate,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    return SSealedValidationInfoResolver._(
      validationSteps: resolvedInfo.validationSteps,
      validParametersTemplate: resolvedInfo.validParametersTemplate,
    );
  }

  /// The list of all the [ValidationStepInfo]s of the annotated super-sealed
  /// class.
  ///
  final List<ValidationStepInfo> validationSteps;

  /// The parameters template of the "valid" super-sealed class.
  ///
  /// NB : The parameters are all named and required.
  ///
  final ParametersTemplate validParametersTemplate;

  /// Replaces the names of the validationSteps with the ones that have already
  /// been resolved for the case-modddels. Those are the same for all
  /// case-modddels, so we just copy them from the first case-modddel.
  ///
  /// ## Parameters :
  ///
  /// - [caseModddelsValidationInfos] : A list that contains the
  ///   [ModddelValidationInfo] of each case-modddel.
  ///
  static List<ParsedValidationStep> _resolveNames(
    List<ParsedValidationStep> parsedVSteps,
    List<ModddelValidationInfo> caseModddelsValidationInfos,
  ) {
    final caseModddelVSteps =
        caseModddelsValidationInfos.first.allValidationSteps;

    return parsedVSteps
        .mapIndexed((index, parsedVstep) =>
            parsedVstep.copyWith(name: caseModddelVSteps[index].name))
        .toList();
  }

  /// Creates the [ValidationStepInfo]s and the [validParametersTemplate] of the
  /// annotated super-sealed class.
  ///
  /// ## How it works :
  ///
  /// 1. We start with the [sharedMemberParametersTemplate], which is used as
  ///    the parameters template of the first parsed validationStep.
  /// 2. We pass the [VStepTransformations] of the validationStep to a
  ///    [ValidationStepInfoResolver] in order to create the
  ///    [ValidationStepInfo] of the validationStep and the parameters template
  ///    of the next validationStep.
  /// 3. => We repeat steps 1-2 for the next validationSteps, each time starting
  ///    with the newly created parameters template. The final parameters
  ///    template we obtain corresponds to the [validParametersTemplate].
  ///
  static _SSealedValidationInfo _resolveInfo(
    List<ParsedValidationStep> parsedVSteps,
    List<VStepTransformations> vStepsTransformations, {
    required ParametersTemplate sharedMemberParametersTemplate,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
  }) {
    var nextParameterTemplate = sharedMemberParametersTemplate;
    int vStepIndex = 0;

    ValidationStepInfo resolve(ParsedValidationStep parsedVStep) {
      final resolver = ValidationStepInfoResolver.resolve(
        vStepParametersTemplate: nextParameterTemplate,
        vStepTransformations: vStepsTransformations[vStepIndex],
        parsedVStep: parsedVStep,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
      );

      nextParameterTemplate = resolver.nextParametersTemplate;
      vStepIndex++;

      return resolver.validationStepInfo;
    }

    // NB: Using `.toList` removes the side effects risks of a lazy
    // iteratable. See  : https://stackoverflow.com/a/44302727/13297133
    final resolvedVSteps = parsedVSteps.map(resolve).toList();

    return (
      validationSteps: resolvedVSteps,
      validParametersTemplate: nextParameterTemplate,
    );
  }
}

/// The resolved validation info of the annotated super-sealed class.
///
typedef _SSealedValidationInfo = ({
  List<ValidationStepInfo> validationSteps,
  ParametersTemplate validParametersTemplate
});
