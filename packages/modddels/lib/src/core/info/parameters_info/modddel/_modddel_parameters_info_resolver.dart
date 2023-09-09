import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/_unresolved_parameters_info_exception.dart';
import 'package:modddels/src/core/info/parameters_info/_parameter_kind.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:collection/collection.dart';
import 'package:modddels/src/core/utils.dart';

/// This is a resolver that splits the [ParametersTemplate] of a modddel's
/// factory constructor into dependency parameters and member parameters, and
/// ensures that all parameters are valid as to their number, names, annotations
/// and types.
///
abstract class ModddelParametersInfoResolver {
  /// Contains the dependency parameters.
  ///
  ParametersTemplate get dependencyParametersTemplate;

  /// Contains the member parameters.
  ///
  ParametersTemplate get memberParametersTemplate;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

/// The [ModddelParametersInfoResolver] for a SingleValueObject.
///
class SingleValueObjectParametersResolver
    extends ModddelParametersInfoResolver {
  SingleValueObjectParametersResolver._({
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
    required this.valueParameter,
  });

  /// A. Ensures the parameters are not private and have names that don't
  /// conflict with reserved names.
  ///
  /// B. Splits the [ParametersTemplate] of a SingleValueObject's factory
  /// constructor into dependency parameters and member parameters, the latter
  /// being a single member parameter [valueParameter].
  ///
  /// C. Also ensures that the parameters are valid as to their :
  ///
  /// 1. Number : There should be a single member parameter which is the
  ///    [valueParameter].
  /// 2. Annotations :
  ///    - The parameters can't have a 'validParam' or 'invalidParam'
  ///      annotation.
  ///    - The 'NullFailure' annotation should be used correctly.
  ///
  /// Throws an [UnresolvedParametersInfoException] if the parameters are not
  /// all valid.
  ///
  factory SingleValueObjectParametersResolver.resolve({
    required ParametersTemplate constructorParametersTemplate,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    // A.
    _assertNotPrivate(
        constructorParametersTemplate: constructorParametersTemplate);

    _assertNoConflictingNames(
      constructorParametersTemplate: constructorParametersTemplate,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
    );

    // B.
    final split = _splitParametersTemplate(constructorParametersTemplate);

    final dependencyParametersTemplate = split.dependencyParametersTemplate;
    final memberParametersTemplate = split.memberParametersTemplate;

    // C.
    // 1.
    _assertIsUniqueMember(memberParametersTemplate: memberParametersTemplate);

    final valueParameter = memberParametersTemplate.allParameters.single;

    // 2.
    _assertHasNoSimpleEntityAnnotation(
        memberParametersTemplate: memberParametersTemplate);

    _assertValidNullFailure(
      memberParametersTemplate: memberParametersTemplate,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    return SingleValueObjectParametersResolver._(
      dependencyParametersTemplate: dependencyParametersTemplate,
      memberParametersTemplate: memberParametersTemplate,
      valueParameter: valueParameter,
    );
  }

  @override
  final ParametersTemplate dependencyParametersTemplate;

  /// Contains a single member parameter : the [valueParameter].
  ///
  @override
  final ParametersTemplate memberParametersTemplate;

  /// The single member parameter of the SingleValueObject.
  ///
  final Parameter valueParameter;
}

/// The [ModddelParametersInfoResolver] for a MultiValueObject.
///
class MultiValueObjectParametersResolver extends ModddelParametersInfoResolver {
  MultiValueObjectParametersResolver._({
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
  });

  /// A. Ensures the parameters are not private and have names that don't
  /// conflict with reserved names.
  ///
  /// B. Splits the [ParametersTemplate] of a MultiValueObject's factory
  /// constructor into dependency parameters and member parameters.
  ///
  /// C. Also ensures that the parameters are valid as to their :
  ///
  /// 1. Number : There should be at least one member parameter.
  /// 2. Annotations :
  ///    - The parameters can't have a 'validParam' or 'invalidParam'
  ///      annotation.
  ///    - The 'NullFailure' annotation should be used correctly.
  ///
  /// Throws an [UnresolvedParametersInfoException] if the parameters are not
  /// all valid.
  ///
  factory MultiValueObjectParametersResolver.resolve({
    required ParametersTemplate constructorParametersTemplate,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    // A.
    _assertNotPrivate(
        constructorParametersTemplate: constructorParametersTemplate);

    _assertNoConflictingNames(
      constructorParametersTemplate: constructorParametersTemplate,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
    );

    // B.
    final split = _splitParametersTemplate(constructorParametersTemplate);

    final dependencyParametersTemplate = split.dependencyParametersTemplate;
    final memberParametersTemplate = split.memberParametersTemplate;

    // C.
    // 1.
    _assertNotEmpty(memberParametersTemplate: memberParametersTemplate);

    // 2.
    _assertHasNoSimpleEntityAnnotation(
        memberParametersTemplate: memberParametersTemplate);

    _assertValidNullFailure(
      memberParametersTemplate: memberParametersTemplate,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    return MultiValueObjectParametersResolver._(
      dependencyParametersTemplate: dependencyParametersTemplate,
      memberParametersTemplate: memberParametersTemplate,
    );
  }

  @override
  final ParametersTemplate dependencyParametersTemplate;

  @override
  final ParametersTemplate memberParametersTemplate;
}

/* -------------------------------- Entities -------------------------------- */

/// The [ModddelParametersInfoResolver] for a SimpleEntity.
///
class SimpleEntityParametersResolver extends ModddelParametersInfoResolver {
  SimpleEntityParametersResolver._({
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
  });

  /// A. Ensures the parameters are not private and have names that don't
  /// conflict with reserved names.
  ///
  /// B. Splits the [ParametersTemplate] of a SimpleEntity's factory constructor
  /// into dependency parameters and member parameters.
  ///
  /// C. Also ensures that the parameters are valid as to their :
  ///
  /// 1. Number : There should be at least one member parameter.
  /// 2. Annotations :
  ///    - The 'validParam' and 'invalidParam' annotations should be used
  ///      correctly.
  ///    - The 'NullFailure' annotation should be used correctly.
  /// 3. Types : Member parameters that will have their types transformed to
  ///    their "valid" versions shouldn't have a 'dynamic' type.
  ///
  /// Throws an [UnresolvedParametersInfoException] if the parameters are not
  /// all valid.
  ///
  factory SimpleEntityParametersResolver.resolve({
    required ParametersTemplate constructorParametersTemplate,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    // A.
    _assertNotPrivate(
        constructorParametersTemplate: constructorParametersTemplate);

    _assertNoConflictingNames(
      constructorParametersTemplate: constructorParametersTemplate,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
    );

    // B.
    final split = _splitParametersTemplate(constructorParametersTemplate);

    final dependencyParametersTemplate = split.dependencyParametersTemplate;
    final memberParametersTemplate = split.memberParametersTemplate;

    // C.
    // 1.
    _assertNotEmpty(memberParametersTemplate: memberParametersTemplate);

    // 2.
    _assertValidSimpleEntityAnnotations(
        memberParametersTemplate: memberParametersTemplate);

    _assertValidNullFailure(
      memberParametersTemplate: memberParametersTemplate,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    // 3.
    _assertValidTypes(memberParametersTemplate: memberParametersTemplate);

    return SimpleEntityParametersResolver._(
      dependencyParametersTemplate: dependencyParametersTemplate,
      memberParametersTemplate: memberParametersTemplate,
    );
  }

  @override
  final ParametersTemplate dependencyParametersTemplate;

  @override
  final ParametersTemplate memberParametersTemplate;

  /// Asserts that the parameters that will have their types transformed to
  /// their "valid" versions (i.e that will have 'Valid' prepended to their
  /// types) don't have a 'dynamic' type.
  ///
  /// These parameters are all member parameters that are not annotated with
  /// '@validParam' or '@invalidParam'.
  ///
  static void _assertValidTypes({
    required ParametersTemplate memberParametersTemplate,
  }) {
    for (final param in memberParametersTemplate.allParameters) {
      if (!param.hasValidAnnotation &&
          !param.hasInvalidAnnotation &&
          isDynamicType(param.type)) {
        throw UnresolvedParametersInfoException(
          'Member parameters of a SimpleEntity can\'t have a dynamic type. The '
          'only exception are member parameters annotated with @validParam, '
          '@validWithGetter, @invalidParam or @invalidWithGetter.',
          failedParameter: param,
        );
      }
    }
  }
}

/// The [ModddelParametersInfoResolver] for an IterableEntity or
/// Iterable2Entity.
///
class IterablesEntityParametersResolver extends ModddelParametersInfoResolver {
  IterablesEntityParametersResolver._({
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
    required this.iterableParameter,
  });

  /// A. Ensures the parameters are not private and have names that don't
  /// conflict with reserved names.
  ///
  /// B. Splits the [ParametersTemplate] of an IterableEntity/Iterable2Entity
  /// factory constructor into dependency parameters and member parameters, the
  /// latter being a single member parameter [iterableParameter].
  ///
  /// C. Also ensures that the parameters are valid as to their :
  ///
  /// 1. Number : There should be a single member parameter which is the
  ///    [iterableParameter].
  /// 2. Types : The type of the [iterableParameter] shouldn't be 'dynamic' or
  ///    nullable, and the modddel type(s) shouldn't be 'dynamic'.
  /// 3. Annotations :
  ///    - The parameters can't have a 'validParam' or 'invalidParam'
  ///      annotation.
  ///    - The 'NullFailure' annotation should be used correctly.
  ///
  /// Throws an [UnresolvedParametersInfoException] if the parameters are not
  /// all valid.
  ///
  factory IterablesEntityParametersResolver.resolve({
    required ParametersTemplate constructorParametersTemplate,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    // A.
    _assertNotPrivate(
        constructorParametersTemplate: constructorParametersTemplate);

    _assertNoConflictingNames(
      constructorParametersTemplate: constructorParametersTemplate,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
    );

    // B.
    final split = _splitParametersTemplate(constructorParametersTemplate);

    final dependencyParametersTemplate = split.dependencyParametersTemplate;
    final memberParametersTemplate = split.memberParametersTemplate;

    // C.
    // 1.
    _assertIsUniqueMember(memberParametersTemplate: memberParametersTemplate);

    final iterableParameter = memberParametersTemplate.allParameters.single;

    // 2.
    // NB : This must come before `_assertValidNullFailure` where the
    // parameterTypeInfo used.
    _assertValidIterableParameterType(
        iterableParameter, parameterTypeInfoMaker);

    // 3.
    _assertHasNoSimpleEntityAnnotation(
        memberParametersTemplate: memberParametersTemplate);

    _assertValidNullFailure(
      memberParametersTemplate: memberParametersTemplate,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    return IterablesEntityParametersResolver._(
      dependencyParametersTemplate: dependencyParametersTemplate,
      memberParametersTemplate: memberParametersTemplate,
      iterableParameter: iterableParameter,
    );
  }

  @override
  final ParametersTemplate dependencyParametersTemplate;

  /// Contains a single member parameter : the [iterableParameter].
  ///
  @override
  final ParametersTemplate memberParametersTemplate;

  /// The single member parameter of the IterableEntity/Iterable2Entity.
  ///
  final Parameter iterableParameter;

  /// Asserts that :
  ///
  /// 1. The type of the [iterableParameter] isn't 'dynamic' nor
  /// 'nullable'.
  /// 2. The modddel type(s) aren't 'dynamic'.
  ///
  static void _assertValidIterableParameterType(Parameter iterableParameter,
      ParameterTypeInfoMaker parameterTypeInfoMaker) {
    // 1.

    // This check comes before the 'isNullable' check, because a dynamic type
    // is nullable.
    if (isDynamicType(iterableParameter.type)) {
      throw UnresolvedParametersInfoException(
        'The iterable parameter can\'t be dynamic.',
        failedParameter: iterableParameter,
      );
    }

    if (isNullableType(iterableParameter.type)) {
      throw UnresolvedParametersInfoException(
        'The iterable parameter can\'t be nullable.',
        failedParameter: iterableParameter,
      );
    }

    // 2.
    // NB : This throws an [InvalidGenerationSourceError] if the
    // iterableParameter doesn't match the TypeTemplate.
    final typeInfo = parameterTypeInfoMaker(iterableParameter);

    assertValidModddelType(String modddelType) {
      if (isDynamicType(modddelType)) {
        throw UnresolvedParametersInfoException(
          'The modddel type can\'t be dynamic.',
          failedParameter: iterableParameter,
        );
      }
    }

    typeInfo.maybeMap(
        iterable: (iterable) {
          assertValidModddelType(iterable.modddelType);
        },
        iterable2: (iterable2) {
          assertValidModddelType(iterable2.modddel1Type);
          assertValidModddelType(iterable2.modddel2Type);
        },
        orElse: () => throw UnsupportedError(
            'IterablesEntityParametersResolver should only be used with '
            'IterableEntity/Iterable2Entity.'));
  }
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

void _assertNotPrivate({
  required ParametersTemplate constructorParametersTemplate,
}) {
  for (final parameter in constructorParametersTemplate.allParameters) {
    if (parameter.name.startsWith('_')) {
      throw UnresolvedParametersInfoException(
        'The parameters of a factory constructor can\'t be private.',
        failedParameter: parameter,
      );
    }
  }
}

void _assertNoConflictingNames({
  required ParametersTemplate constructorParametersTemplate,
  required GeneralIdentifiers generalIdentifiers,
  required ModddelClassIdentifiers modddelClassIdentifiers,
  required SSealedClassIdentifiers? sSealedClassIdentifiers,
}) {
  // All identifiers that could potentially conflict with the parameters names.
  final conflictingIdentifiers = <String>{
    GlobalIdentifiers.copyWithIdentifiers.copyWithDefaultConstName,
    GlobalIdentifiers.iterablesIdentifiers.collectionToIterableMethodName,
    GlobalIdentifiers.iterablesIdentifiers.castCollectionMethodName,
    GlobalIdentifiers.iterablesIdentifiers.primeCollectionMethodName,
    GlobalIdentifiers.iterablesIdentifiers.validateIterableContentMethodName,
    GlobalIdentifiers.invalidModddelBaseIdentifiers.failuresGetterName,
    GlobalIdentifiers.baseModddelIdentifiers.isValidGetterName,
    GlobalIdentifiers.baseModddelIdentifiers.toEitherGetterName,
    GlobalIdentifiers.baseModddelIdentifiers.toBroadEitherGetterName,
    GlobalIdentifiers.modddelParamsBaseIdentifiers.sanitizedParamsGetterName,
    GlobalIdentifiers.modddelParamsBaseIdentifiers.toModddelMethodName,
    GlobalIdentifiers.modddelParamsBaseIdentifiers.modddelLocalVarName,
    GlobalIdentifiers.modddelParamsBaseIdentifiers.classNameParameter.name,
    GlobalIdentifiers.modddelParamsBaseIdentifiers.modddelKindParameter.name,
    // NB : No possible conflicts with invalidStepTestBaseIdentifiers or
    // baseTesterIdentifiers
    GlobalIdentifiers.failuresBaseIdentifiers.contentFailureLocalVarName,
    // NB : No possible conflict with
    // failuresBaseIdentifiers.cfInvalidMembersPropName / mimMemberParameter /
    // mimDescriptionParameter
    GlobalIdentifiers.unimplementedErrorVarName,
    GlobalIdentifiers.validCallbackParamName,
    GlobalIdentifiers.invalidCallbackParamName,
    GlobalIdentifiers.orElseCallbackParamName,
    GlobalIdentifiers.propsGetterName,
    generalIdentifiers.topLevelMixinIdentifiers.initMethodName,
    generalIdentifiers.topLevelMixinIdentifiers.instanceMethodName,
    generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName,
    // NB : No possible conflict with testerIdentifiers or
    // invalidStepTestClassIdentifiers
    generalIdentifiers.copyWithGetterName,
    // NB : No possible conflic with ClassIdentifiers.variableName (Only used
    // as a param of the validation method, in which we shouldn't access
    // instance members anyway).
    modddelClassIdentifiers.validVariableName,
    modddelClassIdentifiers.invalidVariableName,
    modddelClassIdentifiers.dependenciesVariableName,
    modddelClassIdentifiers.createMethodName,

    if (sSealedClassIdentifiers != null) ...{
      sSealedClassIdentifiers.validVariableName,
      sSealedClassIdentifiers.invalidVariableName,
    }
  };

  // All potentially conflicting identifiers related to a single [parameter]
  Set<String> getOtherConflictingIdentifiers(Parameter parameter) {
    return {
      GlobalIdentifiers.copyWithIdentifiers.getCopyWithLocalVarName(parameter),
      GlobalIdentifiers.validateContentMethodIdentifiers
          .getInvalidLocalVarName(parameter),
    };
  }

  final allConflictingNames = {
    ...conflictingIdentifiers,
    ...constructorParametersTemplate.allParameters
        .map(getOtherConflictingIdentifiers)
        .toSet(),
  };

  for (final parameter in constructorParametersTemplate.allParameters) {
    if (allConflictingNames.contains(parameter.name)) {
      throw UnresolvedParametersInfoException(
        'The parameter name "${parameter.name}" is reserved and should not be used.',
        failedParameter: parameter,
      );
    }
  }
}

void _assertNotEmpty({
  required ParametersTemplate memberParametersTemplate,
}) {
  if (memberParametersTemplate.allParameters.isEmpty) {
    throw UnresolvedParametersInfoException(
        'The factory constructor should contain at least one member parameter.');
  }
}

void _assertIsUniqueMember({
  required ParametersTemplate memberParametersTemplate,
}) {
  if (memberParametersTemplate.allParameters.length != 1) {
    throw UnresolvedParametersInfoException(
        'The factory constructor should contain a single member parameter.');
  }
}

void _assertHasNoSimpleEntityAnnotation({
  required ParametersTemplate memberParametersTemplate,
}) {
  for (final param in memberParametersTemplate.allParameters) {
    if (param.hasValidAnnotation) {
      throw UnresolvedParametersInfoException(
        'The @validParam and @validWithGetter annotations can only be used '
        'inside SimpleEntities.',
        failedParameter: param,
      );
    }

    if (param.hasInvalidAnnotation) {
      throw UnresolvedParametersInfoException(
        'The @invalidParam and @invalidWithGetter annotations can only be used '
        'inside SimpleEntities.',
        failedParameter: param,
      );
    }
  }
}

void _assertValidSimpleEntityAnnotations({
  required ParametersTemplate memberParametersTemplate,
}) {
  if (memberParametersTemplate.allParameters
      .every((param) => param.hasValidAnnotation)) {
    throw UnresolvedParametersInfoException(
      'A SimpleEntity can\'t have all its member parameters marked with '
      '@validParam or @validWithGetter.',
    );
  }

  for (final param in memberParametersTemplate.allParameters) {
    if (param.hasValidAnnotation && param.hasInvalidAnnotation) {
      throw UnresolvedParametersInfoException(
        'The @validParam (or @validWithGetter) annotation and the @invalidParam '
        '(or @invalidWithGetter) annotation can\'t be used together on the '
        'same member parameter.',
        failedParameter: param,
      );
    }
    if (param.hasInvalidAnnotation && !isNullableType(param.type)) {
      throw UnresolvedParametersInfoException(
        'The @invalidParam (or @invalidWithGetter) annotation can only be used '
        'on nullable member parameters.',
        failedParameter: param,
      );
    }
    if (param.hasInvalidAnnotation && isNullType(param.type)) {
      throw UnresolvedParametersInfoException(
        'The @invalidParam (or @invalidWithGetter) annotation can\'t be used on '
        'a Null member parameter, because it won\'t have any effect.',
        failedParameter: param,
      );
    }
    if (param.hasInvalidAnnotation && param.hasNullFailureAnnotation) {
      throw UnresolvedParametersInfoException(
        'The @invalidParam (or @invalidWithGetter) annotation and the @NullFailure '
        'annotation can\'t be used together on the same member parameter.',
        failedParameter: param,
      );
    }
  }
}

void _assertValidNullFailure({
  required ParametersTemplate memberParametersTemplate,
  required ParameterTypeInfoMaker parameterTypeInfoMaker,
}) {
  final allNullFailureParams = memberParametersTemplate.allParameters
      .where((param) => param.hasNullFailureAnnotation)
      .toList();

  UnresolvedParametersInfoException getCountError(
          int maxCount, Parameter param) =>
      UnresolvedParametersInfoException(
        'The parameter can be annotated with a maximum of $maxCount '
        '"@NullFailure" annotation(s).',
        failedParameter: param,
      );

  for (final nullFailureParameter in allNullFailureParams) {
    final typeInfo = parameterTypeInfoMaker(nullFailureParameter);

    typeInfo.map(
      normal: (normal) {
        final nullFailure = nullFailureParameter.nullFailures.singleOrNull;
        if (nullFailure == null) {
          throw getCountError(1, nullFailureParameter);
        }
        if (nullFailure.maskNb != null) {
          throw UnresolvedParametersInfoException(
            'The maskNb is reserved for Iterable2Entities, and should not be '
            'provided.',
            failedParameter: nullFailureParameter,
          );
        }

        if (!isNullableType(nullFailureParameter.type)) {
          throw UnresolvedParametersInfoException(
            'The @NullFailure annotation can only be used with nullable '
            'parameters.',
            failedParameter: nullFailureParameter,
          );
        }
      },
      iterable: (iterable) {
        final nullFailure = nullFailureParameter.nullFailures.singleOrNull;
        if (nullFailure == null) {
          throw getCountError(1, nullFailureParameter);
        }
        if (nullFailure.maskNb != null) {
          throw UnresolvedParametersInfoException(
            'The maskNb is not needed for IterableEntities, and should not be '
            'provided.',
            failedParameter: nullFailureParameter,
          );
        }
        if (!isNullableType(iterable.modddelType)) {
          throw UnresolvedParametersInfoException(
            'The @NullFailure annotation can only be used with nullable '
            'modddels, but the type of the modddel matching the mask (#1) '
            'is not nullable.',
            failedParameter: nullFailureParameter,
          );
        }
      },
      iterable2: (iterable2) {
        final nullFailures = [...nullFailureParameter.nullFailures];
        if (nullFailures.length > 2) {
          throw getCountError(2, nullFailureParameter);
        }
        if (nullFailures.any((e) => e.maskNb == null)) {
          throw UnresolvedParametersInfoException(
            'The maskNb of the @NullFailure annotation(s) should be provided.',
            failedParameter: nullFailureParameter,
          );
        }
        nullFailures.sort((a, b) => a.maskNb!.compareTo(b.maskNb!));

        if (nullFailures.distinctBy((e) => e.maskNb).length !=
            nullFailures.length) {
          throw UnresolvedParametersInfoException(
            'The @NullFailure annotations can\'t have the same maskNb.',
            failedParameter: nullFailureParameter,
          );
        }

        for (final element in nullFailures) {
          if (![1, 2].contains(element.maskNb)) {
            throw UnresolvedParametersInfoException(
              'The maskNb of the @NullFailure annotation(s) should be one of '
              '[1,2].',
              failedParameter: nullFailureParameter,
            );
          }
          final modddelType = element.maskNb == 1
              ? iterable2.modddel1Type
              : iterable2.modddel2Type;

          if (!isNullableType(modddelType)) {
            throw UnresolvedParametersInfoException(
              'The @NullFailure annotation can only be used with nullable '
              'modddels, but the type of the modddel matching the mask '
              '(#${element.maskNb}) is not nullable.',
              failedParameter: nullFailureParameter,
            );
          }
        }
      },
    );
  }
}

/// Splits the [constructorParametersTemplate]  into dependency parameters and
/// member parameters.
///
/// Throws an [UnresolvedParametersInfoException] if a parameter's kind can't
/// be determined (See [_getParameterKind]).
///
_SplitParametersTemplates _splitParametersTemplate(
    ParametersTemplate constructorParametersTemplate) {
  final dependencyParametersTemplate = constructorParametersTemplate.filter(
      (parameter) =>
          _getParameterKind(parameter) == ParameterKind.dependencyParameter);

  final memberParametersTemplate = constructorParametersTemplate.filter(
      (parameter) =>
          _getParameterKind(parameter) == ParameterKind.memberParameter);

  return (
    dependencyParametersTemplate: dependencyParametersTemplate,
    memberParametersTemplate: memberParametersTemplate,
  );
}

/// Returns the [ParameterKind] of the given [parameter] based on the
/// annotations it has.
///
/// Each parameter kind has a specific set of possible annotations. If a
/// parameter has annotations of both sets, this throws an
/// [UnresolvedParametersInfoException].
///
ParameterKind _getParameterKind(Parameter parameter) {
  ParameterKind? parameterKind;

  void setParameterKind(ParameterKind kind) {
    if (parameterKind == null) {
      parameterKind = kind;
    } else {
      throw UnresolvedParametersInfoException(
        'A parameter can\'t mix different annotations kinds.',
        failedParameter: parameter,
      );
    }
  }

  if (parameter.hasDependencyAnnotation) {
    setParameterKind(ParameterKind.dependencyParameter);
  }

  if (parameter.hasValidAnnotation ||
      parameter.hasInvalidAnnotation ||
      parameter.hasWithGetterAnnotation ||
      parameter.hasNullFailureAnnotation) {
    setParameterKind(ParameterKind.memberParameter);
  }

  return parameterKind ?? ParameterKind.memberParameter;
}

typedef _SplitParametersTemplates = ({
  ParametersTemplate dependencyParametersTemplate,
  ParametersTemplate memberParametersTemplate
});
