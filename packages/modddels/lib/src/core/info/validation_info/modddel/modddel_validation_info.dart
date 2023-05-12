import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/modddel/modddel_parameters_info.dart';
import 'package:modddels/src/core/info/validation_info/_unresolved_validation_info_exception.dart';
import 'package:modddels/src/core/info/validation_info/modddel/_modddel_validation_info_resolver.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:source_gen/source_gen.dart';

typedef ModddelValidationInfoConstructor<MVI extends ModddelValidationInfo>
    = MVI Function({
  required List<ParsedValidationStep> parsedVSteps,
  required ClassElement annotatedClass,
  required ModddelParametersInfo modddelParametersInfo,
  required ParameterTypeInfoMaker parameterTypeInfoMaker,
  required GeneralIdentifiers generalIdentifiers,
  required ModddelClassIdentifiers modddelClassIdentifiers,
  required SSealedClassIdentifiers? sSealedClassIdentifiers,
});

/// Holds information about the validation aspect of a modddel.
///
/// NB : All subclasses should have a factory called "fromParsedValidationSteps"
/// and which tear-off should have the same type as
/// [ModddelValidationInfoConstructor].
///
abstract class ModddelValidationInfo {
  /// The list of all the [ValidationStepInfo]s of the modddel. These hold
  /// information about the validationSteps and their matching "invalid"
  /// union-cases.
  ///
  List<ValidationStepInfo> get allValidationSteps;

  /// The parameters template of the "valid" union-case class.
  ///
  /// NB : The form of the parameters (required/optional, positional/named) is
  /// unchanged, i.e it's the same as in the factory constructor.
  ///
  ParametersTemplate get validParametersTemplate;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

/// The [ModddelValidationInfo] of a ValueObject.
///
class ValueObjectValidationInfo extends ModddelValidationInfo {
  ValueObjectValidationInfo._({
    required this.allValidationSteps,
    required this.validParametersTemplate,
  });

  factory ValueObjectValidationInfo.fromParsedValidationSteps({
    required List<ParsedValidationStep> parsedVSteps,
    required ClassElement annotatedClass,
    required ModddelParametersInfo modddelParametersInfo,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    final ValueObjectValidationInfoResolver resolver;

    try {
      resolver = ValueObjectValidationInfoResolver.resolve(
        parsedVSteps: parsedVSteps,
        modddelParametersInfo: modddelParametersInfo,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
        generalIdentifiers: generalIdentifiers,
        modddelClassIdentifiers: modddelClassIdentifiers,
        sSealedClassIdentifiers: sSealedClassIdentifiers,
      );
    } on UnresolvedValidationException catch (exception) {
      throw InvalidGenerationSourceError(
        exception.toString(),
        element: annotatedClass,
      );
    }

    return ValueObjectValidationInfo._(
      allValidationSteps: resolver.allValidationSteps,
      validParametersTemplate: resolver.validParametersTemplate,
    );
  }

  @override
  final List<ValidationStepInfo> allValidationSteps;

  @override
  final ParametersTemplate validParametersTemplate;
}

/* -------------------------------- Entities -------------------------------- */

/// The [ModddelValidationInfo] of an Entity.
///
/// In an Entity, the validationSteps are split into early validationSteps,
/// the content validationStep and late validationSteps.
///
class EntityValidationInfo extends ModddelValidationInfo {
  EntityValidationInfo._({
    required this.earlyValidationSteps,
    required this.contentValidationStep,
    required this.lateValidationSteps,
    required this.validParametersTemplate,
  });

  factory EntityValidationInfo.fromParsedValidationSteps({
    required List<ParsedValidationStep> parsedVSteps,
    required ClassElement annotatedClass,
    required ModddelParametersInfo modddelParametersInfo,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    final EntityValidationInfoResolver resolver;

    try {
      resolver = EntityValidationInfoResolver.resolve(
        parsedVSteps: parsedVSteps,
        modddelParametersInfo: modddelParametersInfo,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
        generalIdentifiers: generalIdentifiers,
        modddelClassIdentifiers: modddelClassIdentifiers,
        sSealedClassIdentifiers: sSealedClassIdentifiers,
      );
    } on UnresolvedValidationException catch (exception) {
      throw InvalidGenerationSourceError(
        exception.toString(),
        element: annotatedClass,
      );
    }

    return EntityValidationInfo._(
      earlyValidationSteps: resolver.earlyValidationSteps,
      contentValidationStep: resolver.contentValidationStep,
      lateValidationSteps: resolver.lateValidationSteps,
      validParametersTemplate: resolver.validParametersTemplate,
    );
  }

  /// The early validationSteps info. These are the validationSteps that come
  /// before the [contentValidationStep].
  ///
  final List<ValidationStepInfo> earlyValidationSteps;

  /// The content validationStep info. It's the validationStep that contains
  /// the contentValidation.
  ///
  final ValidationStepInfo contentValidationStep;

  /// The late validationSteps info. These are the validationSteps that come
  /// after the [contentValidationStep].
  ///
  final List<ValidationStepInfo> lateValidationSteps;

  @override
  final ParametersTemplate validParametersTemplate;

  @override
  List<ValidationStepInfo> get allValidationSteps => [
        ...earlyValidationSteps,
        contentValidationStep,
        ...lateValidationSteps,
      ];

  /// The index of the content validationStep.
  ///
  int get contentValidationStepIndex =>
      allValidationSteps.indexOf(contentValidationStep);
}
