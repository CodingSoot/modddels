import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';
import 'package:modddels/src/generation_templates/validation_steps_templates/modddel/_holder_modddel_template.dart';
import 'package:modddels/src/generation_templates/validation_steps_templates/modddel/_invalid_step_modddel_template.dart';
import 'package:modddels/src/generation_templates/validation_steps_templates/modddel/_subholder_modddel_template.dart';

/// The template for the classes of the validationSteps.
///
/// It includes for each validationStep :
///
/// - [InvalidStepModddelTemplate]
/// - [HolderModddelTemplate]
/// - [SubHolderModddelTemplate]
///
abstract class ValidationStepsModddelTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends ModddelGenerationTemplate<SI, MI> {
  ValidationStepsModddelTemplate({
    required this.sSealedInfo,
    required this.modddelInfo,
  });

  @override
  final MI modddelInfo;

  @override
  final SI? sSealedInfo;

  @override
  String toString() {
    return modddelInfo.modddelValidationInfo.allValidationSteps
        .map(_makeValidationStepClasses)
        .join('\n');
  }

  /// Generates the [HolderModddelTemplate] of the given [validationStep].
  ///
  HolderModddelTemplate _makeHolderTemplate(ValidationStepInfo validationStep);

  String _makeValidationStepClasses(ValidationStepInfo validationStep) {
    final invalidStepModddelTemplate = InvalidStepModddelTemplate(
      modddelInfo: modddelInfo,
      sSealedInfo: sSealedInfo,
      validationStep: validationStep,
    );

    final holderTemplate = _makeHolderTemplate(validationStep);

    // NB : This list can be empty if the validationStep only contains the
    // contentValidation.
    final subholdersModddelTemplates = validationStep.validations
        .where((validation) => !validation.isContentValidation)
        .map((validation) => SubHolderModddelTemplate(
              sSealedInfo: sSealedInfo,
              modddelInfo: modddelInfo,
              validation: validation,
            ))
        .toList();

    return '''
    $invalidStepModddelTemplate

    $holderTemplate

    ${subholdersModddelTemplates.join('\n')}
    ''';
  }
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ---------------------- ValueObjects & SimpleEntities --------------------- */

class NonIterablesValidationStepsModddelTemplate
    extends ValidationStepsModddelTemplate<SSealedInfo, ModddelInfo> {
  NonIterablesValidationStepsModddelTemplate({
    required super.sSealedInfo,
    required super.modddelInfo,
  });

  @override
  HolderModddelTemplate _makeHolderTemplate(
          ValidationStepInfo validationStep) =>
      NonIterablesHolderModddelTemplate(
        modddelInfo: modddelInfo,
        sSealedInfo: sSealedInfo,
        validationStep: validationStep,
      );
}

/* ---------------------------- IterablesEntities --------------------------- */

class IterableEntityValidationStepsModddelTemplate
    extends ValidationStepsModddelTemplate<IterableEntitySSealedInfo,
        IterableEntityModddelInfo> {
  IterableEntityValidationStepsModddelTemplate({
    required super.sSealedInfo,
    required super.modddelInfo,
  });

  @override
  HolderModddelTemplate _makeHolderTemplate(
          ValidationStepInfo validationStep) =>
      IterableHolderModddelTemplate(
        modddelInfo: modddelInfo,
        sSealedInfo: sSealedInfo,
        validationStep: validationStep,
      );
}

class Iterable2EntityValidationStepsModddelTemplate
    extends ValidationStepsModddelTemplate<Iterable2EntitySSealedInfo,
        Iterable2EntityModddelInfo> {
  Iterable2EntityValidationStepsModddelTemplate({
    required super.sSealedInfo,
    required super.modddelInfo,
  });

  @override
  HolderModddelTemplate _makeHolderTemplate(
          ValidationStepInfo validationStep) =>
      Iterable2HolderModddelTemplate(
        modddelInfo: modddelInfo,
        sSealedInfo: sSealedInfo,
        validationStep: validationStep,
      );
}
