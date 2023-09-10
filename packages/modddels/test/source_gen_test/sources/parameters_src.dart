import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';

/* -------------------------------------------------------------------------- */
/*      Can't have some annotations applied twice for the same parameter      */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'A parameter can\'t have the same annotation more than once : @dependencyParam',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MultipleDependencyAnnotations1 extends SimpleEntity {
  MultipleDependencyAnnotations1._();

  factory MultipleDependencyAnnotations1({
    @dependencyParam @dependencyParam required AClass param,
  }) =>
      MultipleDependencyAnnotations1._();
}

@ShouldThrow(
  'A parameter can\'t have the same annotation more than once : @dependencyParam',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MultipleDependencyAnnotations2 extends SimpleEntity {
  MultipleDependencyAnnotations2._();

  factory MultipleDependencyAnnotations2({
    @dependencyParam @dependencyParam @dependencyParam required AClass param,
  }) =>
      MultipleDependencyAnnotations2._();
}

@ShouldThrow(
  'A parameter can\'t have the same annotation more than once : @validParam',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MultipleValidAnnotations extends SimpleEntity {
  MultipleValidAnnotations._();

  factory MultipleValidAnnotations({
    @validParam @validParam required AClass param,
  }) =>
      MultipleValidAnnotations._();
}

@ShouldThrow(
  'A parameter can\'t have the same annotation more than once : @invalidParam',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MultipleInvalidAnnotations extends SimpleEntity {
  MultipleInvalidAnnotations._();

  factory MultipleInvalidAnnotations({
    @invalidParam @invalidParam required AClass param,
  }) =>
      MultipleInvalidAnnotations._();
}

@ShouldThrow(
  'A parameter can\'t have the same annotation more than once : @withGetter',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MultipleWithGetterAnnotations extends SimpleEntity {
  MultipleWithGetterAnnotations._();

  factory MultipleWithGetterAnnotations({
    @withGetter @withGetter required AClass param,
  }) =>
      MultipleWithGetterAnnotations._();
}

/* -------------------------------------------------------------------------- */
/*                    Can't have some redundant annotations                   */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'A parameter can\'t have both of these annotations : @validParam and @validWithGetter',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class RedundantValidAnnotations extends SimpleEntity {
  RedundantValidAnnotations._();

  factory RedundantValidAnnotations({
    @validParam @validWithGetter required AClass param,
  }) =>
      RedundantValidAnnotations._();
}

@ShouldThrow(
  'A parameter can\'t have both of these annotations : @invalidParam and @invalidWithGetter',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class RedundantInvalidAnnotations extends SimpleEntity {
  RedundantInvalidAnnotations._();

  factory RedundantInvalidAnnotations({
    @invalidParam @invalidWithGetter required AClass param,
  }) =>
      RedundantInvalidAnnotations._();
}

@ShouldThrow(
  'A parameter can\'t have both of these annotations : @withGetter and @validWithGetter',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class RedundantWithGetterAnnotations1 extends SimpleEntity {
  RedundantWithGetterAnnotations1._();

  factory RedundantWithGetterAnnotations1({
    @withGetter @validWithGetter required AClass param,
  }) =>
      RedundantWithGetterAnnotations1._();
}

@ShouldThrow(
  'A parameter can\'t have both of these annotations : @withGetter and @invalidWithGetter',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class RedundantWithGetterAnnotations2 extends SimpleEntity {
  RedundantWithGetterAnnotations2._();

  factory RedundantWithGetterAnnotations2({
    @withGetter @invalidWithGetter required AClass param,
  }) =>
      RedundantWithGetterAnnotations2._();
}

/* -------------------------------------------------------------------------- */
/*                       The parameters can't be private                      */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'UnresolvedParametersException: The parameters of a factory constructor can\'t be private.\n'
  'Failed Parameter : "_param"\n',
  element: '_param',
)
@Modddel(validationSteps: noVSteps)
class PrivateMemberParam1 extends SingleValueObject {
  PrivateMemberParam1._();

  // ignore: no_leading_underscores_for_local_identifiers
  factory PrivateMemberParam1(AClass _param) => PrivateMemberParam1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameters of a factory constructor can\'t be private.\n'
  'Failed Parameter : "_param2"\n',
  element: '_param2',
)
@Modddel(validationSteps: noVSteps)
class PrivateMemberParam2 extends SimpleEntity {
  PrivateMemberParam2._();

  factory PrivateMemberParam2.named(
    AClass param1,
    // ignore: no_leading_underscores_for_local_identifiers
    AClass? _param2, {
    required AClass param3,
  }) =>
      PrivateMemberParam2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameters of a factory constructor can\'t be private.\n'
  'Failed Parameter : "_aService"\n',
  element: '_aService',
)
@Modddel(validationSteps: noVSteps)
class PrivateDependencyParam1 extends MultiValueObject {
  PrivateDependencyParam1._();

  // ignore: no_leading_underscores_for_local_identifiers
  factory PrivateDependencyParam1(@dependencyParam AService _aService) =>
      PrivateDependencyParam1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameters of a factory constructor can\'t be private.\n'
  'Failed Parameter : "_aService"\n',
  element: '_aService',
)
@Modddel(validationSteps: noVSteps)
class PrivateDependencyParam2 extends ListEntity {
  PrivateDependencyParam2._();

  factory PrivateDependencyParam2.named(
    AClass param,
    // ignore: no_leading_underscores_for_local_identifiers
    @dependencyParam AService _aService,
  ) =>
      PrivateDependencyParam2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameters of a factory constructor can\'t be private.\n'
  'Failed Parameter : "_param"\n',
  element: '_param',
)
@Modddel(validationSteps: noVSteps)
class PrivateParams extends MapEntity {
  PrivateParams._();

  factory PrivateParams(
    // ignore: no_leading_underscores_for_local_identifiers
    AClass _param,
    // ignore: no_leading_underscores_for_local_identifiers
    @dependencyParam AService _aService,
  ) =>
      PrivateParams._();
}

/* -------------------------------------------------------------------------- */
/*    The names of the parameters don't conflict with reserved identifiers    */
/* -------------------------------------------------------------------------- */

// NB : Just testing a few reserved identifiers names.

@ShouldThrow(
  'UnresolvedParametersException: The parameter name "valid" is reserved and '
  'should not be used.\n'
  'Failed Parameter : "valid"\n',
  element: 'valid',
)
@Modddel(validationSteps: noVSteps)
class ConflictingName1 extends SingleValueObject {
  ConflictingName1._();

  factory ConflictingName1(
    // `GlobalIdentifiers.validCallbackParamName`
    AClass valid,
  ) =>
      ConflictingName1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter name "toEither" is reserved and '
  'should not be used.\n'
  'Failed Parameter : "toEither"\n',
  element: 'toEither',
)
@Modddel(validationSteps: noVSteps)
class ConflictingName2 extends SimpleEntity {
  ConflictingName2._();

  factory ConflictingName2({
    // `GlobalIdentifiers.baseModddelIdentifiers.toEitherGetterName`
    @withGetter required AClass toEither,
  }) =>
      ConflictingName2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter name "copyWith" is reserved and '
  'should not be used.\n'
  'Failed Parameter : "copyWith"\n',
  element: 'copyWith',
)
@Modddel(validationSteps: noVSteps)
class ConflictingName3 extends MultiValueObject {
  ConflictingName3._();

  factory ConflictingName3.named({
    // `generalIdentifiers.copyWithGetterName`
    AClass? copyWith,
  }) =>
      ConflictingName3._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter name "\$conflictingName4Instance" '
  'is reserved and should not be used.\n'
  'Failed Parameter : "\$conflictingName4Instance"\n',
  element: '\$conflictingName4Instance',
)
@Modddel(validationSteps: noVSteps)
class ConflictingName4 extends ListEntity {
  ConflictingName4._();

  factory ConflictingName4.named(
    AClass param1, {
    // `generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName`
    @dependencyParam required $conflictingName4Instance,
  }) =>
      ConflictingName4._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter name "\$namedDependencies" '
  'is reserved and should not be used.\n'
  'Failed Parameter : "\$namedDependencies"\n',
  element: '\$namedDependencies',
)
@Modddel(validationSteps: noVSteps)
class ConflictingName5 extends MapEntity {
  ConflictingName5._();

  factory ConflictingName5.named({
    // `modddelClassIdentifiers.dependenciesVariableName`
    AClass? $namedDependencies,
  }) =>
      ConflictingName5._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter name "invalidConflictingName6" '
  'is reserved and should not be used.\n'
  'Failed Parameter : "invalidConflictingName6"\n',
  element: 'invalidConflictingName6',
)
@Modddel(validationSteps: noVSteps)
class ConflictingName6 extends MapEntity {
  ConflictingName6._();

  factory ConflictingName6.named({
    // `sSealedClassIdentifiers.invalidVariableName`
    @withGetter required AClass invalidConflictingName6,
  }) =>
      ConflictingName6._();
}

/* -------------------------------------------------------------------------- */
/*                    Can't mix different annotations kinds                   */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsValueObject1 extends SingleValueObject {
  DifferentKindsValueObject1._();

  factory DifferentKindsValueObject1({
    @dependencyParam @withGetter required AClass param,
  }) =>
      DifferentKindsValueObject1._();
}

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsValueObject2 extends MultiValueObject {
  DifferentKindsValueObject2._();

  factory DifferentKindsValueObject2({
    @dependencyParam
    @NullFailure('length', LengthFailure())
    required AClass param,
  }) =>
      DifferentKindsValueObject2._();
}

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsSimpleEntity1 extends SimpleEntity {
  DifferentKindsSimpleEntity1._();

  factory DifferentKindsSimpleEntity1.named({
    @dependencyParam @validParam required AClass param,
  }) =>
      DifferentKindsSimpleEntity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsSimpleEntity2 extends SimpleEntity {
  DifferentKindsSimpleEntity2._();

  factory DifferentKindsSimpleEntity2({
    @dependencyParam @invalidParam required AClass param,
  }) =>
      DifferentKindsSimpleEntity2._();
}

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsSimpleEntity3 extends SimpleEntity {
  DifferentKindsSimpleEntity3._();

  factory DifferentKindsSimpleEntity3.named({
    @dependencyParam @validWithGetter required AClass param,
  }) =>
      DifferentKindsSimpleEntity3._();
}

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsSimpleEntity4 extends SimpleEntity {
  DifferentKindsSimpleEntity4._();

  factory DifferentKindsSimpleEntity4({
    @dependencyParam @invalidWithGetter required AClass param,
  }) =>
      DifferentKindsSimpleEntity4._();
}

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsIterables1 extends ListEntity {
  DifferentKindsIterables1._();

  factory DifferentKindsIterables1({
    @NullFailure('length', LengthFailure())
    @dependencyParam
    required AClass param,
  }) =>
      DifferentKindsIterables1._();
}

@ShouldThrow(
  'UnresolvedParametersException: A parameter can\'t mix different annotations '
  'kinds.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DifferentKindsIterables2 extends MapEntity {
  DifferentKindsIterables2._();

  factory DifferentKindsIterables2({
    @dependencyParam
    @withGetter
    @NullFailure('length', LengthFailure())
    required AClass? param,
  }) =>
      DifferentKindsIterables2._();
}

/* -------------------------------------------------------------------------- */
/*                     The number of parameters is correct                    */
/* -------------------------------------------------------------------------- */

/* ----- At least one member parameter : MultiValueObject - SimpleEntity ---- */

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain at least one member parameter.\n',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class ZeroMemberParamsMultiValueObject1 extends MultiValueObject {
  ZeroMemberParamsMultiValueObject1._();

  factory ZeroMemberParamsMultiValueObject1() =>
      ZeroMemberParamsMultiValueObject1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain at least one member parameter.\n',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class ZeroMemberParamsMultiValueObject2 extends MultiValueObject {
  ZeroMemberParamsMultiValueObject2._();

  factory ZeroMemberParamsMultiValueObject2.named(
          @dependencyParam AService aService) =>
      ZeroMemberParamsMultiValueObject2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain at least one member parameter.\n',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class ZeroMemberParamsSimpleEntity1 extends SimpleEntity {
  ZeroMemberParamsSimpleEntity1._();

  factory ZeroMemberParamsSimpleEntity1() => ZeroMemberParamsSimpleEntity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain at least one member parameter.\n',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class ZeroMemberParamsSimpleEntity2 extends SimpleEntity {
  ZeroMemberParamsSimpleEntity2._();

  factory ZeroMemberParamsSimpleEntity2.named({
    @dependencyParam required AService aService1,
    @dependencyParam required AService aService2,
  }) =>
      ZeroMemberParamsSimpleEntity2._();
}

/* -- Exactly one member parameter : SingleValueObject - IterablesEntities -- */

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain a single member parameter.\n',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class ZeroMemberParamsSingleValueObject extends SingleValueObject {
  ZeroMemberParamsSingleValueObject._();

  factory ZeroMemberParamsSingleValueObject.named() =>
      ZeroMemberParamsSingleValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain a single member parameter.\n',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class TooManyMemberParamsSingleValueObject extends SingleValueObject {
  TooManyMemberParamsSingleValueObject._();

  factory TooManyMemberParamsSingleValueObject({
    required AClass param1,
    required AClass param2,
  }) =>
      TooManyMemberParamsSingleValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain a single member parameter.\n',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class ZeroMemberParamsIterableEntity extends ListEntity {
  ZeroMemberParamsIterableEntity._();

  factory ZeroMemberParamsIterableEntity(
    @dependencyParam AService aService1, {
    @dependencyParam required AService aService2,
  }) =>
      ZeroMemberParamsIterableEntity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain a single member parameter.\n',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class TooManyMemberParamsIterableEntity extends ListEntity {
  TooManyMemberParamsIterableEntity._();

  factory TooManyMemberParamsIterableEntity.named(
    AClass param1, {
    AClass? param2,
  }) =>
      TooManyMemberParamsIterableEntity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain a single member parameter.\n',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class ZeroMemberParamsIterable2Entity extends MapEntity {
  ZeroMemberParamsIterable2Entity._();

  factory ZeroMemberParamsIterable2Entity.named() =>
      ZeroMemberParamsIterable2Entity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The factory constructor should contain a single member parameter.\n',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class TooManyMemberParamsIterable2Entity extends MapEntity {
  TooManyMemberParamsIterable2Entity._();

  factory TooManyMemberParamsIterable2Entity(
    AClass param1,
    AClass param2,
  ) =>
      TooManyMemberParamsIterable2Entity._();
}

/* -------------------------------------------------------------------------- */
/*                   Iterables parameters types are correct.                  */
/* -------------------------------------------------------------------------- */

/* --------- The type of the iterableParameter shouldn't be dynamic --------- */

@ShouldThrow(
  'UnresolvedParametersException: The iterable parameter can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeIterables1 extends ListEntity {
  DynamicTypeIterables1._();

  factory DynamicTypeIterables1({
    required param,
  }) =>
      DynamicTypeIterables1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The iterable parameter can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeIterables2 extends MapEntity {
  DynamicTypeIterables2._();

  factory DynamicTypeIterables2.named([dynamic param]) =>
      DynamicTypeIterables2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The iterable parameter can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeIterables3 extends MapEntity {
  DynamicTypeIterables3._();

  // ignore: unnecessary_question_mark
  factory DynamicTypeIterables3.named(dynamic? param) =>
      DynamicTypeIterables3._();
}

/* --------- The type of the iterableParameter shouldn't be nullable -------- */

@ShouldThrow(
  'UnresolvedParametersException: The iterable parameter can\'t be nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NullableTypeIterables1 extends ListEntity {
  NullableTypeIterables1._();

  factory NullableTypeIterables1({
    required AClass? param,
  }) =>
      NullableTypeIterables1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The iterable parameter can\'t be nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NullableTypeIterables2 extends MapEntity {
  NullableTypeIterables2._();

  // ignore: prefer_void_to_null
  factory NullableTypeIterables2.named([Null param]) =>
      NullableTypeIterables2._();
}

/* --------- The type of the parameter should match the TypeTemplate -------- */

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "List<#1>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class IncorrectTypeIterableEntity1 extends ListEntity {
  IncorrectTypeIterableEntity1._();

  factory IncorrectTypeIterableEntity1({
    required AClass param,
  }) =>
      IncorrectTypeIterableEntity1._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "List<#1>".',
  element: 'param1',
)
@Modddel(validationSteps: noVSteps)
class IncorrectTypeIterableEntity2 extends ListEntity {
  IncorrectTypeIterableEntity2._();

  factory IncorrectTypeIterableEntity2(
    Set<AClass> param1, {
    @dependencyParam required List<AClass> param2,
  }) =>
      IncorrectTypeIterableEntity2._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "List<#1>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class IncorrectTypeIterableEntity3 extends ListEntity {
  IncorrectTypeIterableEntity3._();

  factory IncorrectTypeIterableEntity3(AGeneric<AClass> param) =>
      IncorrectTypeIterableEntity3._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "AGeneric2<#1>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('AGeneric2<#1>')
class IncorrectTypeIterableEntity4 extends IterableEntity {
  IncorrectTypeIterableEntity4._();

  factory IncorrectTypeIterableEntity4.named(AGeneric2<AClass, AClass> param) =>
      IncorrectTypeIterableEntity4._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "AGeneric2<#1,*>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('AGeneric2<#1,*>')
class IncorrectTypeIterableEntity5 extends IterableEntity {
  IncorrectTypeIterableEntity5._();

  factory IncorrectTypeIterableEntity5({
    required Set<AClass> param,
  }) =>
      IncorrectTypeIterableEntity5._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "AGeneric3<#1,*>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('AGeneric3<#1,*>')
class IncorrectTypeIterableEntity6 extends IterableEntity {
  IncorrectTypeIterableEntity6._();

  factory IncorrectTypeIterableEntity6.named(
          AGeneric3<AClass, AClass, AClass> param) =>
      IncorrectTypeIterableEntity6._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "AGeneric3<*,#1,*>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('AGeneric3<*,#1,*>')
class IncorrectTypeIterableEntity7 extends IterableEntity {
  IncorrectTypeIterableEntity7._();

  factory IncorrectTypeIterableEntity7(AGeneric2 param) =>
      IncorrectTypeIterableEntity7._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "Map<#1,#2>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class IncorrectTypeIterable2Entity1 extends MapEntity {
  IncorrectTypeIterable2Entity1._();

  factory IncorrectTypeIterable2Entity1({
    required AClass param,
  }) =>
      IncorrectTypeIterable2Entity1._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "Map<#1,#2>".',
  element: 'param1',
)
@Modddel(validationSteps: noVSteps)
class IncorrectTypeIterable2Entity2 extends MapEntity {
  IncorrectTypeIterable2Entity2._();

  factory IncorrectTypeIterable2Entity2(
    MapEntry<AClass, AClass> param1, {
    @dependencyParam required Map<AClass, AClass> param2,
  }) =>
      IncorrectTypeIterable2Entity2._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "Map<#1,#2>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class IncorrectTypeIterable2Entity3 extends MapEntity {
  IncorrectTypeIterable2Entity3._();

  factory IncorrectTypeIterable2Entity3(List<AClass> param) =>
      IncorrectTypeIterable2Entity3._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "AGeneric3<#1,#2>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('AGeneric3<#1,#2>')
class IncorrectTypeIterable2Entity4 extends Iterable2Entity {
  IncorrectTypeIterable2Entity4._();

  factory IncorrectTypeIterable2Entity4.named(
          AGeneric3<AClass, AClass, AClass> param) =>
      IncorrectTypeIterable2Entity4._();
}

@ShouldThrow(
  'The type of the parameter doesn\'t match the TypeTemplate "AGeneric3<#1,#2,*>".',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('AGeneric3<#1,#2,*>')
class IncorrectTypeIterable2Entity5 extends Iterable2Entity {
  IncorrectTypeIterable2Entity5._();

  factory IncorrectTypeIterable2Entity5({
    required AGeneric2<AClass, AClass> param,
  }) =>
      IncorrectTypeIterable2Entity5._();
}

/* ------------------- The modddelType(s) can't be invalid ------------------ */

@ShouldThrow(
  'UnresolvedParametersException: The modddel type can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicModddelTypeIterableEntity1 extends ListEntity {
  DynamicModddelTypeIterableEntity1._();

  factory DynamicModddelTypeIterableEntity1(List<dynamic> param) =>
      DynamicModddelTypeIterableEntity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The modddel type can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicModddelTypeIterableEntity2 extends ListEntity {
  DynamicModddelTypeIterableEntity2._();

  factory DynamicModddelTypeIterableEntity2.named({
    // ignore: unnecessary_question_mark
    required List<dynamic?> param,
  }) =>
      DynamicModddelTypeIterableEntity2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The modddel type can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicModddelTypeIterable2Entity1 extends MapEntity {
  DynamicModddelTypeIterable2Entity1._();

  factory DynamicModddelTypeIterable2Entity1({
    // ignore: unnecessary_question_mark
    required Map<dynamic?, AClass> param,
  }) =>
      DynamicModddelTypeIterable2Entity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The modddel type can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicModddelTypeIterable2Entity2 extends MapEntity {
  DynamicModddelTypeIterable2Entity2._();

  factory DynamicModddelTypeIterable2Entity2.named({
    required Map<AClass?, dynamic> param,
  }) =>
      DynamicModddelTypeIterable2Entity2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The modddel type can\'t be dynamic.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicModddelTypeIterable2Entity3 extends MapEntity {
  DynamicModddelTypeIterable2Entity3._();

  factory DynamicModddelTypeIterable2Entity3({
    required Map<dynamic, dynamic> param,
  }) =>
      DynamicModddelTypeIterable2Entity3._();
}

/* -------------------------------------------------------------------------- */
/*        Valid and Invalid annotations are reserved for SimpleEntities       */
/* -------------------------------------------------------------------------- */

/* ---- Only SimpleEntities can have `@validParam` or `@validWithGetter` ---- */

@ShouldThrow(
  'UnresolvedParametersException: The @validParam and @validWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class ValidAnnotationInSingleValueObject extends SingleValueObject {
  ValidAnnotationInSingleValueObject._();

  factory ValidAnnotationInSingleValueObject.named({
    @validParam required AClass param,
  }) =>
      ValidAnnotationInSingleValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @validParam and @validWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param1"\n',
  element: 'param1',
)
@Modddel(validationSteps: noVSteps)
class ValidAnnotationInMultiValueObject extends MultiValueObject {
  ValidAnnotationInMultiValueObject._();

  factory ValidAnnotationInMultiValueObject(
    @validWithGetter AClass param1, {
    required AClass param2,
  }) =>
      ValidAnnotationInMultiValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @validParam and @validWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class ValidAnnotationInIterableEntity extends ListEntity {
  ValidAnnotationInIterableEntity._();

  factory ValidAnnotationInIterableEntity.named({
    @validParam required List<AClass> param,
  }) =>
      ValidAnnotationInIterableEntity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @validParam and @validWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class ValidAnnotationInIterable2Entity extends MapEntity {
  ValidAnnotationInIterable2Entity._();

  factory ValidAnnotationInIterable2Entity(
          @validWithGetter Map<AClass, AClass> param) =>
      ValidAnnotationInIterable2Entity._();
}

/* -- Only SimpleEntities can have `@invalidParam` or `@invalidWithGetter` -- */

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam and @invalidWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationInSingleValueObject extends SingleValueObject {
  InvalidAnnotationInSingleValueObject._();

  factory InvalidAnnotationInSingleValueObject.named({
    @invalidParam required AClass param,
  }) =>
      InvalidAnnotationInSingleValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam and @invalidWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param1"\n',
  element: 'param1',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationInMultiValueObject extends MultiValueObject {
  InvalidAnnotationInMultiValueObject._();

  factory InvalidAnnotationInMultiValueObject(
    @invalidWithGetter AClass? param1, {
    required AClass param2,
  }) =>
      InvalidAnnotationInMultiValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam and @invalidWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationInIterableEntity extends ListEntity {
  InvalidAnnotationInIterableEntity._();

  factory InvalidAnnotationInIterableEntity.named(
    @invalidParam List<AClass> param,
  ) =>
      InvalidAnnotationInIterableEntity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam and @invalidWithGetter '
  'annotations can only be used inside SimpleEntities.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationInIterable2Entity extends MapEntity {
  InvalidAnnotationInIterable2Entity._();

  factory InvalidAnnotationInIterable2Entity({
    @invalidWithGetter required Map<AClass, AClass> param,
  }) =>
      InvalidAnnotationInIterable2Entity._();
}

/* -------------------------------------------------------------------------- */
/*              Valid and Invalid annotations are used correctly              */
/* -------------------------------------------------------------------------- */

/* ------- The member parameters of a SimpleEntity can't all be valid ------- */

@ShouldThrow(
  'UnresolvedParametersException: A SimpleEntity can\'t have all its member '
  'parameters marked with @validParam or @validWithGetter.\n',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class AllValidAnnotations1 extends SimpleEntity {
  AllValidAnnotations1._();

  factory AllValidAnnotations1.named({
    @validParam required AClass param1,
    @validWithGetter required AClass param2,
  }) =>
      AllValidAnnotations1._();
}

@ShouldThrow(
  'UnresolvedParametersException: A SimpleEntity can\'t have all its member '
  'parameters marked with @validParam or @validWithGetter.\n',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class AllValidAnnotations2 extends SimpleEntity {
  AllValidAnnotations2._();

  factory AllValidAnnotations2(
    @validParam AClass param, {
    @dependencyParam required AService aService,
  }) =>
      AllValidAnnotations2._();
}

/* -------- The valid and invalid annotations can't be used together -------- */

@ShouldThrow(
  'UnresolvedParametersException: The @validParam (or @validWithGetter) annotation '
  'and the @invalidParam (or @invalidWithGetter) annotation can\'t be used together '
  'on the same member parameter.\n'
  'Failed Parameter : "param2"\n',
  element: 'param2',
)
@Modddel(validationSteps: noVSteps)
class ValidAndInvalidAnnotations1 extends SimpleEntity {
  ValidAndInvalidAnnotations1._();

  factory ValidAndInvalidAnnotations1.named(
    AClass param1, {
    @validParam @invalidParam AClass? param2,
  }) =>
      ValidAndInvalidAnnotations1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @validParam (or @validWithGetter) annotation '
  'and the @invalidParam (or @invalidWithGetter) annotation can\'t be used together '
  'on the same member parameter.\n'
  'Failed Parameter : "param1"\n',
  element: 'param1',
)
@Modddel(validationSteps: noVSteps)
class ValidAndInvalidAnnotations2 extends SimpleEntity {
  ValidAndInvalidAnnotations2._();

  factory ValidAndInvalidAnnotations2(
    @validWithGetter @invalidParam AClass param1, {
    required AClass param2,
    @dependencyParam AService? aService,
  }) =>
      ValidAndInvalidAnnotations2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @validParam (or @validWithGetter) annotation '
  'and the @invalidParam (or @invalidWithGetter) annotation can\'t be used together '
  'on the same member parameter.\n'
  'Failed Parameter : "param1"\n',
  element: 'param1',
)
@Modddel(validationSteps: noVSteps)
class ValidAndInvalidAnnotations3 extends SimpleEntity {
  ValidAndInvalidAnnotations3._();

  factory ValidAndInvalidAnnotations3.named(
    @validParam @invalidWithGetter AClass param1, [
    AClass? param2,
  ]) =>
      ValidAndInvalidAnnotations3._();
}

/* ------ The invalid annotation should be used on nullable parameters ------ */

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam (or @invalidWithGetter) annotation '
  'can only be used on nullable member parameters.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationOnNonNullable1 extends SimpleEntity {
  InvalidAnnotationOnNonNullable1._();

  factory InvalidAnnotationOnNonNullable1({
    @invalidParam required AClass param,
  }) =>
      InvalidAnnotationOnNonNullable1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam (or @invalidWithGetter) '
  'annotation can only be used on nullable member parameters.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationOnNonNullable2 extends SimpleEntity {
  InvalidAnnotationOnNonNullable2._();

  factory InvalidAnnotationOnNonNullable2.named(
    @invalidWithGetter AClass param,
  ) =>
      InvalidAnnotationOnNonNullable2._();
}

/* --------- The invalid annotation can't be used on Null parameters -------- */

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam (or @invalidWithGetter) '
  'annotation can\'t be used on a Null member parameter, because it won\'t have '
  'any effect.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationOnNull1 extends SimpleEntity {
  InvalidAnnotationOnNull1._();

  factory InvalidAnnotationOnNull1({
    // ignore: prefer_void_to_null
    @invalidParam required Null param,
  }) =>
      InvalidAnnotationOnNull1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam (or @invalidWithGetter) '
  'annotation can\'t be used on a Null member parameter, because it won\'t have '
  'any effect.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAnnotationOnNull2 extends SimpleEntity {
  InvalidAnnotationOnNull2._();

  factory InvalidAnnotationOnNull2.named(
    // ignore: prefer_void_to_null
    @invalidWithGetter Null param,
  ) =>
      InvalidAnnotationOnNull2._();
}

/* ----- The invalid and NullFailure annotations can't be used together ----- */

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam (or @invalidWithGetter) '
  'annotation and the @NullFailure annotation can\'t be used together on the '
  'same member parameter.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAndNullFailureAnnotations1 extends SimpleEntity {
  InvalidAndNullFailureAnnotations1._();

  factory InvalidAndNullFailureAnnotations1(
          @invalidParam
          @NullFailure('length', LengthFailure())
          AClass? param) =>
      InvalidAndNullFailureAnnotations1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @invalidParam (or @invalidWithGetter) '
  'annotation and the @NullFailure annotation can\'t be used together on the '
  'same member parameter.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidAndNullFailureAnnotations2 extends SimpleEntity {
  InvalidAndNullFailureAnnotations2._();

  factory InvalidAndNullFailureAnnotations2.named({
    @NullFailure('length', LengthFailure()) @invalidWithGetter AClass? param,
  }) =>
      InvalidAndNullFailureAnnotations2._();
}

/* -------------------------------------------------------------------------- */
/*             A SimpleEntity's parameter can't be dynamic unless             */
/*                annotated with a valid or invalid annotation                */
/* -------------------------------------------------------------------------- */
@ShouldThrow(
  'UnresolvedParametersException: Member parameters of a SimpleEntity can\'t have '
  'a dynamic type. The only exception are member parameters annotated with '
  '@validParam, @validWithGetter, @invalidParam or @invalidWithGetter.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeSimpleEntity1 extends SimpleEntity {
  DynamicTypeSimpleEntity1._();

  factory DynamicTypeSimpleEntity1({param}) => DynamicTypeSimpleEntity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: Member parameters of a SimpleEntity can\'t have '
  'a dynamic type. The only exception are member parameters annotated with '
  '@validParam, @validWithGetter, @invalidParam or @invalidWithGetter.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeSimpleEntity2 extends SimpleEntity {
  DynamicTypeSimpleEntity2._();

  factory DynamicTypeSimpleEntity2.named(dynamic param) =>
      DynamicTypeSimpleEntity2._();
}

/* -------------------------------------------------------------------------- */
/*                  The NullFailure annotation can be parsed                  */
/* -------------------------------------------------------------------------- */

/* -- The NullFailure annotation must be instantiated just before the param - */

const outsideNullFailure1 = NullFailure('validation1', AFailure());

const outsideNullFailure2 =
    NullFailure('validation1', AnotherFailure(), maskNb: 2);

@ShouldThrow(
  'Failed to extract the "failure" field of the "@NullFailure" annotation.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InstantiatedOutsideParam1 extends SingleValueObject {
  InstantiatedOutsideParam1._();

  factory InstantiatedOutsideParam1({
    @outsideNullFailure1 required AClass param,
  }) =>
      InstantiatedOutsideParam1._();
}

@ShouldThrow(
  'Failed to extract the "failure" field of the "@NullFailure" annotation.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InstantiatedOutsideParam2 extends MapEntity {
  InstantiatedOutsideParam2._();

  factory InstantiatedOutsideParam2.named({
    @outsideNullFailure2 required Map<AClass, AClass> param,
  }) =>
      InstantiatedOutsideParam2._();
}

/* ----- The maskNb, when provided, should be a literal positive integer ---- */

const maskNb1 = 1;

/// TODO : Add node argument when supported by source_gen_test. See
/// https://github.com/kevmoo/source_gen_test/issues/55
@ShouldThrow(
  'The maskNb of the "@NullFailure" annotation, when provided, should be '
  'a literal positive integer, while "maskNb1" is not.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonLiteralPositiveInteger1 extends MultiValueObject {
  NonLiteralPositiveInteger1._();

  factory NonLiteralPositiveInteger1(
    @NullFailure('validation1', AFailure(), maskNb: maskNb1) AClass param,
  ) =>
      NonLiteralPositiveInteger1._();
}

/// TODO : Add node argument when supported by source_gen_test. See
/// https://github.com/kevmoo/source_gen_test/issues/55
@ShouldThrow(
  'The maskNb of the "@NullFailure" annotation, when provided, should be '
  'a literal positive integer, while "-1" is not.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonLiteralPositiveInteger2 extends ListEntity {
  NonLiteralPositiveInteger2._();

  factory NonLiteralPositiveInteger2(
    @NullFailure('validation1', AFailure(), maskNb: -1) List<AClass?> param,
  ) =>
      NonLiteralPositiveInteger2._();
}

/* -------------------------------------------------------------------------- */
/*                The NullFailure annotation is used correctly                */
/* -------------------------------------------------------------------------- */

/* ----- The number of NullFailure annotations of a parameter is correct ---- */

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresSingleValueObject1 extends SingleValueObject {
  TooManyNullFailuresSingleValueObject1._();

  factory TooManyNullFailuresSingleValueObject1({
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AnotherFailure())
    required AClass param,
  }) =>
      TooManyNullFailuresSingleValueObject1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresSingleValueObject2 extends SingleValueObject {
  TooManyNullFailuresSingleValueObject2._();

  factory TooManyNullFailuresSingleValueObject2.named({
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AnotherFailure())
    @NullFailure('validation3', LengthFailure())
    required AClass param,
  }) =>
      TooManyNullFailuresSingleValueObject2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresMultiValueObject1 extends MultiValueObject {
  TooManyNullFailuresMultiValueObject1._();

  factory TooManyNullFailuresMultiValueObject1.named(
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AFailure())
    AClass param,
  ) =>
      TooManyNullFailuresMultiValueObject1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresMultiValueObject2 extends MultiValueObject {
  TooManyNullFailuresMultiValueObject2._();

  factory TooManyNullFailuresMultiValueObject2(
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AFailure())
    @NullFailure('validation3', AnotherFailure())
    AClass param,
  ) =>
      TooManyNullFailuresMultiValueObject2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param1"\n',
  element: 'param1',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresSimpleEntity1 extends SimpleEntity {
  TooManyNullFailuresSimpleEntity1._();

  factory TooManyNullFailuresSimpleEntity1.named({
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AFailure())
    required AClass param1,
    AClass? param2,
  }) =>
      TooManyNullFailuresSimpleEntity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresSimpleEntity2 extends SimpleEntity {
  TooManyNullFailuresSimpleEntity2._();

  factory TooManyNullFailuresSimpleEntity2(
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AnotherFailure())
    @NullFailure('validation3', LengthFailure())
    AClass param,
  ) =>
      TooManyNullFailuresSimpleEntity2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresIterableEntity1 extends ListEntity {
  TooManyNullFailuresIterableEntity1._();

  factory TooManyNullFailuresIterableEntity1(
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AFailure())
    List<AClass> param,
  ) =>
      TooManyNullFailuresIterableEntity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 1 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresIterableEntity2 extends ListEntity {
  TooManyNullFailuresIterableEntity2._();

  factory TooManyNullFailuresIterableEntity2.named(
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AnotherFailure())
    @NullFailure('validation3', LengthFailure())
    List<AClass> param,
  ) =>
      TooManyNullFailuresIterableEntity2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 2 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresIterable2Entity1 extends MapEntity {
  TooManyNullFailuresIterable2Entity1._();

  factory TooManyNullFailuresIterable2Entity1.named({
    @NullFailure('validation1', AFailure())
    @NullFailure('validation2', AFailure(), maskNb: 1)
    @NullFailure('validation3', AFailure(), maskNb: 2)
    required Map<AClass, AClass?> param,
  }) =>
      TooManyNullFailuresIterable2Entity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The parameter can be annotated with a maximum '
  'of 2 "@NullFailure" annotation(s).\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class TooManyNullFailuresIterable2Entity2 extends MapEntity {
  TooManyNullFailuresIterable2Entity2._();

  factory TooManyNullFailuresIterable2Entity2({
    @NullFailure('validation1', AFailure(), maskNb: 2)
    @NullFailure('validation2', AFailure())
    @NullFailure('validation3', AnotherFailure())
    @NullFailure('validation4', LengthFailure())
    required Map<AClass?, AClass> param,
  }) =>
      TooManyNullFailuresIterable2Entity2._();
}

/* -------------- The maskNb is reserved for Iterable2Entities -------------- */

@ShouldThrow(
  'UnresolvedParametersException: The maskNb is reserved for Iterable2Entities, '
  'and should not be provided.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MaskNbInSingleValueObject extends SingleValueObject {
  MaskNbInSingleValueObject._();

  factory MaskNbInSingleValueObject(
    @NullFailure('validation1', AFailure(), maskNb: 1) AClass? param,
  ) =>
      MaskNbInSingleValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The maskNb is reserved for Iterable2Entities, '
  'and should not be provided.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MaskNbInMultiValueObject extends MultiValueObject {
  MaskNbInMultiValueObject._();

  factory MaskNbInMultiValueObject.named({
    @NullFailure('validation1', AFailure(), maskNb: 2) required AClass param,
  }) =>
      MaskNbInMultiValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The maskNb is reserved for Iterable2Entities, '
  'and should not be provided.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MaskNbInSimpleEntity extends SimpleEntity {
  MaskNbInSimpleEntity._();

  factory MaskNbInSimpleEntity({
    @NullFailure('validation1', AFailure(), maskNb: 3) AClass? param,
  }) =>
      MaskNbInSimpleEntity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The maskNb is not needed for IterableEntities, '
  'and should not be provided.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MaskNbInIterableEntity1 extends ListEntity {
  MaskNbInIterableEntity1._();

  factory MaskNbInIterableEntity1(
    @NullFailure('validation1', AFailure(), maskNb: 1) List<AClass> param,
  ) =>
      MaskNbInIterableEntity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The maskNb is not needed for IterableEntities, '
  'and should not be provided.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class MaskNbInIterableEntity2 extends ListEntity {
  MaskNbInIterableEntity2._();

  factory MaskNbInIterableEntity2.named({
    @NullFailure('validation1', AFailure(), maskNb: 2)
    required List<AClass?> param,
  }) =>
      MaskNbInIterableEntity2._();
}

/* ----------- The maskNb should be provided for Iterable2Entities ---------- */

@ShouldThrow(
  'UnresolvedParametersException: The maskNb of the @NullFailure annotation(s) '
  'should be provided.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NoMaskNbInIterable2Entity1 extends MapEntity {
  NoMaskNbInIterable2Entity1._();

  factory NoMaskNbInIterable2Entity1(
    @NullFailure('validation1', AFailure()) Map<AClass?, AClass> param,
  ) =>
      NoMaskNbInIterable2Entity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The maskNb of the @NullFailure annotation(s) '
  'should be provided.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NoMaskNbInIterable2Entity2 extends MapEntity {
  NoMaskNbInIterable2Entity2._();

  factory NoMaskNbInIterable2Entity2(
    @NullFailure('validation1', AFailure(), maskNb: 2)
    @NullFailure('validation2', AFailure())
    Map<AClass, AClass> param,
  ) =>
      NoMaskNbInIterable2Entity2._();
}

/* ------- The maskNb provided for Iterable2Entities should be correct ------ */

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotations can\'t have the '
  'same maskNb.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class SameMaskNb1 extends MapEntity {
  SameMaskNb1._();

  factory SameMaskNb1(
    @NullFailure('validation1', AFailure(), maskNb: 1)
    @NullFailure('validation2', AFailure(), maskNb: 1)
    Map<AClass?, AClass?> param,
  ) =>
      SameMaskNb1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotations can\'t have the '
  'same maskNb.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class SameMaskNb2 extends MapEntity {
  SameMaskNb2._();

  factory SameMaskNb2.named({
    @NullFailure('validation1', AFailure(), maskNb: 2)
    @NullFailure('validation2', AFailure(), maskNb: 2)
    required Map<AClass, AClass> param,
  }) =>
      SameMaskNb2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The maskNb of the @NullFailure annotation(s) '
  'should be one of [1,2].\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class IncorrectMaskNb1 extends MapEntity {
  IncorrectMaskNb1._();

  factory IncorrectMaskNb1(
    @NullFailure('validation1', AFailure(), maskNb: 3)
    @NullFailure('validation2', AFailure(), maskNb: 5)
    Map<AClass?, AClass?> param,
  ) =>
      IncorrectMaskNb1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The maskNb of the @NullFailure annotation(s) '
  'should be one of [1,2].\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class IncorrectMaskNb2 extends MapEntity {
  IncorrectMaskNb2._();

  factory IncorrectMaskNb2.named(
    @NullFailure('validation1', AFailure(), maskNb: 1)
    @NullFailure('validation2', AFailure(), maskNb: 0)
    Map<AClass?, AClass?> param,
  ) =>
      IncorrectMaskNb2._();
}

/* ------- The parameter annotated with @NullFailure must be nullable. ------ */

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable parameters.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureSingleValueObject extends SingleValueObject {
  NonNullableNullFailureSingleValueObject._();

  factory NonNullableNullFailureSingleValueObject(
    @NullFailure('validation1', AFailure()) AClass param,
  ) =>
      NonNullableNullFailureSingleValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable parameters.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureMultiValueObject extends MultiValueObject {
  NonNullableNullFailureMultiValueObject._();

  factory NonNullableNullFailureMultiValueObject.named({
    @NullFailure('validation1', AFailure()) required AClass param,
  }) =>
      NonNullableNullFailureMultiValueObject._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable parameters.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureSimpleEntity extends SimpleEntity {
  NonNullableNullFailureSimpleEntity._();

  factory NonNullableNullFailureSimpleEntity({
    @NullFailure('validation1', AFailure()) required AClass param,
  }) =>
      NonNullableNullFailureSimpleEntity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable modddels, but the type of the modddel matching the mask (#1) '
  'is not nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureIterableEntity extends ListEntity {
  NonNullableNullFailureIterableEntity._();

  factory NonNullableNullFailureIterableEntity.named(
    @NullFailure('validation1', AFailure()) List<AClass> param,
  ) =>
      NonNullableNullFailureIterableEntity._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable modddels, but the type of the modddel matching the mask (#1) '
  'is not nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureIterable2Entity1 extends MapEntity {
  NonNullableNullFailureIterable2Entity1._();

  factory NonNullableNullFailureIterable2Entity1.named(
    @NullFailure('validation1', AFailure(), maskNb: 1)
    Map<AClass, AClass?> param,
  ) =>
      NonNullableNullFailureIterable2Entity1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable modddels, but the type of the modddel matching the mask (#2) '
  'is not nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureIterable2Entity2 extends MapEntity {
  NonNullableNullFailureIterable2Entity2._();

  factory NonNullableNullFailureIterable2Entity2({
    @NullFailure('validation1', AFailure(), maskNb: 2)
    required Map<AClass?, AClass> param,
  }) =>
      NonNullableNullFailureIterable2Entity2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable modddels, but the type of the modddel matching the mask (#2) '
  'is not nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureIterable2Entity3 extends MapEntity {
  NonNullableNullFailureIterable2Entity3._();

  factory NonNullableNullFailureIterable2Entity3({
    @NullFailure('validation1', AFailure(), maskNb: 2)
    required Map<AClass, AClass> param,
  }) =>
      NonNullableNullFailureIterable2Entity3._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable modddels, but the type of the modddel matching the mask (#2) '
  'is not nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureIterable2Entity4 extends MapEntity {
  NonNullableNullFailureIterable2Entity4._();

  factory NonNullableNullFailureIterable2Entity4({
    @NullFailure('validation1', AFailure(), maskNb: 1)
    @NullFailure('validation2', AFailure(), maskNb: 2)
    required Map<AClass?, AClass> param,
  }) =>
      NonNullableNullFailureIterable2Entity4._();
}

@ShouldThrow(
  'UnresolvedParametersException: The @NullFailure annotation can only be used '
  'with nullable modddels, but the type of the modddel matching the mask (#1) '
  'is not nullable.\n'
  'Failed Parameter : "param"\n',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class NonNullableNullFailureIterable2Entity5 extends MapEntity {
  NonNullableNullFailureIterable2Entity5._();

  factory NonNullableNullFailureIterable2Entity5({
    @NullFailure('validation1', AFailure(), maskNb: 1)
    @NullFailure('validation2', AFailure(), maskNb: 2)
    required Map<AClass, AClass> param,
  }) =>
      NonNullableNullFailureIterable2Entity5._();
}
