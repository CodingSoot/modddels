import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:checks/checks.dart';
import 'package:collection/collection.dart';

import '../../integration_test_utils/integration_test_utils.dart';
import '../_common.dart';
import 'parameters_metadata.dart';

// Modddels groups : SSealed modddels that have :
//
// - A. Solo modddels that have :
//   - A1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters
//   - A2 : Member parameters with the `@withGetter` annotation
// - B. SSealed modddels that have :
//   - B1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters
//     - B1a : The parameters are not shared
//     - B1b : The parameters are shared
//   - B2 : Member parameters with the `@withGetter` annotation
//     - B2a : The parameters are not shared
//     - B2b : The parameters are shared
//

/* -------------------------------------------------------------------------- */
/*                   TestSupports and Helpers for each group                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

class ParametersSoloTestSupport extends ModddelsTestSupport<
    ParametersSoloTestHelper,
    WithoutGetterParams,
    NoSampleOptions,
    ParametersSoloSVO,
    ParametersSoloMVO,
    ParametersSoloSE,
    ParametersSoloIE,
    ParametersSoloI2E> {
  ParametersSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      ParametersSoloTestHelper(testSubject, sampleOptions, sampleParams);

  @override
  ParametersSoloSVO makeSingleValueObject(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSoloSVO(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSoloMVO makeMultiValueObject(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSoloMVO(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSoloSE makeSimpleEntity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSoloSE(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSoloIE makeIterableEntity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSoloIE(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSoloI2E makeIterable2Entity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSoloI2E(
        param: params.param.value,
        dependency: params.dependency.value,
      );
}

class ParametersSoloTestHelper extends ModddelTestHelper<
    WithoutGetterParams,
    NoSampleOptions,
    ParametersSoloSVO,
    ParametersSoloMVO,
    ParametersSoloSE,
    ParametersSoloIE,
    ParametersSoloI2E> with TestHelperMixin, ElementsSoloTestHelperMixin {
  ParametersSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName {
    return testSubject.whenAll(
      singleValueObject: (_) => 'ParametersSoloSVO',
      multiValueObject: (_) => 'ParametersSoloMVO',
      simpleEntity: (_) => 'ParametersSoloSE',
      iterableEntity: (_) => 'ParametersSoloIE',
      iterable2Entity: (_) => 'ParametersSoloI2E',
    );
  }

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);
}

/* ----------------------------------- A2 ----------------------------------- */

class WithGetterParametersSoloTestSupport extends ModddelsTestSupport<
    WithGetterParametersSoloTestHelper,
    WithGetterParams,
    NoSampleOptions,
    WithGetterParametersSoloSVO,
    WithGetterParametersSoloMVO,
    WithGetterParametersSoloSE,
    WithGetterParametersSoloIE,
    WithGetterParametersSoloI2E> {
  WithGetterParametersSoloTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      WithGetterParametersSoloTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  WithGetterParametersSoloSVO makeSingleValueObject(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSoloSVO(param: params.param.value);

  @override
  WithGetterParametersSoloMVO makeMultiValueObject(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSoloMVO(param: params.param.value);

  @override
  WithGetterParametersSoloSE makeSimpleEntity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSoloSE(param: params.param.value);

  @override
  WithGetterParametersSoloIE makeIterableEntity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSoloIE(param: params.param.value);

  @override
  WithGetterParametersSoloI2E makeIterable2Entity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSoloI2E(param: params.param.value);
}

class WithGetterParametersSoloTestHelper extends ModddelTestHelper<
        WithGetterParams,
        NoSampleOptions,
        WithGetterParametersSoloSVO,
        WithGetterParametersSoloMVO,
        WithGetterParametersSoloSE,
        WithGetterParametersSoloIE,
        WithGetterParametersSoloI2E>
    with TestHelperMixin, ElementsSoloTestHelperMixin {
  WithGetterParametersSoloTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get modddelName {
    return testSubject.whenAll(
      singleValueObject: (_) => 'WithGetterParametersSoloSVO',
      multiValueObject: (_) => 'WithGetterParametersSoloMVO',
      simpleEntity: (_) => 'WithGetterParametersSoloSE',
      iterableEntity: (_) => 'WithGetterParametersSoloIE',
      iterable2Entity: (_) => 'WithGetterParametersSoloI2E',
    );
  }

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);
}

/* ----------------------------------- B1a ---------------------------------- */

class ParametersNonSharedSSealedTestSupport extends ModddelsTestSupport<
    ParametersNonSharedSSealedTestHelper,
    WithoutGetterParams,
    NoSampleOptions,
    ParametersNonSharedSSealedSVO,
    ParametersNonSharedSSealedMVO,
    ParametersNonSharedSSealedSE,
    ParametersNonSharedSSealedIE,
    ParametersNonSharedSSealedI2E> {
  ParametersNonSharedSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      ParametersNonSharedSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  ParametersNonSharedSSealedSVO makeSingleValueObject(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersNonSharedSSealedSVO.namedParametersNonSharedSSealedSVO(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersNonSharedSSealedMVO makeMultiValueObject(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersNonSharedSSealedMVO.namedParametersNonSharedSSealedMVO(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersNonSharedSSealedSE makeSimpleEntity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersNonSharedSSealedSE.namedParametersNonSharedSSealedSE(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersNonSharedSSealedIE makeIterableEntity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersNonSharedSSealedIE.namedParametersNonSharedSSealedIE(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersNonSharedSSealedI2E makeIterable2Entity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersNonSharedSSealedI2E.namedParametersNonSharedSSealedI2E(
        param: params.param.value,
        dependency: params.dependency.value,
      );
}

class ParametersNonSharedSSealedTestHelper extends ModddelTestHelper<
        WithoutGetterParams,
        NoSampleOptions,
        ParametersNonSharedSSealedSVO,
        ParametersNonSharedSSealedMVO,
        ParametersNonSharedSSealedSE,
        ParametersNonSharedSSealedIE,
        ParametersNonSharedSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin {
  ParametersNonSharedSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);

  @override
  String get sSealedName {
    return testSubject.whenAll(
      singleValueObject: (_) => 'ParametersNonSharedSSealedSVO',
      multiValueObject: (_) => 'ParametersNonSharedSSealedMVO',
      simpleEntity: (_) => 'ParametersNonSharedSSealedSE',
      iterableEntity: (_) => 'ParametersNonSharedSSealedIE',
      iterable2Entity: (_) => 'ParametersNonSharedSSealedI2E',
    );
  }

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);
}

/* ----------------------------------- B1b ---------------------------------- */

class ParametersSharedSSealedTestSupport extends ModddelsTestSupport<
    ParametersSharedSSealedTestHelper,
    WithoutGetterParams,
    NoSampleOptions,
    ParametersSharedSSealedSVO,
    ParametersSharedSSealedMVO,
    ParametersSharedSSealedSE,
    ParametersSharedSSealedIE,
    ParametersSharedSSealedI2E> {
  ParametersSharedSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      ParametersSharedSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);
  @override
  ParametersSharedSSealedSVO makeSingleValueObject(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSharedSSealedSVO.namedParametersSharedSSealedSVO(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSharedSSealedMVO makeMultiValueObject(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSharedSSealedMVO.namedParametersSharedSSealedMVO(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSharedSSealedSE makeSimpleEntity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSharedSSealedSE.namedParametersSharedSSealedSE(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSharedSSealedIE makeIterableEntity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSharedSSealedIE.namedParametersSharedSSealedIE(
        param: params.param.value,
        dependency: params.dependency.value,
      );

  @override
  ParametersSharedSSealedI2E makeIterable2Entity(
          WithoutGetterParams params, NoSampleOptions sampleOptions) =>
      ParametersSharedSSealedI2E.namedParametersSharedSSealedI2E(
        param: params.param.value,
        dependency: params.dependency.value,
      );
}

class ParametersSharedSSealedTestHelper extends ModddelTestHelper<
        WithoutGetterParams,
        NoSampleOptions,
        ParametersSharedSSealedSVO,
        ParametersSharedSSealedMVO,
        ParametersSharedSSealedSE,
        ParametersSharedSSealedIE,
        ParametersSharedSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin {
  ParametersSharedSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);
  @override
  String get sSealedName {
    return testSubject.whenAll(
      singleValueObject: (_) => 'ParametersSharedSSealedSVO',
      multiValueObject: (_) => 'ParametersSharedSSealedMVO',
      simpleEntity: (_) => 'ParametersSharedSSealedSE',
      iterableEntity: (_) => 'ParametersSharedSSealedIE',
      iterable2Entity: (_) => 'ParametersSharedSSealedI2E',
    );
  }

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);
}

/* ----------------------------------- B2a ---------------------------------- */

class WithGetterParametersNonSharedSSealedTestSupport
    extends ModddelsTestSupport<
        WithGetterParametersNonSharedSSealedTestHelper,
        WithGetterParams,
        NoSampleOptions,
        WithGetterParametersNonSharedSSealedSVO,
        WithGetterParametersNonSharedSSealedMVO,
        WithGetterParametersNonSharedSSealedSE,
        WithGetterParametersNonSharedSSealedIE,
        WithGetterParametersNonSharedSSealedI2E> {
  WithGetterParametersNonSharedSSealedTestSupport({required super.samples});

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      WithGetterParametersNonSharedSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);

  @override
  WithGetterParametersNonSharedSSealedSVO makeSingleValueObject(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersNonSharedSSealedSVO
          .namedWithGetterParametersNonSharedSSealedSVO(
              param: params.param.value);

  @override
  WithGetterParametersNonSharedSSealedMVO makeMultiValueObject(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersNonSharedSSealedMVO
          .namedWithGetterParametersNonSharedSSealedMVO(
              param: params.param.value);

  @override
  WithGetterParametersNonSharedSSealedSE makeSimpleEntity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersNonSharedSSealedSE
          .namedWithGetterParametersNonSharedSSealedSE(
              param: params.param.value);

  @override
  WithGetterParametersNonSharedSSealedIE makeIterableEntity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersNonSharedSSealedIE
          .namedWithGetterParametersNonSharedSSealedIE(
              param: params.param.value);

  @override
  WithGetterParametersNonSharedSSealedI2E makeIterable2Entity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersNonSharedSSealedI2E
          .namedWithGetterParametersNonSharedSSealedI2E(
              param: params.param.value);
}

class WithGetterParametersNonSharedSSealedTestHelper extends ModddelTestHelper<
        WithGetterParams,
        NoSampleOptions,
        WithGetterParametersNonSharedSSealedSVO,
        WithGetterParametersNonSharedSSealedMVO,
        WithGetterParametersNonSharedSSealedSE,
        WithGetterParametersNonSharedSSealedIE,
        WithGetterParametersNonSharedSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin {
  WithGetterParametersNonSharedSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);
  @override
  String get sSealedName {
    return testSubject.whenAll(
      singleValueObject: (_) => 'WithGetterParametersNonSharedSSealedSVO',
      multiValueObject: (_) => 'WithGetterParametersNonSharedSSealedMVO',
      simpleEntity: (_) => 'WithGetterParametersNonSharedSSealedSE',
      iterableEntity: (_) => 'WithGetterParametersNonSharedSSealedIE',
      iterable2Entity: (_) => 'WithGetterParametersNonSharedSSealedI2E',
    );
  }

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);
}

/* ----------------------------------- B2b ---------------------------------- */

class WithGetterParametersSharedSSealedTestSupport extends ModddelsTestSupport<
    WithGetterParametersSharedSSealedTestHelper,
    WithGetterParams,
    NoSampleOptions,
    WithGetterParametersSharedSSealedSVO,
    WithGetterParametersSharedSSealedMVO,
    WithGetterParametersSharedSSealedSE,
    WithGetterParametersSharedSSealedIE,
    WithGetterParametersSharedSSealedI2E> {
  WithGetterParametersSharedSSealedTestSupport({required super.samples});

  @override
  WithGetterParametersSharedSSealedSVO makeSingleValueObject(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSharedSSealedSVO
          .namedWithGetterParametersSharedSSealedSVO(param: params.param.value);

  @override
  WithGetterParametersSharedSSealedMVO makeMultiValueObject(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSharedSSealedMVO
          .namedWithGetterParametersSharedSSealedMVO(param: params.param.value);

  @override
  WithGetterParametersSharedSSealedSE makeSimpleEntity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSharedSSealedSE
          .namedWithGetterParametersSharedSSealedSE(param: params.param.value);

  @override
  WithGetterParametersSharedSSealedIE makeIterableEntity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSharedSSealedIE
          .namedWithGetterParametersSharedSSealedIE(param: params.param.value);

  @override
  WithGetterParametersSharedSSealedI2E makeIterable2Entity(
          WithGetterParams params, NoSampleOptions sampleOptions) =>
      WithGetterParametersSharedSSealedI2E
          .namedWithGetterParametersSharedSSealedI2E(param: params.param.value);

  @override
  getTestHelper(testSubject, sampleOptions, sampleParams) =>
      WithGetterParametersSharedSSealedTestHelper(
          testSubject, sampleOptions, sampleParams);
}

class WithGetterParametersSharedSSealedTestHelper extends ModddelTestHelper<
        WithGetterParams,
        NoSampleOptions,
        WithGetterParametersSharedSSealedSVO,
        WithGetterParametersSharedSSealedMVO,
        WithGetterParametersSharedSSealedSE,
        WithGetterParametersSharedSSealedIE,
        WithGetterParametersSharedSSealedI2E>
    with
        TestHelperMixin,
        ElementsSSealedTestHelperMixin,
        SSealedTestHelperMixin {
  WithGetterParametersSharedSSealedTestHelper(
      super.testSubject, super.sampleOptions, super.sampleParams);
  @override
  String get sSealedName {
    return testSubject.whenAll(
      singleValueObject: (_) => 'WithGetterParametersSharedSSealedSVO',
      multiValueObject: (_) => 'WithGetterParametersSharedSSealedMVO',
      simpleEntity: (_) => 'WithGetterParametersSharedSSealedSE',
      iterableEntity: (_) => 'WithGetterParametersSharedSSealedIE',
      iterable2Entity: (_) => 'WithGetterParametersSharedSSealedI2E',
    );
  }

  @override
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);
}

/* -------------------------------------------------------------------------- */
/*                          Common TestHelper Mixins                          */
/* -------------------------------------------------------------------------- */

mixin TestHelperMixin<P extends SampleParamsBase, O extends SampleOptionsBase>
    on TestHelperBase<P, O> {
  /// Overrides [ElementsSoloTestHelperMixin.vStepsNames] /
  /// [ElementsSSealedTestHelperMixin.vStepsNames].
  ///
  List<String> get vStepsNames =>
      testSubject.map(valueObject: (_) => ['Value'], entity: (_) => ['Mid']);

  /// See [ElementsSoloTestHelperMixin.getTopLevelMixin] /
  /// [ElementsSSealedTestHelperMixin.getTopLevelMixin].
  ///
  MixinElement getTopLevelMixin(LibraryElement library);

  /// Returns the return type of the top-level mixin's `copyWith` getter.
  ///
  FunctionType getTopLevelCopyWithReturnType(LibraryElement library) {
    final topLevelMixin = getTopLevelMixin(library);

    return topLevelMixin.accessors
        .firstWhere((element) => element.name == 'copyWith')
        .returnType as FunctionType;
  }

  /// Checks that the [element] has no documentation.
  ///
  void checkElementHasNoDocs(Element? element) {
    check(element)
        .isNotNull()
        .has((element) => element.documentationComment, 'doc')
        .isNull();
  }

  /// Checks that the [element] has documentation that equals [documentation].
  ///
  void checkElementHasDocs(Element? element, String documentation) {
    check(element)
        .isNotNull()
        .has((element) => element.documentationComment, 'doc')
        .equals(documentation);
  }

  /// Checks that the [element] has no decorators.
  ///
  void checkElementHasNoDecorators(Element? element) {
    check(element).isNotNull();

    final decorators = element!.metadata.where((e) => !e.isOverride).toList();

    check(decorators).isEmpty();
  }

  /// Checks that the [element] has a [Deprecated] annotation, which
  /// [Deprecated.message] equals [deprecationMessage].
  ///
  void checkElementHasDeprecatedAnnotation(
      Element? element, String deprecationMessage) {
    check(element).isNotNull();

    final decorators = element!.metadata.where((e) => !e.isOverride).toList();

    check(decorators)
        .single
        .has((decorator) => decorator.computeConstantValue(), 'constantValue')
      ..has((constantValue) => constantValue?.type?.element?.name, 'type name')
          .equals('Deprecated')
      ..has(
              (constantValue) =>
                  constantValue?.getField('message')?.toStringValue(),
              'deprecation message')
          .equals(deprecationMessage);
  }
}

mixin SSealedTestHelperMixin<P extends SampleParamsBase,
        O extends SampleOptionsBase>
    on TestHelperMixin<P, O>, ElementsSSealedTestHelperMixin<P, O> {
  @override
  String get caseModddelName => 'Named$sSealedName';

  /// Returns the return type of the case-modddel's `copyWith` getter.
  ///
  FunctionType getCaseModddelCopyWithReturnType(LibraryElement library) {
    final baseCaseModddelMixin = getBaseCaseModddelMixin(library);

    return baseCaseModddelMixin.accessors
        .firstWhere((element) => element.name == 'copyWith')
        .returnType as FunctionType;
  }

  /// The ssealed ModddelParams class has a factory constructor for each
  /// case-modddel. This function returns the factory constructor for the
  /// [testSubject]'s case-modddel.
  ///
  ConstructorElement getSSealedModddelParamsCaseModddelConstructor(
      LibraryElement library) {
    final ssealedModddelParamsClass = getSSealedModddelParamsClass(library);

    final factoryConstructorName = caseModddelName.uncapitalize();

    return ssealedModddelParamsClass.constructors.singleWhere(
        (constructor) => constructor.name == factoryConstructorName);
  }
}

/* -------------------------------------------------------------------------- */
/*                             Common SampleValues                            */
/* -------------------------------------------------------------------------- */

class WithoutGetterParams extends SampleParamsBase {
  WithoutGetterParams(this.param, this.dependency);

  final ParamWithSource param;
  final ParamWithSource dependency;
}

class WithGetterParams extends SampleParamsBase {
  WithGetterParams(this.param);

  final ParamWithSource param;
}

final withoutGetterSampleValues1 = ModddelSampleValues<WithoutGetterParams>(
  singleValueObject: WithoutGetterParams(
    SampleValues1.paramString,
    SampleValues1.dependency,
  ),
  multiValueObject: WithoutGetterParams(
    SampleValues1.paramString,
    SampleValues1.dependency,
  ),
  simpleEntity: WithoutGetterParams(
    SampleValues1.paramModddel,
    SampleValues1.dependency,
  ),
  iterableEntity: WithoutGetterParams(
    SampleValues1.paramListModddel,
    SampleValues1.dependency,
  ),
  iterable2Entity: WithoutGetterParams(
    SampleValues1.paramMapModddel,
    SampleValues1.dependency,
  ),
);

final withGetterSampleValues1 = ModddelSampleValues<WithGetterParams>(
  singleValueObject: WithGetterParams(SampleValues1.paramString),
  multiValueObject: WithGetterParams(SampleValues1.paramString),
  simpleEntity: WithGetterParams(SampleValues1.paramModddel),
  iterableEntity: WithGetterParams(SampleValues1.paramListModddel),
  iterable2Entity: WithGetterParams(SampleValues1.paramMapModddel),
);

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

extension GetElementFromConstructorOrMethod on FunctionTypedElement {
  /// Returns the [ParameterElement] with the specified [name] from the
  /// [FunctionTypedElement], which can be for example a [ConstructorElement] or
  /// a [MethodElement].
  ///
  /// If no parameter with the given name is found, returns null.
  ///
  ParameterElement? getParameter(String name) {
    return parameters.firstWhereOrNull((element) => element.name == name);
  }
}

extension GetElementFromFunctionType on FunctionType {
  /// Returns the [ParameterElement] with the specified [name] from the
  /// [FunctionType].
  ///
  /// If no parameter with the given name is found, returns null.
  ///
  ParameterElement? getParameter(String name) {
    return parameters.firstWhereOrNull((element) => element.name == name);
  }
}
