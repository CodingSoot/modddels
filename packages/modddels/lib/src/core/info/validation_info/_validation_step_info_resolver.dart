import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/validation_info/_vstep_transformations.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';

/// This is a resolver that creates the [ValidationStepInfo] of a
/// validationStep, and produces the [nextParametersTemplate].
///
class ValidationStepInfoResolver {
  ValidationStepInfoResolver._({
    required this.validationStepInfo,
    required this.nextParametersTemplate,
  });

  /// Creates the [ValidationStepInfo] of the validationStep represented by
  /// [parsedVStep]. Also produces the parameters template of the next
  /// validationStep, or of the "valid" union-case class if this is the last
  /// validationStep.
  ///
  /// ## Parameters :
  ///
  /// - [vStepParametersTemplate] : The parameters template of the
  ///   validationStep, which contains the member parameters with all
  ///   transformations of the previous validationSteps applied.
  /// - [vStepTransformations] : The [VStepTransformations] of the
  ///   validationStep, which contains the member parameters' transformations
  ///   that will be applied after this validationStep is passed.
  ///
  /// ## How it works :
  ///
  /// 1. We create the [ValidationStepInfo] matching the [parsedVStep].
  ///    See [_makeValidationStepInfo].
  /// 2. We apply the transformations of the [ValidationStepInfo] on its
  ///    parameters template to produce the [nextParametersTemplate].
  ///
  factory ValidationStepInfoResolver.resolve({
    required ParsedValidationStep parsedVStep,
    required ParametersTemplate vStepParametersTemplate,
    required VStepTransformations vStepTransformations,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
  }) {
    // 1.
    final validationStepInfo = _makeValidationStepInfo(
      parsedVStep: parsedVStep,
      vStepParametersTemplate: vStepParametersTemplate,
      vStepTransformations: vStepTransformations,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    // 2.
    final nextParametersTemplate = _applyTransformations(
        parametersTemplate: vStepParametersTemplate,
        // Equals [vStepTransformations]
        vStepTransformations: validationStepInfo.vStepTransformations,
        parameterTypeInfoMaker: parameterTypeInfoMaker);

    return ValidationStepInfoResolver._(
      validationStepInfo: validationStepInfo,
      nextParametersTemplate: nextParametersTemplate,
    );
  }

  /// The resolved [ValidationStepInfo].
  ///
  final ValidationStepInfo validationStepInfo;

  /// The parameters template of the next validationStep, or of
  /// the "valid" union-case class if this is the last validationStep.
  ///
  /// This is made by applying the transformations of the validationStep on its
  /// parameters template.
  ///
  final ParametersTemplate nextParametersTemplate;
}

/// Creates the [ValidationStepInfo] of the validationStep represented by
/// [parsedVStep].
///
/// ## Parameters :
///
/// - [vStepParametersTemplate] : The parameters template of the validationStep,
///   which contains the member parameters with all transformations of the
///   previous validationSteps applied.
/// - [vStepTransformations] : The [VStepTransformations] of the validationStep,
///   which contains the member parameters' transformations that will be applied
///   after this validationStep is passed.
///
///   Note that this method solely relies on the [vStepTransformations] for
///   anything related to transformations (nullFailure parameters...).
///
/// ## How it works :
///
/// A. We create the [ValidationInfo]s matching the validations of the
///    validationStep. To do so :
///    1. The [NonNullParamTransformation]s of each validation are extracted
///       from the [vStepTransformations].
///       - NB : In this step, the transformations that have a `validationName`
///         set to null are ignored.
///    2. These transformations are applied on the validationStep's parameters
///       template in order to produce the
///       [ValidationInfo.subHolderParametersTemplate].
///    3. We also collect the [ValidationInfo.nullFailureParameters].
///
/// B. We create the [ValidationStepInfo] :
///    1. We ensure the validationStep name has already been replace by a
///       default name in case it was null.
///    2. We collect the [ValidationStepInfo.nullFailureParameters].
///
ValidationStepInfo _makeValidationStepInfo({
  required ParsedValidationStep parsedVStep,
  required ParametersTemplate vStepParametersTemplate,
  required VStepTransformations vStepTransformations,
  required ParameterTypeInfoMaker parameterTypeInfoMaker,
}) {
  final allVStepParameters = vStepParametersTemplate.allParameters;

  // A.
  final validationsInfo = parsedVStep.parsedValidations.map((validation) {
    // 1.
    final validationNonNullTransformations =
        vStepTransformations.whereNonNullTransformations(
      (makeNonNull) => makeNonNull.validationName == validation.validationName,
    );

    // 2.
    final subHolderParametersTemplate = _applyTransformations(
      parametersTemplate: vStepParametersTemplate,
      vStepTransformations: validationNonNullTransformations,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    // 3.
    final nullFailureParameters = validationNonNullTransformations
        .getParametersWithTransformations(allVStepParameters);

    return ValidationInfo(
      validationName: validation.validationName,
      failureType: validation.failureType,
      isContentValidation: validation.isContentValidation,
      subHolderParametersTemplate: subHolderParametersTemplate,
      nullFailureParameters: nullFailureParameters,
    );
  }).toList();

  // B.

  // 1.
  final vStepName = parsedVStep.name;

  if (vStepName == null) {
    throw ArgumentError(
        'The "null" validationStep name should have been replaced by a default '
            'name.',
        'parsedVStep');
  }

  // 2.
  final nullFailureParameters = vStepTransformations
      .whereNonNullTransformations()
      .getParametersWithTransformations(allVStepParameters);

  final validationStepInfo = ValidationStepInfo(
    parametersTemplate: vStepParametersTemplate,
    name: vStepName,
    validations: validationsInfo,
    nullFailureParameters: nullFailureParameters,
    vStepTransformations: vStepTransformations,
  );

  return validationStepInfo;
}

/// Applies the transformations of [vStepTransformations] on the
/// [parametersTemplate], and returns the resulting [ParametersTemplate].
///
/// ## How it works :
///
/// We apply the transformations on the type (or a modddelType) of the
/// parameter, one at a time.
///
/// A. For a [NonNullParamTransformation] :
///   - If the parameter is of an Iterable2Entity : We make the modddel type
///     matching the maskNb of the transformation non-nullable.
///   - Or else : We make the type (or modddel type) non-nullable.
///
/// B. For [ValidParamTransformation]s : We make the type (or all modddel
///   type(s)) "valid".
///
/// C. For [NullParamTransformation]s :
///    - If the parameter is "normal" : We make the type 'Null'.
///    - Other cases are not possible, because SimpleEntities are the only
///      modddel kind that can have [NullParamTransformation]s (because only
///      they support '@invalidParam'), and SimpleEntities only have "normal"
///      parameters.
///
ParametersTemplate _applyTransformations({
  required ParametersTemplate parametersTemplate,
  required VStepTransformations vStepTransformations,
  required ParameterTypeInfoMaker parameterTypeInfoMaker,
}) {
  return parametersTemplate.transformParameters((parameter) {
    final paramTransformations =
        vStepTransformations.getTransformations(parameter.name);

    var result = parameter;
    for (final paramTransformation in paramTransformations) {
      final typeInfo = parameterTypeInfoMaker(result);

      final newType = paramTransformation.when(
        // A.
        makeNonNull: (maskNb, validationName) {
          return typeInfo.maybeMap(
            iterable2: (iterable2) {
              if (maskNb == 1) {
                return iterable2.nonNullable.modddel1;
              }
              if (maskNb == 2) {
                return iterable2.nonNullable.modddel2;
              }
              throw UnreachableError();
            },
            orElse: () => typeInfo.nonNullable.all,
          );
        },

        // B.
        makeValid: () => typeInfo.valid.all,

        // C.
        makeNull: () => typeInfo.maybeMap(
            normal: (normal) => 'Null',
            orElse: () {
              throw UnreachableError();
            }),
      );

      result = result.copyWith(type: newType);
    }
    return result;
  });
}
