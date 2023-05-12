import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/shared_parameter.dart';
import 'package:modddels/src/core/info/validation_info/ssealed/_ssealed_validation_info_resolver.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';

/// Holds information about the validation aspect of the annotated super-sealed
/// class.
///
class SSealedValidationInfo {
  SSealedValidationInfo._({
    required this.allValidationSteps,
    required this.validParametersTemplate,
  });

  /// ## Parameters :
  ///
  /// - [caseModddelsInfos] : A list that contains the [ModddelInfo] of each
  ///   case-modddel.
  ///
  factory SSealedValidationInfo.from({
    required List<SharedParameter> sharedMemberParameters,
    required List<ParsedValidationStep> parsedVSteps,
    required List<ModddelInfo> caseModddelsInfos,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
  }) {
    final resolver = SSealedValidationInfoResolver.resolve(
      parsedVSteps: parsedVSteps,
      caseModddelsInfos: caseModddelsInfos,
      sharedMemberParameters: sharedMemberParameters,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    return SSealedValidationInfo._(
      allValidationSteps: resolver.validationSteps,
      validParametersTemplate: resolver.validParametersTemplate,
    );
  }

  /// The list of all the [ValidationStepInfo]s of the annotated super-sealed
  /// class. These hold information about the validationSteps and their matching
  /// "invalid-step" super-sealed classes.
  ///
  final List<ValidationStepInfo> allValidationSteps;

  /// The parameters template of the "valid" super-sealed class.
  ///
  /// NB : The parameters are all named and required.
  ///
  final ParametersTemplate validParametersTemplate;
}
