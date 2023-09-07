import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/modddel/modddel_parameters_info.dart';
import 'package:modddels/src/core/info/validation_info/_unresolved_validation_info_exception.dart';
import 'package:modddels/src/core/info/validation_info/_validation_step_info_resolver.dart';
import 'package:modddels/src/core/info/validation_info/modddel/_modddel_vstep_transformations_computer.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:modddels/src/core/utils.dart';
import 'package:source_gen/source_gen.dart';

/// This is a resolver that creates the [ValidationStepInfo]s and the
/// [validParametersTemplate] of a modddel.
///
abstract class ModddelValidationInfoResolver {
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

/// The [ModddelValidationInfoResolver] for a ValueObject.
///
class ValueObjectValidationInfoResolver extends ModddelValidationInfoResolver {
  ValueObjectValidationInfoResolver._({
    required this.allValidationSteps,
    required this.validParametersTemplate,
  });

  /// Creates the [ValidationStepInfo]s and the [validParametersTemplate] of a
  /// ValueObject.
  ///
  /// Before doing so, ensures that the parsed validationSteps are valid as to
  /// their :
  ///
  /// 1. Number : There should be at least one validationStep.
  /// 2. Validations :
  ///     - The "failureTypes" should be provided (i.e be non-dynamic) and be
  ///       non-nullable.
  ///     - There shouldn't be any contentValidation.
  /// 3. Names :
  ///    - The validationSteps names that were omitted are replaced by default
  ///      ones.
  ///    - The names of the validationSteps should be valid (See
  ///      [ValidationStepInfo.nameRegex]) and unique.
  ///    - The names of the validations should be valid (See
  ///      [ValidationInfo.validationNameRegex]) and unique.
  ///    - The names of the validations shouldn't conflict with the parameters
  ///      names as to the reserved names.
  /// 4. References :
  ///    - The '@NullFailure' annotations should reference existing validations.
  ///
  /// Throws an [UnresolvedValidationException] if the validationSteps are not
  /// all valid.
  ///
  factory ValueObjectValidationInfoResolver.resolve({
    required List<ParsedValidationStep> parsedVSteps,
    required ModddelParametersInfo modddelParametersInfo,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    // 1.
    _assertNotEmpty(parsedVSteps);

    // 2.
    _assertValidFailureTypes(parsedVSteps);

    _assertNoContentValidation(parsedVSteps);

    // 3.
    final parsedVStepsWithNames = _resolveNames(parsedVSteps);

    _assertValidNames(parsedVStepsWithNames);

    // 4.
    _assertValidNullFailureReferences(
      memberParametersTemplate: modddelParametersInfo.memberParametersTemplate,
      parsedVSteps: parsedVStepsWithNames,
    );
    // ---

    final resolvedInfo = _resolveInfo(
      parsedVStepsWithNames,
      memberParametersTemplate: modddelParametersInfo.memberParametersTemplate,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    // (3) continued
    _assertNoConflictingNames(
      allValidationSteps: resolvedInfo.allValidationSteps,
      constructorParametersTemplate:
          modddelParametersInfo.constructorParametersTemplate,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
    );

    return ValueObjectValidationInfoResolver._(
      allValidationSteps: resolvedInfo.allValidationSteps,
      validParametersTemplate: resolvedInfo.validParametersTemplate,
    );
  }

  @override
  final List<ValidationStepInfo> allValidationSteps;

  @override
  final ParametersTemplate validParametersTemplate;

  static void _assertNoContentValidation(
      List<ParsedValidationStep> parsedVSteps) {
    for (final parsedVStep in parsedVSteps) {
      if (parsedVStep.containsContentValidation) {
        throw UnresolvedValidationException(
          'The validationSteps should not contain any contentValidation.',
          failedValidationStep: parsedVStep,
        );
      }
    }
  }

  /// Replaces the validationSteps names that were omitted by the default ones :
  ///
  /// | Step | Default name | Example          |
  /// | ---- | ------------ | ---------------- |
  /// | 1    | Value1       | InvalidAgeValue1 |
  /// | 2    | Value2       | InvalidAgeValue2 |
  /// | 3    | Value3       | InvalidAgeValue3 |
  /// | ...  | ...          | ...              |
  ///
  /// If there's only one validationStep, then its default name is 'Value'
  /// (instead of 'Value1').
  ///
  static List<ParsedValidationStep> _resolveNames(
      List<ParsedValidationStep> parsedVSteps) {
    return _withIndexedNameIfNonExistant(parsedVSteps, 'Value');
  }

  /// Creates the [ValidationStepInfo]s and the [validParametersTemplate] of a
  /// ValueObject.
  ///
  /// ## How it works :
  ///
  /// 1. We start with the [memberParametersTemplate], which is used as the
  ///    parameters template of the first parsed validationStep.
  /// 2. We use the [ModddelVStepTransformationsComputer] to compute the
  ///    transformations of the validationStep.
  /// 3. We pass the computed transformations to a [ValidationStepInfoResolver]
  ///    in order to create the [ValidationStepInfo] of the validationStep and
  ///    the parameters template of the next validationStep.
  /// 4. => We repeat steps 1-3 for the next validationSteps, each time starting
  ///    with the newly created parameters template. The final parameters
  ///    template we obtain corresponds to the [validParametersTemplate].
  ///
  static _ValueObjectValidationInfo _resolveInfo(
    List<ParsedValidationStep> parsedVSteps, {
    required ParametersTemplate memberParametersTemplate,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
  }) {
    var nextParameterTemplate = memberParametersTemplate;

    ValidationStepInfo resolveVStep(ParsedValidationStep parsedVStep) {
      final computer = ModddelVStepTransformationsComputer.compute(
        vStepParametersTemplate: nextParameterTemplate,
        parsedVStep: parsedVStep,
      );

      final validationResolver = ValidationStepInfoResolver.resolve(
        vStepParametersTemplate: nextParameterTemplate,
        vStepTransformations: computer.vStepTransformations,
        parsedVStep: parsedVStep,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
      );

      nextParameterTemplate = validationResolver.nextParametersTemplate;

      return validationResolver.validationStepInfo;
    }

    // NB : Using `.toList` removes the side effects risks of a lazy iterable
    // (See https://stackoverflow.com/a/44302727/13297133).
    final resolvedVSteps = parsedVSteps.map(resolveVStep).toList();

    return _ValueObjectValidationInfo(
      allValidationSteps: resolvedVSteps,
      validParametersTemplate: nextParameterTemplate,
    );
  }
}

/* -------------------------------- Entities -------------------------------- */

/// The [ModddelValidationInfoResolver] for an Entity.
///
class EntityValidationInfoResolver extends ModddelValidationInfoResolver {
  EntityValidationInfoResolver._({
    required this.earlyValidationSteps,
    required this.contentValidationStep,
    required this.lateValidationSteps,
    required this.validParametersTemplate,
  });

  /// Creates the [ValidationStepInfo]s and the [validParametersTemplate] of an
  /// Entity. The [ValidationStepInfo]s are split into [earlyValidationSteps],
  /// the [contentValidationStep] and [lateValidationSteps].
  ///
  /// Before doing so, ensures that the parsed validationSteps are valid as to
  /// their :
  ///
  /// 1. Number : There should be at least one validationStep.
  /// 2. Validations :
  ///     - The "failureTypes" should be provided (i.e be non-dynamic) and be
  ///       non-nullable.
  ///     - There should be exactly one contentValidation.
  /// 3. Names :
  ///    - The validationSteps names that were omitted are replaced by default
  ///      ones.
  ///    - The names of the validationSteps should be valid (See
  ///      [ValidationStepInfo.nameRegex]) and unique.
  ///    - The names of the validations should be valid (See
  ///      [ValidationInfo.validationNameRegex]) and unique.
  ///    - The names of the validations shouldn't conflict with the parameters
  ///      names as to the reserved names.
  /// 4. References :
  ///    - The '@NullFailure' annotations should reference existing validations.
  ///    - The '@NullFailure' annotations shouldn't reference the
  ///      contentValidation.
  ///
  /// Throws an [UnresolvedValidationException] if the validationSteps are not
  /// all valid.
  ///
  factory EntityValidationInfoResolver.resolve({
    required List<ParsedValidationStep> parsedVSteps,
    required ModddelParametersInfo modddelParametersInfo,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    // 1.
    _assertNotEmpty(parsedVSteps);

    // 2.
    _assertValidFailureTypes(parsedVSteps);

    final splitParsedVSteps = _splitValidationSteps(parsedVSteps);

    // 3.
    final splitParsedVStepsWithNames = _resolveNames(splitParsedVSteps);

    _assertValidNames(splitParsedVStepsWithNames.allValidationSteps);

    // 4.
    _assertValidNullFailureReferences(
      memberParametersTemplate: modddelParametersInfo.memberParametersTemplate,
      parsedVSteps: splitParsedVStepsWithNames.allValidationSteps,
    );
    // ---

    final resolvedInfo = _resolveInfo(
      splitParsedVStepsWithNames,
      memberParametersTemplate: modddelParametersInfo.memberParametersTemplate,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    // (3) continued
    _assertNoConflictingNames(
      allValidationSteps: [
        ...resolvedInfo.earlyValidationSteps,
        resolvedInfo.contentValidationStep,
        ...resolvedInfo.lateValidationSteps,
      ],
      constructorParametersTemplate:
          modddelParametersInfo.constructorParametersTemplate,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
    );

    return EntityValidationInfoResolver._(
      earlyValidationSteps: resolvedInfo.earlyValidationSteps,
      contentValidationStep: resolvedInfo.contentValidationStep,
      lateValidationSteps: resolvedInfo.lateValidationSteps,
      validParametersTemplate: resolvedInfo.validParametersTemplate,
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

  /// Asserts that the [parsedVSteps] contain exactly one contentValidation.
  ///
  /// Then, splits the [parsedVSteps] into early, content and late
  /// validationSteps :
  /// - The content validationStep is the validationStep that contains the
  ///   contentValidation.
  /// - The early validationSteps are the validationSteps that come **before**
  ///   the content validationStep.
  /// - The late validationSteps are the validationSteps that come **after** the
  ///   content validationStep.
  ///
  static _EntityParsedValidationSteps _splitValidationSteps(
      List<ParsedValidationStep> parsedVSteps) {
    final contentParsedVStep = parsedVSteps.singleWhereOrNull((parsedVStep) {
      final contentValidation = parsedVStep.parsedValidations.singleWhereOrNull(
          (parsedValidation) => parsedValidation.isContentValidation);
      return contentValidation != null;
    });

    if (contentParsedVStep == null) {
      throw UnresolvedValidationException(
          'The validationSteps should contain exactly one contentValidation.');
    }

    final contentVStepIndex = parsedVSteps.indexOf(contentParsedVStep);

    final earlyParsedVSteps = <ParsedValidationStep>[];

    final lateParsedVSteps = <ParsedValidationStep>[];

    for (var i = 0; i < parsedVSteps.length; i++) {
      final parsedVStep = parsedVSteps[i];
      if (i < contentVStepIndex) {
        earlyParsedVSteps.add(parsedVStep);
        continue;
      }
      if (i > contentVStepIndex) {
        lateParsedVSteps.add(parsedVStep);
      }
    }

    return _EntityParsedValidationSteps(
        earlyParsedVSteps: earlyParsedVSteps,
        contentParsedVStep: contentParsedVStep,
        lateParsedVSteps: lateParsedVSteps);
  }

  /// Replaces the validationSteps names that were omitted by the default ones :
  ///
  /// - For early validationSteps :
  ///
  ///     |      | Default name | Example             |
  ///     | ---- | ------------ | ------------------- |
  ///     | 1    | Early1       | InvalidPersonEarly1 |
  ///     | 2    | Early2       | InvalidPersonEarly2 |
  ///     | ...  | ...          | ...                 |
  ///
  ///     If there's only one early validationStep, then its default name is
  ///     'Early' (instead of 'Early1').
  ///
  /// - For the content validationStep :
  ///
  ///     | Default name | Example          |
  ///     | ------------ | ---------------- |
  ///     | Mid          | InvalidPersonMid |
  ///
  /// - For late validationSteps :
  ///
  ///     | Step | Default name | Example            |
  ///     | ---- | ------------ | ------------------ |
  ///     | 1    | Late1        | InvalidPersonLate1 |
  ///     | 2    | Late2        | InvalidPersonLate2 |
  ///     | ...  | ...          | ...                |
  ///
  ///     If there's only one late validationStep, then its default name is
  ///     'Late' (instead of 'Late1').
  ///
  static _EntityParsedValidationSteps _resolveNames(
      _EntityParsedValidationSteps splitParsedVSteps) {
    final resolvedEarlyParsedVSteps = _withIndexedNameIfNonExistant(
        splitParsedVSteps.earlyParsedVSteps, 'Early');

    final resolvedLateParsedVSteps = _withIndexedNameIfNonExistant(
        splitParsedVSteps.lateParsedVSteps, 'Late');

    final resolvedContentParsedVStep =
        splitParsedVSteps.contentParsedVStep.withNameIfNonExistant(name: 'Mid');

    return _EntityParsedValidationSteps(
      earlyParsedVSteps: resolvedEarlyParsedVSteps,
      contentParsedVStep: resolvedContentParsedVStep,
      lateParsedVSteps: resolvedLateParsedVSteps,
    );
  }

  /// Creates the [ValidationStepInfo]s and the [validParametersTemplate] of an
  /// Entity.
  ///
  /// ## How it works :
  ///
  /// 1. We start with the [memberParametersTemplate], which is used as the
  ///    parameters template of the first validationStep.
  /// 2. We use the [ModddelVStepTransformationsComputer] to compute the
  ///    transformations of the validationStep.
  /// 3. We use the [ValidationStepInfoResolver] to create the
  ///    [ValidationStepInfo] of the validationStep, and the parameters template
  ///    of the next validationStep.
  /// 4. => We repeat steps 1-3 for the next validationSteps. The final
  ///    parameters template we obtain corresponds to the
  ///    [validParametersTemplate].
  ///
  /// Note that the [splitParsedVSteps] are already split into early, content
  /// and late validationSteps, so we keep them separated throughout the
  /// process.
  ///
  static _EntityValidationInfo _resolveInfo(
    _EntityParsedValidationSteps splitParsedVSteps, {
    required ParametersTemplate memberParametersTemplate,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
  }) {
    var nextParameterTemplate = memberParametersTemplate;

    ValidationStepInfo resolveVStep(ParsedValidationStep parsedVStep) {
      final computer = ModddelVStepTransformationsComputer.compute(
        vStepParametersTemplate: nextParameterTemplate,
        parsedVStep: parsedVStep,
      );

      final validationResolver = ValidationStepInfoResolver.resolve(
        vStepParametersTemplate: nextParameterTemplate,
        parsedVStep: parsedVStep,
        vStepTransformations: computer.vStepTransformations,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
      );

      nextParameterTemplate = validationResolver.nextParametersTemplate;

      return validationResolver.validationStepInfo;
    }

    // These should stay in this exact order.
    //
    // NB : Using `.toList` removes the side effects risks of a lazy iterable
    // (See https://stackoverflow.com/a/44302727/13297133)
    final resolvedEarlyVSteps =
        splitParsedVSteps.earlyParsedVSteps.map(resolveVStep).toList();

    final resolvedContentVStep =
        resolveVStep(splitParsedVSteps.contentParsedVStep);

    final resolvedLateVSteps =
        splitParsedVSteps.lateParsedVSteps.map(resolveVStep).toList();

    return _EntityValidationInfo(
      earlyValidationSteps: resolvedEarlyVSteps,
      contentValidationStep: resolvedContentVStep,
      lateValidationSteps: resolvedLateVSteps,
      validParametersTemplate: nextParameterTemplate,
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

/// Holds the resolved validation info of a ValueObject.
///
class _ValueObjectValidationInfo {
  const _ValueObjectValidationInfo({
    required this.allValidationSteps,
    required this.validParametersTemplate,
  });

  /// See [ValueObjectValidationInfoResolver.allValidationSteps].
  ///
  final List<ValidationStepInfo> allValidationSteps;

  /// See [ValueObjectValidationInfoResolver.validParametersTemplate].
  ///
  final ParametersTemplate validParametersTemplate;
}

/// Holds the [ParsedValidationStep]s of an Entity that are split into
/// [earlyParsedVSteps], the [contentParsedVStep] and
/// [lateParsedVSteps].
///
class _EntityParsedValidationSteps {
  const _EntityParsedValidationSteps({
    required this.earlyParsedVSteps,
    required this.contentParsedVStep,
    required this.lateParsedVSteps,
  });

  final List<ParsedValidationStep> earlyParsedVSteps;
  final ParsedValidationStep contentParsedVStep;
  final List<ParsedValidationStep> lateParsedVSteps;

  List<ParsedValidationStep> get allValidationSteps => [
        ...earlyParsedVSteps,
        contentParsedVStep,
        ...lateParsedVSteps,
      ];
}

/// Holds the resolved validation info of an Entity.
///
class _EntityValidationInfo {
  const _EntityValidationInfo({
    required this.earlyValidationSteps,
    required this.contentValidationStep,
    required this.lateValidationSteps,
    required this.validParametersTemplate,
  });

  /// See [EntityValidationInfoResolver.earlyValidationSteps].
  ///
  final List<ValidationStepInfo> earlyValidationSteps;

  /// See [EntityValidationInfoResolver.contentValidationStep].
  ///
  final ValidationStepInfo contentValidationStep;

  /// See [EntityValidationInfoResolver.lateValidationSteps].
  ///
  final List<ValidationStepInfo> lateValidationSteps;

  /// See [EntityValidationInfoResolver.validParametersTemplate].
  ///
  final ParametersTemplate validParametersTemplate;
}

/// Returns a copy of the [parsedVSteps] where the name of each parsed
/// validationStep, when omitted (i.e when it's null), is replaced with the
/// specified [name] to which the 1-based index is appended.
///
/// Example : 'Early1', 'Early2' ...
///
/// If the [parsedVSteps] contains a single parsed validationStep, then the
/// index is not added.
///
/// Example : 'Early'
///
List<ParsedValidationStep> _withIndexedNameIfNonExistant(
    List<ParsedValidationStep> parsedVSteps, String name) {
  if (parsedVSteps.length == 1) {
    return [parsedVSteps.single.withNameIfNonExistant(name: name)];
  }

  return parsedVSteps
      .mapIndexed((index, element) =>
          element.withNameIfNonExistant(name: '$name${index + 1}'))
      .toList();
}

void _assertNotEmpty(List<ParsedValidationStep> parsedVSteps) {
  if (parsedVSteps.isEmpty) {
    throw UnresolvedValidationException(
        'The validationSteps list can not be empty.');
  }
  for (final parsedVStep in parsedVSteps) {
    if (parsedVStep.parsedValidations.isEmpty) {
      throw UnresolvedValidationException(
        'The validations list can not be empty.',
        failedValidationStep: parsedVStep,
      );
    }
  }
}

void _assertValidFailureTypes(List<ParsedValidationStep> parsedVSteps) {
  final allParsedValidations = parsedVSteps
      .map((parsedVStep) => parsedVStep.parsedValidations)
      .expand(id)
      .toList();

  for (final parsedValidation in allParsedValidations) {
    final failureType = parsedValidation.failureType;

    if (GlobalIdentifiers.failuresBaseIdentifiers.failureBaseClassName ==
            failureType ||
        isDynamicType(failureType) ||
        failureType.isEmpty) {
      throw UnresolvedValidationException(
        'The failure type must be provided and must not be dynamic. Consider '
        'providing it as a type argument : FailureType<_yourtype_>, or providing '
        'the type as a string : FailureType(\'_yourtype_\').',
        failedValidation: parsedValidation,
      );
    }

    verifyNotBaseClass(String baseClassName) {
      if (failureType == baseClassName) {
        throw UnresolvedValidationException(
          'The failure type can\'t be equal to the base class "$baseClassName". '
          'Create your own failure class that extends the appropriate base class.',
          failedValidation: parsedValidation,
        );
      }
    }

    verifyNotBaseClass(
        GlobalIdentifiers.failuresBaseIdentifiers.valueFailureBaseClassName);

    verifyNotBaseClass(
        GlobalIdentifiers.failuresBaseIdentifiers.entityFailureBaseClassName);

    if (nullableType(failureType) == failureType) {
      throw UnresolvedValidationException(
        'The failure type must not be nullable.',
        failedValidation: parsedValidation,
      );
    }
  }
}

void _assertValidNames(List<ParsedValidationStep> parsedVSteps) {
  // A. The validationSteps names
  for (final parsedVStep in parsedVSteps) {
    final validationStepName = parsedVStep.name;

    if (validationStepName == null) {
      throw ArgumentError(
          'The "null" validationStep names should all have been replaced by '
              'default names.',
          'parsedVSteps');
    }

    if (!ValidationStepInfo.nameRegex.hasMatch(validationStepName)) {
      throw UnresolvedValidationException(
        'The validationStep name must start with an uppercase letter and '
        'can only contain valid dart identifier characters (alphanumeric, '
        'underscore and dollar sign).',
        failedValidationStep: parsedVStep,
      );
    }

    final isNameUnique = parsedVSteps.singleWhereOrNull(
            (parsedVStep) => parsedVStep.name == validationStepName) !=
        null;

    if (!isNameUnique) {
      throw UnresolvedValidationException(
        'The validationStep name must be unique.',
        failedValidationStep: parsedVStep,
      );
    }
  }

  // B. The validations names
  final parsedValidations = parsedVSteps
      .map((parsedVStep) => parsedVStep.parsedValidations)
      .expand(id)
      .toList();

  for (final parsedValidation in parsedValidations) {
    final validationName = parsedValidation.validationName;

    if (!ValidationInfo.validationNameRegex.hasMatch(validationName)) {
      throw UnresolvedValidationException(
        'The validation name must start with a lowercase letter and can only '
        'contain valid dart identifier characters (alphanumeric, underscore '
        'and dollar sign).',
        failedValidation: parsedValidation,
      );
    }

    final isNameUnique = parsedValidations.singleWhereOrNull(
            (validation) => validation.validationName == validationName) !=
        null;

    if (!isNameUnique) {
      throw UnresolvedValidationException(
        'The validation name must be unique.',
        failedValidation: parsedValidation,
      );
    }
  }
}

void _assertValidNullFailureReferences({
  required List<ParsedValidationStep> parsedVSteps,
  required ParametersTemplate memberParametersTemplate,
}) {
  final allNullFailureParams = memberParametersTemplate.allParameters
      .where((param) => param.hasNullFailureAnnotation)
      .toList();

  final parsedValidations = parsedVSteps
      .map((parsedVStep) => parsedVStep.parsedValidations)
      .expand(id)
      .toList();

  for (final param in allNullFailureParams) {
    for (final nullFailure in param.nullFailures) {
      final referencedValidation = parsedValidations.singleWhereOrNull(
          (v) => v.validationName == nullFailure.validationName);

      if (referencedValidation == null) {
        throw InvalidGenerationSourceError(
          'The NullFailure annotation should refer to an existing validation.',
          element: param.parameterElement,
        );
      }
      if (referencedValidation.isContentValidation) {
        throw InvalidGenerationSourceError(
          'The NullFailure annotation can\'t refer to the content validation.',
          element: param.parameterElement,
        );
      }
    }
  }
}

void _assertNoConflictingNames({
  required List<ValidationStepInfo> allValidationSteps,
  required ParametersTemplate constructorParametersTemplate,
  required GeneralIdentifiers generalIdentifiers,
  required ModddelClassIdentifiers modddelClassIdentifiers,
  required SSealedClassIdentifiers? sSealedClassIdentifiers,
}) {
  // A. The validationSteps names
  for (final validationStep in allValidationSteps) {
    final conflictingIdentifiers = <String>{
      // NB : No possible conflicts with GlobalIdentifiers
      generalIdentifiers.testerIdentifiers
          .getIsInvalidGetterName(validationStep),
      generalIdentifiers.getInvalidStepCallbackParamName(validationStep),
      generalIdentifiers.getFailuresCallbackParamName(validationStep),
      modddelClassIdentifiers.getInvalidStepVariableName(validationStep),
      modddelClassIdentifiers.getHolderVariableName(validationStep),
      modddelClassIdentifiers.getVerifyMethodName(validationStep),

      if (sSealedClassIdentifiers != null) ...{
        sSealedClassIdentifiers.getInvalidStepVariableName(validationStep),
      }
    };

    for (final parameter in constructorParametersTemplate.allParameters) {
      if (conflictingIdentifiers.contains(parameter.name)) {
        throw UnresolvedValidationException(
          'The parameter name "${parameter.name}" conflicts with the validationStep '
          'name "${validationStep.name}". Try to either change the parameter '
          'name or the validationStep name.',
        );
      }
    }
  }

  // B. The validations names
  final allValidations = allValidationSteps
      .map((validationStep) => validationStep.validations)
      .expand(id)
      .toList();

  for (final validation in allValidations) {
    final conflictingIdentifiers = <String>{
      // NB : No possible conflicts with GlobalIdentifiers
      if (!validation.isContentValidation)
        generalIdentifiers.topLevelMixinIdentifiers
            .getValidateMethodName(validation),
      generalIdentifiers.holderIdentifiers
          .getVerifyNullablesMethodName(validation),
      generalIdentifiers.holderIdentifiers.getToSubHolderMethodName(validation),
      generalIdentifiers.getFailureVariableName(validation),
      generalIdentifiers.getHasFailureGetterName(validation),
      if (validation.isContentValidation)
        modddelClassIdentifiers.getValidateContentMethodName(validation),
      // NB : No possible conflicts with SSealedClassIdentifiers
    };

    for (final parameter in constructorParametersTemplate.allParameters) {
      if (conflictingIdentifiers.contains(parameter.name)) {
        throw UnresolvedValidationException(
          'The parameter name "${parameter.name}" conflicts with the validation '
          'name "${validation.validationName}". Try to either change the '
          'parameter name or the validation name.',
        );
      }
    }
  }
}
