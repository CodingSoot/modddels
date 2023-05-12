import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/shared_parameter.dart';
import 'package:modddels/src/core/info/validation_info/ssealed/_total_transformations.dart';
import 'package:modddels/src/core/info/validation_info/_vstep_transformations.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/utils.dart';
import 'package:collection/collection.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// Computes the "common" [VStepTransformations]s of all the validationSteps for
/// the annotated super-sealed class. That is, for each validationStep,
/// calculates the transformations that will be applied on the shared member
/// parameters after the validationStep is passed.
///
class SSealedVStepsTransformationsComputer {
  SSealedVStepsTransformationsComputer._({
    required this.vStepsTransformations,
  });

  /// Calculates the "common" [VStepTransformations]s of all the
  /// validationSteps. That is, for each validationStep, calculates the
  /// transformations that will be applied on the [sharedMemberParameters] after
  /// the validationStep is passed.
  ///
  /// ## Parameters :
  ///
  /// - [vStepsCount] : The number of validationSteps.
  /// - [caseModddelsInfos] : A list that contains the [ModddelInfo] of each
  ///   case-modddel.
  ///
  /// ## How it works :
  ///
  /// A. We create `vStepsTransformations`, which is a list of empty
  ///    [VStepTransformations]s that we will populate to become
  ///    [vStepsTransformations].
  ///
  /// B. We gather the [TotalTransformations]s of all case-modddels.
  ///
  /// C. For each shared parameter :
  ///   1. We get all its transformations (including preexistent ones) in the
  ///      different case-modddels.
  ///   2. We get its "common" transformations (See
  ///      [_getCommonIndexedTransformations]).
  ///   3. We populate the `vStepsTransformations` : Before that :
  ///      - (a) We exclude the "common" transformation that have a vStepIndex
  ///        of -1. That's because it means that it is a preexistent
  ///        transformation in all case-modddels, so we shouldn't (and we can't)
  ///        take it into account. [***]
  ///      - (b) We exclude the transformations that are set to be ignored in
  ///        [SharedProp].
  ///
  factory SSealedVStepsTransformationsComputer.compute({
    required List<SharedParameter> sharedMemberParameters,
    required int vStepsCount,
    required List<ModddelInfo> caseModddelsInfos,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
  }) {
    // A.
    final List<Parameter> sharedExpandedMemberParams =
        sharedMemberParameters.asExpandedParameters();

    final vStepsTransformations = List.generate(
      vStepsCount,
      (index) => VStepTransformations.empty(
          trackedParameters: sharedExpandedMemberParams),
    );

    // B.
    final caseModddelsTotalTransformations = caseModddelsInfos
        .map((modddelInfo) =>
            _getTotalTransformations(modddelInfo, parameterTypeInfoMaker))
        .toList();

    // C.
    for (final sharedParameter in sharedMemberParameters) {
      // 1.
      final caseModddelsParamTransformations = caseModddelsTotalTransformations
          .map((totalParamsTransformations) => totalParamsTransformations
              .getTransformations(sharedParameter.name))
          .toList();

      // 2.
      final commonIndexedTransformations =
          _getCommonIndexedTransformations(caseModddelsParamTransformations);

      // 3.
      for (final commonIndexedTransformation in commonIndexedTransformations) {
        final vStepIndex = commonIndexedTransformation.vStepIndex;

        // (3a)
        if (vStepIndex == -1) {
          continue;
        }

        // (3b)
        final ignoreTransformation =
            commonIndexedTransformation.transformation.map(
          makeValid: (_) => sharedParameter.ignoreValidTransformation,
          makeNonNull: (_) => sharedParameter.ignoreNonNullTransformation,
          makeNull: (_) => sharedParameter.ignoreNullTransformation,
        );

        if (ignoreTransformation) {
          continue;
        }

        vStepsTransformations[vStepIndex].addTransformation(
            sharedParameter.name, commonIndexedTransformation.transformation);
      }
    }

    return SSealedVStepsTransformationsComputer._(
      vStepsTransformations: vStepsTransformations,
    );
  }

  /// The list of the [VStepTransformations]s of all the validationSteps.
  ///
  /// The index of each [VStepTransformations] in this list matches the index
  /// of its validationStep.
  ///
  final List<VStepTransformations> vStepsTransformations;
}

/// Returns the [TotalTransformations] of the case-modddel which info is
/// [modddelInfo]. It contains all the transformations of the member parameters
/// of the modddel across all validationSteps, including preexistent
/// transformations. The transformations are indexed (meaning they include the
/// index of the validationStep after which they are applied).
///
/// ## How it works :
///
/// 1. We add the transformations of each validationStep, with as an index the
///    index of the validationStep.
/// 2. We add the preexistent transformations. These have an index of -1.
///
TotalTransformations _getTotalTransformations(
  ModddelInfo modddelInfo,
  ParameterTypeInfoMaker parameterTypeInfoMaker,
) {
  final memberParameters =
      modddelInfo.modddelParametersInfo.memberParametersTemplate.allParameters;

  final result =
      TotalTransformations.empty(trackedParameters: memberParameters);

  // 1.
  final validationSteps = modddelInfo.modddelValidationInfo.allValidationSteps;

  validationSteps.forEachIndexed((vStepIndex, validationStep) {
    final vStepTransformations = validationStep.vStepTransformations;

    for (final parameter in memberParameters) {
      final paramName = parameter.name;

      final indexedTransformations = vStepTransformations
          .getTransformations(paramName)
          .asIndexed(vStepIndex);

      result.addAllTransformations(paramName, indexedTransformations);
    }
  });

  // 2.
  for (final parameter in memberParameters) {
    final preexistentTransformations = _getPreexistentTransformations(
      parameter,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    result.addAllTransformations(parameter.name, preexistentTransformations);
  }

  return result;
}

/// Returns the list of the preexistent transformations of a parameter. The
/// transformations are indexed, and have an index of -1 (See
/// [IndexedParamTransformation]).
///
/// A preexistent transformation is like an implicit [ParamTransformation] that
/// has already been applied on the parameter, before the validation begins.
///
/// For instance :
///
/// - A non-null member parameter is like a nullable parameter that has had a
///   [NonNullParamTransformation].
/// - A member parameter annotated with `@validParam` is like a member parameter
///   that has had a [ValidParamTransformation].
/// - A 'Null' member parameter is like a nullable parameter that has had a
///   [NullParamTransformation]
///
List<IndexedParamTransformation> _getPreexistentTransformations(
  Parameter parameter, {
  required ParameterTypeInfoMaker parameterTypeInfoMaker,
}) {
  final result = <ParamTransformation>[];

  final typeInfo = parameterTypeInfoMaker(parameter);

  // Adding Preexistent NonNullParamTransformations
  final nonNullParamTransformations = typeInfo.map(
    normal: (normal) => [
      if (!isNullableType(parameter.type))
        const NonNullParamTransformation(maskNb: null, validationName: null),
    ],
    iterable: (iterable) => [
      if (!isNullableType(iterable.modddelType))
        const NonNullParamTransformation(maskNb: null, validationName: null),
    ],
    iterable2: (iterable2) => [
      if (!isNullableType(iterable2.modddel1Type))
        const NonNullParamTransformation(maskNb: 1, validationName: null),
      if (!isNullableType(iterable2.modddel2Type))
        const NonNullParamTransformation(maskNb: 2, validationName: null),
    ],
  );

  result.addAll(nonNullParamTransformations);

  // Adding Preexistent ValidParamTransformations.
  if (parameter.hasValidAnnotation) {
    const validParamTransformation = ValidParamTransformation();
    result.add(validParamTransformation);
  }

  // Adding Preexistent NullParamTransformations.
  //
  // NB : Preexistent NullParamTransformations only matter for SimpleEntities
  // (because they are the only modddel kind that supports '@invalidParam').
  // However, with the current implementation, they will be created for
  // ValueObjects too, but it's no problem since they will be dismissed and thus
  // won't be applied. (See comment : [***])
  final nullParamTransformation = typeInfo.mapOrNull(
    normal: (normal) =>
        isNullType(parameter.type) ? const NullParamTransformation() : null,
  );

  if (nullParamTransformation != null) {
    result.add(nullParamTransformation);
  }

  return result.asIndexed(-1);
}

/// Returns the indexed transformations of a parameter that are "common" between
/// all case-modddels.
///
/// A "common" indexed transformation is a transformation that will be applied
/// on a shared member parameter. It must :
///
/// - (a) Have a matching transformation in each case-modddel (including
///   preexistent transformations).
/// - (b) Have the highest vStepIndex among these matching transformations.
/// - (c) For [NonNullParamTransformation]s :
///    - If the matching transformations (excluding preexistent ones) all have
///      the same [NonNullParamTransformation.validationName] : The common
///      transformation's `validationName` is set to that.
///    - Otherwise, it is set to `null`.
///
///
/// As a result :
///
/// - (a) Transformations that are not present in all case-modddels are never
///   applied on a shared parameter.
/// - (b) The "common" transformation is not applied on a shared parameter until
///   it is applied on all its [SharedParameter.caseParameters].
/// - (c) The "common" [NonNullParamTransformation] is not applied in the
///   validation's ssealed subholder unless it is applied in the validation's
///   subholders in all case-modddels.
///
///   NB : Setting `validationName` to `null` only bypasses applying the
///   transformation during the validation (i.e when making the subholder
///   parameters template). The transformation is still applied after the
///   validationStep is passed.
///
/// ## Parameters :
///
/// - [caseModddelsParamTransformations] : A list that contains the list of
///   transformations of a parameter in each case-modddel.
///
/// ## How it works :
///
/// We use [intersectAllIterables] on [caseModddelsParamTransformations] such as :
///
/// A. Two transformations are considered to be equal if :
///    - They are both of the same kind.
///    - (+) For [NonNullParamTransformation]s, they should also have the same
///      [NonNullParamTransformation.maskNb].
///
/// B. Among these equal transformations :
///    1. We keep the one with the highest vStepIndex.
///    2. (+) For [NonNullParamTransformation]s (excluding preexistent ones):
///       - If they both have the same
///         [NonNullParamTransformation.validationName], we keep it.
///       - Otherwise, we set the `validationName` to `null`.
///
List<IndexedParamTransformation> _getCommonIndexedTransformations(
  List<List<IndexedParamTransformation>> caseModddelsParamTransformations,
) {
  final commonIndexedTransformations =
      intersectAllIterables<IndexedParamTransformation>(
    caseModddelsParamTransformations,

    // A.
    equals: (p0, p1) {
      final pt0 = p0.transformation;
      final pt1 = p1.transformation;

      return pt0.map(
        makeNonNull: (makeNonNull) =>
            pt1 is NonNullParamTransformation &&
            makeNonNull.maskNb == pt1.maskNb,
        makeValid: (_) => pt1 is ValidParamTransformation,
        makeNull: (_) => pt1 is NullParamTransformation,
      );
    },

    // B.
    select: (p0, p1) {
      // 1.
      final result = p0.vStepIndex > p1.vStepIndex ? p0 : p1;

      // 2.
      return result.transformation.maybeMap(
        makeNonNull: (makeNonNull) {
          // If one of the transformations is preexistent, we skip.
          if (p0.vStepIndex == -1 || p1.vStepIndex == -1) {
            return result;
          }

          // We know that the two transformations are of the same kind
          final pt0 = p0.transformation as NonNullParamTransformation;
          final pt1 = p1.transformation as NonNullParamTransformation;

          if (pt0.validationName == pt1.validationName) {
            return result;
          }

          return result.copyWith(
              transformation: makeNonNull.copyWith(validationName: null));
        },
        orElse: () => result,
      );
    },
  ).toList();

  return commonIndexedTransformations;
}
