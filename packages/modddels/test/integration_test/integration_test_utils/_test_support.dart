import 'package:collection/collection.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '_test_helper.dart';
import '_test_subject.dart';
import '_test_sample.dart';

/// Holds the information needed to create a [TestSubject] and its associated
/// [sampleParams] for running the tests.
///
class _TestInfo<TS extends TestSubject, P extends SampleParamsBase> {
  _TestInfo(this.modddelKind,
      {required this.createTestSubject, required this.sampleParams});

  final String modddelKind;

  final TS Function() createTestSubject;

  final P sampleParams;
}

/// The base class for providing support for running tests on multiple modddels
/// at once.
///
/// If you want to make tests for :
///
/// - The five modddel kinds : Extend [ModddelsTestSupport]
/// - The two ValueObject kinds : Extend [ValueObjectsTestSupport]
/// - The three Entity kinds : Extend [EntitiesTestSupport]
///
abstract class TestSupportBase<H extends TestHelperBase<P, O>,
    P extends SampleParamsBase, O extends SampleOptionsBase> {
  /// A map representing the different test samples.
  ///
  /// A test sample is a combination of SampleValues (which are the values used
  /// to instantiate the modddels, see [ModddelSampleValues]) and sample options
  /// (used to customize the created modddels, see [SampleOptionsBase]).
  ///
  Map<O, SampleValuesBase<P>> get samples;

  List<_TestInfo<TestSubject, P>> _getTestsInfos(
      covariant SampleValuesBase<P> sampleValues, O sampleOptions);

  H getTestHelper(
      covariant TestSubject testSubject, O sampleOptions, P sampleParams);

  /// Runs tests for a specific sample, identified by its [sampleName]. The
  /// tests are defined by the [body] function, which has a callback
  /// `createTestHelper`. Calling the callback creates the modddel (the
  /// testSubject) and wraps it into the TestHelper that it returns.
  ///
  /// Example :
  ///
  /// ```dart
  /// final myTestSupport = MyTestSupport(samples: {
  ///   MySampleOptions(
  ///     'Example 1',
  ///     lengthValidationPasses: true,
  ///   ): mySampleValues1,
  ///   MySampleOptions(
  ///     'Example 2',
  ///     lengthValidationPasses: false,
  ///   ): mySampleValues2,
  /// });
  ///
  /// myTestSupport.runTestsForSample('Example 2', (createTestHelper) {
  ///   final testHelper = createTestHelper();
  ///
  ///   /// ...
  /// });
  /// ```
  ///
  void runTestsForSample(
    String sampleName,
    dynamic Function(H Function() createTestHelper) body, {
    String? testOn,
    Timeout? timeout,
    skip,
    tags,
    Map<String, dynamic>? onPlatform,
    int? retry,
  }) {
    runTestsForSampleWithExtraParams(
      sampleName,
      (createTestHelper, sampleOptions, sampleParams) => body(createTestHelper),
      testOn: testOn,
      timeout: timeout,
      skip: skip,
      tags: tags,
      onPlatform: onPlatform,
      retry: retry,
    );
  }

  /// Same as [runTestsForSample], but the [body] callback has extra parameters.
  ///
  /// Useful when calling the `createTestHelper` callback throws an error, and
  /// thus you can't create the test helper and access the SampleOptions or
  /// SampleParams from it.
  ///
  void runTestsForSampleWithExtraParams(
    String sampleName,
    dynamic Function(
            H Function() createTestHelper, O sampleOptions, P sampleParams)
        body, {
    String? testOn,
    Timeout? timeout,
    skip,
    tags,
    Map<String, dynamic>? onPlatform,
    int? retry,
  }) {
    final entry = samples.entries
        .singleWhereOrNull((element) => element.key.name == sampleName);

    if (entry == null) {
      throw ArgumentError(
          'There should be a single sample named "$sampleName"');
    }

    final sampleOptions = entry.key;

    final sampleValues = entry.value;

    final testSubjectInfos = _getTestsInfos(sampleValues, sampleOptions);

    for (final testSubjectInfo in testSubjectInfos) {
      final modddelKind = testSubjectInfo.modddelKind;
      final createTestSubject = testSubjectInfo.createTestSubject;
      final sampleParams = testSubjectInfo.sampleParams;

      test(
        '($modddelKind - ${sampleOptions.name})\n',
        () => body(
            () =>
                getTestHelper(createTestSubject(), sampleOptions, sampleParams),
            sampleOptions,
            sampleParams),
        testOn: testOn,
        timeout: timeout,
        skip: skip,
        tags: tags,
        onPlatform: onPlatform,
        retry: retry,
      );
    }
  }

  /// Runs tests for all the samples defined in the [samples] map. The tests are
  /// defined by the [body] function, which has a callback `createTestHelper`.
  /// Calling the callback creates the modddel (the testSubject) and wraps it
  /// into the TestHelper that it returns.
  ///
  /// Example :
  ///
  /// ```dart
  /// final myTestSupport = MyTestSupport(samples: {
  ///   MySampleOptions(
  ///     'Example 1',
  ///     lengthValidationPasses: true,
  ///   ): mySampleValues1,
  ///   MySampleOptions(
  ///     'Example 2',
  ///     lengthValidationPasses: false,
  ///   ): mySampleValues2,
  /// });
  ///
  /// myTestSupport.runTestsForAll((createTestHelper) {
  ///   final testHelper = createTestHelper();
  ///
  ///   /// ...
  /// });
  /// ```
  ///
  void runTestsForAll(
    dynamic Function(H Function() createTestHelper) body, {
    String? testOn,
    Timeout? timeout,
    skip,
    tags,
    Map<String, dynamic>? onPlatform,
    int? retry,
  }) {
    samples.forEach((sampleOptions, sampleValues) {
      runTestsForSample(
        sampleOptions.name,
        body,
        testOn: testOn,
        timeout: timeout,
        skip: skip,
        tags: tags,
        onPlatform: onPlatform,
        retry: retry,
      );
    });
  }

  /// Same as [runTestsForAll], but the [body] callback has extra parameters.
  ///
  /// Useful when calling the `createTestHelper` callback throws an error, and
  /// thus you can't create the test helper and access the SampleOptions or
  /// SampleParams from it.
  ///
  void runTestsForAllWithExtraParams(
    dynamic Function(
            H Function() createTestHelper, O sampleOptions, P sampleParams)
        body, {
    String? testOn,
    Timeout? timeout,
    skip,
    tags,
    Map<String, dynamic>? onPlatform,
    int? retry,
  }) {
    samples.forEach((sampleOptions, sampleValues) {
      runTestsForSampleWithExtraParams(
        sampleOptions.name,
        body,
        testOn: testOn,
        timeout: timeout,
        skip: skip,
        tags: tags,
        onPlatform: onPlatform,
        retry: retry,
      );
    });
  }
}

/// Provides support for running tests on five modddels (each one of a kind) at
/// once.
///
/// When creating the TestSupport, you provide it with a [samples] map. A test
/// sample is a combination of SampleValues (which are the values used to
/// instantiate the modddels, see [ModddelSampleValues]) and sample options
/// (used to customize the created modddels, see [SampleOptionsBase]). These
/// [samples] allow you to test the behavior of the modddels with different sets
/// of data and options, ensuring that they work correctly under various
/// conditions.
///
/// Example :
///
/// ```dart
/// final myTestSupport =
///     MyTestSupport(samples: {
///   MySampleOptions(
///     'First factory constructor',
///     usedFactoryConstructor: FactoryConstructor.first,
///     lengthValidationPasses: true,
///   ): sampleValues,
///   MySampleOptions(
///     'Second factory constructor',
///     usedFactoryConstructor: FactoryConstructor.second,
///     lengthValidationPasses: true,
///   ): sampleValues,
/// });
/// ```
///
/// The TestSupport provides methods to run tests for a single sample
/// ([runTestsForSample] and [runTestsForSampleWithExtraParams]), or for all
/// samples at once ([runTestsForAll] and [runTestsForAllWithExtraParams]).
///
/// Like for [ModddelTestHelper], this class should be extended to create a
/// custom test support class for your specific use case. Override
/// [getTestHelper] to return an instance of your TestHelper, and override the
/// "make" methods to return instances of your modddels based on the
/// SampleParams and SampleOptions.
///
/// Example :
///
/// ```dart
/// class MyTestSupport extends ModddelsTestSupport<
///     MyTestHelper, // TestHelper
///     MySampleParams, // SampleParams
///     MySampleOptions, // SampleOptions
///     MySVO, // SingleValueObject
///     MyMVO, // ...
///     MySE,
///     MyIE,
///     MyI2E> {
///   MyTestSupport({required super.samples});
///
///   @override
///   getTestHelper(testSubject, sampleOptions, sampleParams) =>
///       MyTestHelper(testSubject, sampleOptions, sampleParams);
///
///   @override
///   MySVO makeSingleValueObject(
///           MySampleParams params, MySampleOptions sampleOptions) =>
///       MySVO(
///           param: params.param.value,
///           $lengthValidationPasses: sampleOptions.lengthValidationPasses);
///
///   // ... makeMultiValueObject, makeSimpleEntity, makeIterableEntity and
///   // makeIterable2Entity
/// }
/// ```
///
abstract class ModddelsTestSupport<
    H extends ModddelTestHelper<P, O, SVO, MVO, SE, IE, I2E>,
    P extends SampleParamsBase,
    O extends SampleOptionsBase,
    SVO extends SingleValueObject,
    MVO extends MultiValueObject,
    SE extends SimpleEntity,
    IE extends IterableEntity,
    I2E extends Iterable2Entity> extends TestSupportBase<H, P, O> {
  ModddelsTestSupport({required this.samples});

  @override
  final Map<O, ModddelSampleValues<P>> samples;

  @override
  List<_TestInfo<TestSubject<SVO, MVO, SE, IE, I2E>, P>> _getTestsInfos(
          ModddelSampleValues<P> sampleValues, O sampleOptions) =>
      [
        _TestInfo(
          'SingleValueObject',
          createTestSubject: () => TestSubject.valueObject(
              ValueObjectTS.singleValueObject(makeSingleValueObject(
                  sampleValues.singleValueObject, sampleOptions))),
          sampleParams: sampleValues.singleValueObject,
        ),
        _TestInfo(
          'MultiValueObject',
          createTestSubject: () => TestSubject.valueObject(
              ValueObjectTS.multiValueObject(makeMultiValueObject(
                  sampleValues.multiValueObject, sampleOptions))),
          sampleParams: sampleValues.multiValueObject,
        ),
        _TestInfo(
          'SimpleEntity',
          createTestSubject: () => TestSubject.entity(EntityTS.simpleEntity(
              makeSimpleEntity(sampleValues.simpleEntity, sampleOptions))),
          sampleParams: sampleValues.simpleEntity,
        ),
        _TestInfo(
          'IterableEntity',
          createTestSubject: () => TestSubject.entity(EntityTS.iterableEntity(
              makeIterableEntity(sampleValues.iterableEntity, sampleOptions))),
          sampleParams: sampleValues.iterableEntity,
        ),
        _TestInfo(
          'Iterable2Entity',
          createTestSubject: () => TestSubject.entity(EntityTS.iterable2Entity(
              makeIterable2Entity(
                  sampleValues.iterable2Entity, sampleOptions))),
          sampleParams: sampleValues.iterable2Entity,
        ),
      ];

  @override
  H getTestHelper(TestSubject<SVO, MVO, SE, IE, I2E> testSubject,
      O sampleOptions, P sampleParams);

  SVO makeSingleValueObject(P params, O sampleOptions);

  MVO makeMultiValueObject(P params, O sampleOptions);

  SE makeSimpleEntity(P params, O sampleOptions);

  IE makeIterableEntity(P params, O sampleOptions);

  I2E makeIterable2Entity(P params, O sampleOptions);
}

/// Same as [ModddelsTestSupport], but for ValueObjects only.
///
/// Example :
///
/// ```dart
/// class MyTestSupport extends ValueObjectsTestSupport<
///     MyTestHelper, // TestHelper
///     MySampleParams, // SampleParams
///     MySampleOptions, // SampleOptions
///     MySVO, // SingleValueObject ...
///     MyMVO> {
///   MyTestSupport({required super.samples});
///
///   @override
///   getTestHelper(testSubject, sampleOptions, sampleParams) =>
///       MyTestHelper(testSubject, sampleOptions, sampleParams);
///
///   @override
///   MySVO makeSingleValueObject(
///           MySampleParams params, MySampleOptions sampleOptions) =>
///       MySVO(
///           param: params.param.value,
///           $lengthValidationPasses: sampleOptions.lengthValidationPasses);
///
///   // ... makeMultiValueObject
/// }
/// ```
///
abstract class ValueObjectsTestSupport<
    H extends ValueObjectTestHelper<P, O, SVO, MVO>,
    P extends SampleParamsBase,
    O extends SampleOptionsBase,
    SVO extends SingleValueObject,
    MVO extends MultiValueObject> extends TestSupportBase<H, P, O> {
  ValueObjectsTestSupport({required this.samples});

  @override
  final Map<O, ValueObjectSampleValues<P>> samples;

  @override
  List<
          _TestInfo<
              ValueObjectTestSubject<SVO, MVO, SimpleEntity, IterableEntity,
                  Iterable2Entity>,
              P>>
      _getTestsInfos(
              ValueObjectSampleValues<P> sampleValues, O sampleOptions) =>
          [
            _TestInfo(
              'SingleValueObject',
              createTestSubject: () => ValueObjectTestSubject(
                  ValueObjectTS.singleValueObject(makeSingleValueObject(
                      sampleValues.singleValueObject, sampleOptions))),
              sampleParams: sampleValues.singleValueObject,
            ),
            _TestInfo(
              'MultiValueObject',
              createTestSubject: () => ValueObjectTestSubject(
                  ValueObjectTS.multiValueObject(makeMultiValueObject(
                      sampleValues.multiValueObject, sampleOptions))),
              sampleParams: sampleValues.multiValueObject,
            ),
          ];

  @override
  H getTestHelper(
      ValueObjectTestSubject<SVO, MVO, SimpleEntity, IterableEntity,
              Iterable2Entity>
          testSubject,
      O sampleOptions,
      P sampleParams);

  SVO makeSingleValueObject(P params, O sampleOptions);

  MVO makeMultiValueObject(P params, O sampleOptions);
}

/// Same as [ModddelsTestSupport], but for Entities only.
///
/// Example :
///
/// ```dart
/// class MyTestSupport extends EntitiesTestSupport<
///     MyTestHelper, // TestHelper
///     MySampleParams, // SampleParams
///     MySampleOptions, // SampleOptions
///     MySE, // SimpleEntity
///     MyIE, // ...
///     MyI2E> {
///   MyTestSupport({required super.samples});
///
///   @override
///   getTestHelper(testSubject, sampleOptions, sampleParams) =>
///       MyTestHelper(testSubject, sampleOptions, sampleParams);
///
///   @override
///   MySE makeSimpleEntity(
///           MySampleParams params, MySampleOptions sampleOptions) =>
///       MySE(
///           param: params.param.value,
///           $lengthValidationPasses: sampleOptions.lengthValidationPasses);
///
///   // ... makeIterableEntity and makeIterable2Entity
/// }
/// ```
///
abstract class EntitiesTestSupport<
    H extends EntityTestHelper<P, O, SE, IE, I2E>,
    P extends SampleParamsBase,
    O extends SampleOptionsBase,
    SE extends SimpleEntity,
    IE extends IterableEntity,
    I2E extends Iterable2Entity> extends TestSupportBase<H, P, O> {
  EntitiesTestSupport({required this.samples});

  @override
  final Map<O, EntitySampleValues<P>> samples;

  @override
  List<
          _TestInfo<
              EntityTestSubject<SingleValueObject, MultiValueObject, SE, IE, I2E>,
              P>>
      _getTestsInfos(EntitySampleValues<P> sampleValues, O sampleOptions) => [
            _TestInfo(
              'SimpleEntity',
              createTestSubject: () => EntityTestSubject(EntityTS.simpleEntity(
                  makeSimpleEntity(sampleValues.simpleEntity, sampleOptions))),
              sampleParams: sampleValues.simpleEntity,
            ),
            _TestInfo(
              'IterableEntity',
              createTestSubject: () => EntityTestSubject(
                  EntityTS.iterableEntity(makeIterableEntity(
                      sampleValues.iterableEntity, sampleOptions))),
              sampleParams: sampleValues.iterableEntity,
            ),
            _TestInfo(
              'Iterable2Entity',
              createTestSubject: () => EntityTestSubject(
                  EntityTS.iterable2Entity(makeIterable2Entity(
                      sampleValues.iterable2Entity, sampleOptions))),
              sampleParams: sampleValues.iterable2Entity,
            ),
          ];

  @override
  H getTestHelper(
      EntityTestSubject<SingleValueObject, MultiValueObject, SE, IE, I2E>
          testSubject,
      O sampleOptions,
      P sampleParams);

  SE makeSimpleEntity(P params, O sampleOptions);

  IE makeIterableEntity(P params, O sampleOptions);

  I2E makeIterable2Entity(P params, O sampleOptions);
}
