import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// Identifiers that are not related to the annotated class.
///
abstract class GlobalIdentifiers {
  static const copyWithIdentifiers = _CopyWithIdentifiers._();

  static const iterablesIdentifiers = _IterablesIdentifiers._();

  static const validateContentMethodIdentifiers =
      _ValidateContentMethodIdentifiers._();

  static const invalidModddelBaseIdentifiers =
      _InvalidModddelBaseIdentifiers._();

  static const baseModddelIdentifiers = _BaseModddelIdentifiers._();

  static const modddelParamsBaseIdentifiers = _ModddelParamsBaseIdentifiers._();

  static const invalidStepTestBaseIdentifiers =
      _InvalidStepTestBaseIdentifiers._();

  static const baseTesterIdentifiers = _BaseTesterIdentifiers._();

  static const validnessInterfacesIdentifiers =
      _ValidnessInterfacesIdentifiers._();

  static const failuresBaseIdentifiers = _FailuresBaseIdentifiers._();

  /// The name of the "UnimplementedError" constant.
  static const unimplementedErrorVarName = r'_$unimplementedError';

  static const validCallbackParamName = 'valid';

  static const invalidCallbackParamName = 'invalid';

  static const orElseCallbackParamName = 'orElse';

  /// The name of the [Equatable.props] getter.
  ///
  static const propsGetterName = 'props';
}

/* -------------------------------------------------------------------------- */
/*                             Grouped Identifiers                            */
/* -------------------------------------------------------------------------- */

// TODO : These classes should be replaced by records inside [GlobalIdentifiers]
// once the records feature is available in Dart.

class _CopyWithIdentifiers {
  const _CopyWithIdentifiers._();

  /// The name of the "CopyWithDefault" constant.
  final copyWithDefaultConstName = r'_$copyWithDefault';

  /// The name of the "CopyWithDefault" class.
  final copyWithDefaultClassName = r'_$CopyWithDefault';

  /// Returns the name of the local variable for the given [parameter], to be
  /// used in the copyWith method.
  ///
  String getCopyWithLocalVarName(Parameter parameter) {
    return '\$copy\$${parameter.name}';
  }
}

class _IterablesIdentifiers {
  const _IterablesIdentifiers._();

  /// The name of the [IterableEntity.$collectionToIterable] /
  /// [Iterable2Entity.$collectionToIterable] method.
  ///
  final collectionToIterableMethodName = r'$collectionToIterable';

  /// The name of the [IterableEntity.$castCollection] /
  /// [Iterable2Entity.$castCollection] method.
  ///
  final castCollectionMethodName = r'$castCollection';

  /// The name of the [IterableEntity.$primeCollection] /
  /// [Iterable2Entity.$primeCollection] method.
  ///
  final primeCollectionMethodName = r'$primeCollection';

  /// The name of the [IterableEntity.$validateContent] /
  /// [Iterable2Entity.$validateContent] method.
  ///
  final validateIterableContentMethodName = r'$validateContent';
}

class _ValidateContentMethodIdentifiers {
  const _ValidateContentMethodIdentifiers._();

  /// Returns the name of the local variable for the given [parameter], to be
  /// used in the validateContent method.
  ///
  String getInvalidLocalVarName(Parameter parameter) {
    return '\$invalid\$${parameter.name}';
  }
}

/// Identifiers related to the [InvalidModddel] base class.
///
class _InvalidModddelBaseIdentifiers {
  const _InvalidModddelBaseIdentifiers._();

  /// The name of the [InvalidModddel.failures] getter.
  ///
  final failuresGetterName = 'failures';

  /// Returns the parameter that represents the [InvalidModddel.failures]
  /// getter.
  ///
  Parameter getFailuresGetterParam({
    required String failureBaseClassName,
  }) =>
      ExpandedParameter.empty(
        name: failuresGetterName,
        type: 'List<$failureBaseClassName>',
      );
}

class _BaseModddelIdentifiers {
  const _BaseModddelIdentifiers._();

  /// The name of the [BaseModddel.isValid] getter.
  ///
  final isValidGetterName = 'isValid';

  /// The name of the [BaseModddel.toEither] getter.
  ///
  final toEitherGetterName = 'toEither';

  /// The name of the [BaseModddel.toBroadEither] getter.
  ///
  final toBroadEitherGetterName = 'toBroadEither';
}

/// Identifiers related to the [ModddelParams] base class.
///
class _ModddelParamsBaseIdentifiers {
  const _ModddelParamsBaseIdentifiers._();

  /// The name of the [ModddelParams] base class.
  final modddelParamsBaseClassName = 'ModddelParams';

  /// The name of the [ModddelParams.sanitizedParams] getter.
  final sanitizedParamsGetterName = 'sanitizedParams';

  /// The name of the [ModddelParams.toModddel] method.
  final toModddelMethodName = 'toModddel';

  /// The name of the local variable used to hold the result of calling the
  /// [ModddelParams.toModddel] method.
  ///
  final modddelLocalVarName = r'$modddel$';

  /// The [ModddelParams] "className" constructor parameter.
  ///
  ExpandedParameter get classNameParameter =>
      ExpandedParameter.empty(name: 'className', type: 'String');

  /// The [ModddelParams] "modddelKind" constructor parameter.
  ///
  ExpandedParameter get modddelKindParameter =>
      ExpandedParameter.empty(name: 'modddelKind', type: 'String');
}

/// Identifiers related to the [InvalidStepTest] base class.
///
class _InvalidStepTestBaseIdentifiers {
  const _InvalidStepTestBaseIdentifiers._();

  /// The name of the [InvalidStepTest] base class.
  final invalidStepTestBaseClassName = 'InvalidStepTest';

  /// The [InvalidStepTest] "_tester" positional constructor parameter.
  ExpandedParameter get istTesterParameter => ExpandedParameter.empty(
        name: 'tester',
        type: _BaseTesterIdentifiers._().baseTesterClassName,
      );

  /// The [InvalidStepTest] "vStepName" named constructor parameter.
  ExpandedParameter get istVStepNameParameter => ExpandedParameter.empty(
        name: 'vStepName',
        type: 'String',
      );

  /// The name of the [InvalidStepTest.$getCommonSteps] method.
  final istCommonStepsMethodName = r'$getCommonSteps';

  /// The name of the [InvalidStepTest.$hasFailureStep] method.
  final istHasFailureStepMethodName = r'$hasFailureStep';
}

/// Identifiers related to the [BaseTester] base class.
///
class _BaseTesterIdentifiers {
  const _BaseTesterIdentifiers._();

  /// The name of the [BaseTester] base class.
  final baseTesterClassName = 'BaseTester';

  /// The [BaseTester.maxTestInfoLength] parameter.
  ExpandedParameter get maxTestInfoLengthParameter =>
      ExpandedParameter.empty(name: 'maxTestInfoLength', type: 'int');
}

class _ValidnessInterfacesIdentifiers {
  const _ValidnessInterfacesIdentifiers._();

  /// The name of the [ValidValueObject] base interface.
  final validValueObjectBaseInterfaceName = 'ValidValueObject';

  /// The name of the [ValidEntity] base interface.
  final validEntityBaseInterfaceName = 'ValidEntity';

  /// The name of the [InvalidValueObject] base interface.
  final invalidValueObjectBaseInterfaceName = 'InvalidValueObject';

  /// The name of the [InvalidEntity] base interface.
  final invalidEntityBaseInterfaceName = 'InvalidEntity';

  /// Returns the name of the "valid" base interface for the given
  /// [modddelKind].
  ///
  /// - For [ModddelKind.valueObject] : It's [ValidValueObject].
  /// - For [ModddelKind.entity] : It's [ValidEntity].
  ///
  String getValidBaseInterfaceName(ModddelKind modddelKind) => modddelKind.map(
        valueObject: (_) => validValueObjectBaseInterfaceName,
        entity: (_) => validEntityBaseInterfaceName,
      );

  /// Returns the name of the "invalid" base interface for the given
  /// [modddelKind].
  ///
  /// - For [ModddelKind.valueObject] : It's [InvalidValueObject].
  /// - For [ModddelKind.entity] : It's [InvalidEntity].
  ///
  String getInvalidBaseInterfaceName(ModddelKind modddelKind) =>
      modddelKind.map(
        valueObject: (_) => invalidValueObjectBaseInterfaceName,
        entity: (_) => invalidEntityBaseInterfaceName,
      );
}

class _FailuresBaseIdentifiers {
  const _FailuresBaseIdentifiers._();

  /// The name of the [Failure] abstract base class.
  final failureBaseClassName = 'Failure';

  /// The name of the [ValueFailure] abstract base class.
  final valueFailureBaseClassName = 'ValueFailure';

  /// The name of the [EntityFailure] abstract base class.
  final entityFailureBaseClassName = 'EntityFailure';

  /// The name of the [ContentFailure] class.
  final contentFailureClassName = 'ContentFailure';

  /// The name of the "contentFailure" local variable, used for example in the
  /// validateContent method.
  final contentFailureLocalVarName = r'$contentFailure';

  /// The name of the [ContentFailure.invalidMembers] property.
  final cfInvalidMembersPropName = 'invalidMembers';

  /// The name of the [ModddelInvalidMember] class.
  final modddelInvalidMemberClassName = 'ModddelInvalidMember';

  /// The parameter representing the [ModddelInvalidMember.member] property.
  ExpandedParameter get mimMemberParameter => ExpandedParameter.empty(
        name: 'member',
        type: 'InvalidModddel',
      );

  /// The parameter representing the [ModddelInvalidMember.description]
  /// property.
  ExpandedParameter get mimDescriptionParameter => ExpandedParameter.empty(
        name: 'description',
        type: 'String',
      );

  /// Returns the name of the base class of the failures for the given
  /// [modddelKind].
  ///
  /// - For [ModddelKind.valueObject] : It's [ValueFailure].
  /// - For [ModddelKind.entity] : It's [EntityFailure].
  ///
  String getFailureBaseClassName(ModddelKind modddelKind) => modddelKind.map(
        valueObject: (_) => valueFailureBaseClassName,
        entity: (_) => entityFailureBaseClassName,
      );
}
