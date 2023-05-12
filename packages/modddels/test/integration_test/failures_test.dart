import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:test/scaffolding.dart';
import 'package:checks/checks.dart';
import 'package:collection/collection.dart';

import 'integration/_common.dart';
import 'integration/failures/failures.dart';
import 'integration/failures/failures_support.dart';
import 'integration_test_utils/integration_test_utils.dart';

void main() async {
  final sourcesLibrary = await resolveIntegrationImport('failures/failures');
  test(
    'failures/failures file has no issue',
    () async {
      final errorResult = await sourcesLibrary.session.getErrors(
              '/modddels/test/integration_test/integration/failures/failures.dart')
          as ErrorsResult;

      printOnFailure('Errors : ${errorResult.errors}');

      check(errorResult.errors).isEmpty();
    },
    timeout: Timeout(Duration(seconds: 60)),
  );

  group('Feature : Modddel failures\n', () {
    group(
        'Rule : For each validation, a failure field ± hasFailure getter is '
        'generated\n', () {
      group(
          'Example : One validation - Solo modddel\n'
          '\n'
          'Given a solo modddel with a validationStep that has one validation\n'
          'When the code is generated\n'
          'Then the matching invalid-step union-case should contain :\n'
          '* One non-nullable failure property\n'
          '* No "hasFailure" getter\n', () {
        final soloTestSupport = FailuresSoloTestSupport(samples: {
          SoloSampleOptions(
            'Example',
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues
        });

        soloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          final firstInvalidStepUnionCase = testHelper
              .getInvalidStepUnionCaseClass(sourcesLibrary, vStepIndex: 0);

          // length failure
          final expectedLengthFailureType = testSubject.map(
              valueObject: (_) => 'LengthValueFailure',
              entity: (_) => 'LengthEntityFailure');

          final lengthFailureProperty =
              firstInvalidStepUnionCase.getProperty('lengthFailure');

          testHelper.checkFailureFieldProperty(
            lengthFailureProperty,
            expectedFailureType: expectedLengthFailureType,
            isNullable: false,
          );

          final hasLengthFailureGetter =
              firstInvalidStepUnionCase.getGetter('hasLengthFailure');

          check(hasLengthFailureGetter).isNull();
        });
      });

      group(
          'Example : One validation - SSealed modddel\n'
          '\n'
          'Given a ssealed modddel with a validationStep that has one validation\n'
          'When the code is generated\n'
          'Then the matching invalid-step ssealed class should contain :\n'
          '* One non-nullable failure getter\n'
          '* No "hasFailure" getter\n'
          'And each case-modddel\'s matching invalid-step union-case should contain :\n'
          '* One non-nullable failure property\n'
          '* No "hasFailure" getter\n', () {
        final sSealedTestSupport = FailuresSSealedTestSupport(samples: {
          SSealedSampleOptions(
            'Example - First factory constructor',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues
        });

        sSealedTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          final firstSSealedInvalidStepMixin = testHelper
              .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 0);

          final firstModddelInvalidStepUnionCase =
              testHelper.getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                  vStepIndex: 0);

          // length failure
          final expectedLengthFailureType = testSubject.map(
              valueObject: (_) => 'LengthValueFailure',
              entity: (_) => 'LengthEntityFailure');

          final sSealedLengthFailureGetter = firstSSealedInvalidStepMixin
              .getFieldsInterface()!
              .getGetter('lengthFailure');

          testHelper.checkFailureFieldGetter(
            sSealedLengthFailureGetter,
            expectedFailureType: expectedLengthFailureType,
            isNullable: false,
          );

          final modddelLengthFailureProperty =
              firstModddelInvalidStepUnionCase.getProperty('lengthFailure');

          testHelper.checkFailureFieldProperty(
            modddelLengthFailureProperty,
            expectedFailureType: expectedLengthFailureType,
            isNullable: false,
          );

          final sSealedHasLengthFailureGetter =
              firstSSealedInvalidStepMixin.getGetter('hasLengthFailure');

          check(sSealedHasLengthFailureGetter).isNull();

          final modddelHasLengthFailureGetter =
              firstModddelInvalidStepUnionCase.getGetter('hasLengthFailure');

          check(modddelHasLengthFailureGetter).isNull();
        });
      });

      group(
          'Example : Multiple validations - Solo modddel\n'
          '\n'
          'Given a solo modddel with a validationStep that has two validations\n'
          'When the code is generated\n'
          'Then the matching invalid-step union-case should contain :\n'
          '* Two nullable failures properties\n'
          '* Two "hasFailure" getters\n', () {
        final soloTestSupport = FailuresSoloTestSupport(samples: {
          SoloSampleOptions(
            'Example',
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues
        });

        soloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          final secondInvalidStepUnionCase = testHelper
              .getInvalidStepUnionCaseClass(sourcesLibrary, vStepIndex: 1);

          // size failure
          final expectedSizeFailureType = testSubject.map(
              valueObject: (_) => 'SizeValueFailure',
              entity: (_) => 'SizeEntityFailure');

          final sizeFailureProperty =
              secondInvalidStepUnionCase.getProperty('sizeFailure');

          testHelper.checkFailureFieldProperty(
            sizeFailureProperty,
            expectedFailureType: expectedSizeFailureType,
            isNullable: true,
          );

          final hasSizeFailureGetter =
              secondInvalidStepUnionCase.getGetter('hasSizeFailure');

          testHelper.checkHasFailureGetter(hasSizeFailureGetter);

          // format failure
          final expectedFormatFailureType = testSubject.map(
              valueObject: (_) => 'FormatValueFailure',
              entity: (_) => 'FormatEntityFailure');

          final formatFailureProperty =
              secondInvalidStepUnionCase.getProperty('formatFailure');

          testHelper.checkFailureFieldProperty(
            formatFailureProperty,
            expectedFailureType: expectedFormatFailureType,
            isNullable: true,
          );

          final hasFormatFailureGetter =
              secondInvalidStepUnionCase.getGetter('hasFormatFailure');

          testHelper.checkHasFailureGetter(hasFormatFailureGetter);
        });
      });

      group(
          'Example : Multiple validations - SSealed modddel\n'
          '\n'
          'Given a ssealed modddel with a validationStep that has two validations\n'
          'When the code is generated\n'
          'Then the matching invalid-step ssealed class should contain :\n'
          '* Two nullable failures getters\n'
          '* Two "hasFailure" getters\n'
          'And each case-modddel\'s matching invalid-step union-case should contain :\n'
          '* Two nullable failures properties\n'
          '* Two "hasFailure" getters\n', () {
        final sSealedTestSupport = FailuresSSealedTestSupport(samples: {
          SSealedSampleOptions(
            'Example - First factory constructor',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues
        });

        sSealedTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          final secondSSealedInvalidStepMixin = testHelper
              .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 1);

          final secondModddelInvalidStepUnionCase =
              testHelper.getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                  vStepIndex: 1);

          // size failure
          final expectedSizeFailureType = testSubject.map(
              valueObject: (_) => 'SizeValueFailure',
              entity: (_) => 'SizeEntityFailure');

          final sSealedSizeFailureGetter = secondSSealedInvalidStepMixin
              .getFieldsInterface()!
              .getGetter('sizeFailure');

          testHelper.checkFailureFieldGetter(
            sSealedSizeFailureGetter,
            expectedFailureType: expectedSizeFailureType,
            isNullable: true,
          );

          final modddelSizeFailureProperty =
              secondModddelInvalidStepUnionCase.getProperty('sizeFailure');

          testHelper.checkFailureFieldProperty(
            modddelSizeFailureProperty,
            expectedFailureType: expectedSizeFailureType,
            isNullable: true,
          );

          final sSealedHasSizeFailureGetter =
              secondSSealedInvalidStepMixin.getGetter('hasSizeFailure');

          testHelper.checkHasFailureGetter(sSealedHasSizeFailureGetter);

          final modddelHasSizeFailureGetter =
              secondModddelInvalidStepUnionCase.getGetter('hasSizeFailure');

          testHelper.checkHasFailureGetter(modddelHasSizeFailureGetter);

          // format failure
          final expectedFormatFailureType = testSubject.map(
              valueObject: (_) => 'FormatValueFailure',
              entity: (_) => 'FormatEntityFailure');

          final sSealedFormatFailureGetter = secondSSealedInvalidStepMixin
              .getFieldsInterface()!
              .getGetter('formatFailure');

          testHelper.checkFailureFieldGetter(
            sSealedFormatFailureGetter,
            expectedFailureType: expectedFormatFailureType,
            isNullable: true,
          );

          final modddelFormatFailureProperty =
              secondModddelInvalidStepUnionCase.getProperty('formatFailure');

          testHelper.checkFailureFieldProperty(
            modddelFormatFailureProperty,
            expectedFailureType: expectedFormatFailureType,
            isNullable: true,
          );

          final sSealedHasFormatFailureGetter =
              secondSSealedInvalidStepMixin.getGetter('hasFormatFailure');

          testHelper.checkHasFailureGetter(sSealedHasFormatFailureGetter);

          final modddelHasFormatFailureGetter =
              secondModddelInvalidStepUnionCase.getGetter('hasFormatFailure');

          testHelper.checkHasFailureGetter(modddelHasFormatFailureGetter);
        });
      });
    });

    group('Rule : Failures handling is working\n', () {
      group(
          'Example : All validations pass - Solo modddel\n'
          '\n'
          'Given a solo modddel\n'
          'When all validations pass\n'
          'Then the created modddel is an instance of the valid union-case\n'
          'And for both the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Right that contains the valid union-case\n'
          'And for the valid union-case :\n'
          '* We can\'t access the failure fields nor the hasFailure getters\n'
          '* We can\'t call the `failures` getter\n', () {
        final soloTestSupport = FailuresSoloTestSupport(samples: {
          SoloSampleOptions('Example',
              lengthValidationPasses: true,
              sizeValidationPasses: true,
              formatValidationPasses: true): sampleValues,
        });

        soloTestSupport.runTestsForAll((createTestHelper) async {
          final testHelper = createTestHelper();

          final isEntity = testHelper.testSubject
              .maybeMap(entity: (_) => true, orElse: () => false);

          // `toBroadEither` getter
          testHelper.checkAllToBroadEitherGettersResults(isModddelValid: true);

          // failure fields and `failures` getter

          final library = await resolveMain('''
            import 'failures/failures.dart';
            // ignore: unused_import
            import '_common.dart';

            class MyClass {
              void accessFromValid(${testHelper.validUnionCaseName} valid) {
                print(valid.lengthFailure);
                print(valid.sizeFailure);
                print(valid.formatFailure);
                ${isEntity ? 'print(valid.contentFailure);' : ''}

                print(valid.hasLengthFailure);
                print(valid.hasSizeFailure);
                print(valid.hasFormatFailure);
                ${isEntity ? 'print(valid.hasContentFailure);' : ''}

                print(valid.failures);
              }
            }
            ''');

          final errorResult = await library.session.getErrors(
                  '/modddels/test/integration_test/integration/main.dart')
              as ErrorsResult;

          printOnFailure('Errors : ${errorResult.errors}');

          final errors = errorResult.errors;

          check(errors).length.equals(isEntity ? 9 : 7);

          check(errors).every(it()
            ..has((error) => error.errorCode.name, 'error code name')
                .equals('UNDEFINED_GETTER')
            ..has((error) => error.severity, 'severity')
                .equals(Severity.error));
        });
      });

      group(
          'Example : All validations pass - SSealed modddel\n'
          '\n'
          'Given a ssealed modddel\n'
          'When all validations pass\n'
          'Then the created modddel is an instance of the valid union-case\n'
          'And for the base modddel, the ssealed modddel and the case-modddel :\n'
          '* Calling the `toBroadEither` getter returns a Right that contains the valid union-case\n'
          'And for both the valid ssealed mixin and the case-modddel\'s valid union-case :\n'
          '* We can\'t access the failure fields nor the hasFailure getters\n'
          '* We can\'t call the `failures` getter\n', () {
        final sSealedTestSupport = FailuresSSealedTestSupport(samples: {
          SSealedSampleOptions('Example - First factory constructor',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
              sizeValidationPasses: true,
              formatValidationPasses: true): sampleValues,
          SSealedSampleOptions('Example - Second factory constructor',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: true,
              sizeValidationPasses: true,
              formatValidationPasses: true): sampleValues,
        });

        sSealedTestSupport.runTestsForAll((createTestHelper) async {
          final testHelper = createTestHelper();

          final isEntity = testHelper.testSubject
              .maybeMap(entity: (_) => true, orElse: () => false);

          // `toBroadEither` getter
          testHelper.checkAllToBroadEitherGettersResults(isModddelValid: true);

          // failure fields and `failures` getter

          final library = await resolveMain('''
            import 'failures/failures.dart';
            // ignore: unused_import
            import '_common.dart';

            class MyClass {
              void accessFromValidSSealed(${testHelper.sSealedValidMixinName} valid) {
                print(valid.lengthFailure);
                print(valid.sizeFailure);
                print(valid.formatFailure);
                ${isEntity ? 'print(valid.contentFailure);' : ''}

                print(valid.hasLengthFailure);
                print(valid.hasSizeFailure);
                print(valid.hasFormatFailure);
                ${isEntity ? 'print(valid.hasContentFailure);' : ''}

                print(valid.failures);
              }

              void accessFromValidCaseModddel(${testHelper.modddelValidUnionCaseName} valid) {
                print(valid.lengthFailure);
                print(valid.sizeFailure);
                print(valid.formatFailure);
                ${isEntity ? 'print(valid.contentFailure);' : ''}

                print(valid.hasLengthFailure);
                print(valid.hasSizeFailure);
                print(valid.hasFormatFailure);
                ${isEntity ? 'print(valid.hasContentFailure);' : ''}

                print(valid.failures);
              }
            }
            ''');

          final errorResult = await library.session.getErrors(
                  '/modddels/test/integration_test/integration/main.dart')
              as ErrorsResult;

          printOnFailure('Errors : ${errorResult.errors}');

          final errors = errorResult.errors;

          check(errors).length.equals(isEntity ? 18 : 14);

          check(errors).every(it()
            ..has((error) => error.errorCode.name, 'error code name')
                .equals('UNDEFINED_GETTER')
            ..has((error) => error.severity, 'severity')
                .equals(Severity.error));
        });
      });

      group(
          'Example : One validation - The validation fails - Solo modddel\n'
          '\n'
          'Given a solo modddel with a validationStep that has one validation\n'
          'When the only validation fails\n'
          'Then the created modddel is an instance of the matching invalid-step union-case\n'
          'And for both the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure\n'
          'And for the matching invalid-step union-case :\n'
          '* The non-nullable failure field holds the failure of the validation\n'
          'And for both the abstract invalid union-case and the invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure\n',
          () {
        final soloTestSupport = FailuresSoloTestSupport(samples: {
          SoloSampleOptions(
            'Example - Next vstep validations pass',
            lengthValidationPasses: false,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues,
          SoloSampleOptions(
            'Example - One next vstep validation fails',
            lengthValidationPasses: false,
            sizeValidationPasses: true,
            formatValidationPasses: false,
          ): sampleValues,
          SoloSampleOptions(
            'Example - All next vstep validations fail',
            lengthValidationPasses: false,
            sizeValidationPasses: false,
            formatValidationPasses: false,
          ): sampleValues,
        });

        soloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          testHelper.checkIsModddelOfType<
              InvalidFailuresSoloSVOValue1,
              InvalidFailuresSoloMVOValue1,
              InvalidFailuresSoloSEEarly1,
              InvalidFailuresSoloIEEarly1,
              InvalidFailuresSoloI2EEarly1>();

          final expectedFailures = [
            testSubject.map(
                valueObject: (_) =>
                    LengthValueFailure('This is a length failure'),
                entity: (_) => LengthEntityFailure('This is a length failure'))
          ];

          // `toBroadEither` getter
          testHelper.checkAllToBroadEitherGettersResults(
            isModddelValid: false,
            expectedFailures: expectedFailures,
          );

          // failure fields
          final failureFields =
              testHelper.getFailureFieldsFromInvalidStepUnionCase();

          check(failureFields).deepEquals(expectedFailures);

          // `failures` getter
          final invalidAbstractFailures =
              testHelper.callFailuresGetterFromAbstractInvalidUnionCase();

          final invalidStepFailures =
              testHelper.callFailuresGetterFromInvalidStepUnionCase();

          testHelper.checkFailuresGetterResult(
              invalidAbstractFailures, expectedFailures);
          testHelper.checkFailuresGetterResult(
              invalidStepFailures, expectedFailures);
        });
      });

      group(
          'Example : One validation - The validation fails - SSealed modddel\n'
          '\n'
          'Given a ssealed modddel with a validationStep that has one validation\n'
          'When the only validation fails\n'
          'Then the created modddel is an instance of the case-modddel\'s matching invalid-step union-case\n'
          'And for the ssealed modddel, the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure\n'
          'And for both the matching ssealed invalid-step mixin and the case-modddel\'s matching invalid-step union-case :\n'
          '* The non-nullable failure field holds the failure of the validation\n'
          'And for the ssealed invalid mixin, the matching ssealed invalid-step mixin, the case-modddel\'s abstract invalid union-case and the case-modddel\'s matching invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure\n',
          () {
        final sSealedTestSupport = FailuresSSealedTestSupport(samples: {
          SSealedSampleOptions(
            'Example - First factory constructor - Next vstep validations pass',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor - Next vstep validations pass',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
            formatValidationPasses: true,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - First factory constructor - One next vstep validation fails',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
            formatValidationPasses: false,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor - One next vstep validation fails',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: false,
            sizeValidationPasses: false,
            formatValidationPasses: true,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - First factory constructor - All next vstep validations fail',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: false,
            sizeValidationPasses: false,
            formatValidationPasses: false,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor - All next vstep validations fail',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: false,
            sizeValidationPasses: false,
            formatValidationPasses: false,
          ): sampleValues,
        });

        sSealedTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          final usedFactoryConstructor =
              testHelper.sampleOptions.usedFactoryConstructor;

          switch (usedFactoryConstructor) {
            case FactoryConstructor.first:
              testHelper.checkIsModddelOfType<
                  InvalidFirstFailuresSSealedSVOValue1,
                  InvalidFirstFailuresSSealedMVOValue1,
                  InvalidFirstFailuresSSealedSELate1,
                  InvalidFirstFailuresSSealedIELate1,
                  InvalidFirstFailuresSSealedI2ELate1>();
              break;
            case FactoryConstructor.second:
              testHelper.checkIsModddelOfType<
                  InvalidSecondFailuresSSealedSVOValue1,
                  InvalidSecondFailuresSSealedMVOValue1,
                  InvalidSecondFailuresSSealedSELate1,
                  InvalidSecondFailuresSSealedIELate1,
                  InvalidSecondFailuresSSealedI2ELate1>();
              break;
          }

          final expectedFailures = [
            testSubject.map(
                valueObject: (_) =>
                    LengthValueFailure('This is a length failure'),
                entity: (_) => LengthEntityFailure('This is a length failure'))
          ];

          // `toBroadEither` getter
          testHelper.checkAllToBroadEitherGettersResults(
            isModddelValid: false,
            expectedFailures: expectedFailures,
          );

          // failure fields
          final sSealedFailureFields =
              testHelper.getFailureFieldsFromSSealedInvalidStepMixin();

          final modddelFailureFields =
              testHelper.getFailureFieldsFromModddelInvalidStepUnionCase();

          check(sSealedFailureFields).deepEquals(expectedFailures);
          check(modddelFailureFields).deepEquals(expectedFailures);

          // `failures` getter
          final invalidSSealedFailures =
              testHelper.callFailuresGetterFromSSealedInvalidMixin();

          final invalidStepSSealedFailures =
              testHelper.callFailuresGetterFromSSealedInvalidStepMixin();

          final invalidModddelFailures = testHelper
              .callFailuresGetterFromModddelAbstractInvalidUnionCase();

          final invalidStepModddelFailures =
              testHelper.callFailuresGetterFromModddelInvalidStepUnionCase();

          testHelper.checkFailuresGetterResult(
              invalidSSealedFailures, expectedFailures);
          testHelper.checkFailuresGetterResult(
              invalidStepSSealedFailures, expectedFailures);
          testHelper.checkFailuresGetterResult(
              invalidModddelFailures, expectedFailures);
          testHelper.checkFailuresGetterResult(
              invalidStepModddelFailures, expectedFailures);
        });
      });

      group(
          'Example : Multiple validations - One or more validations fail - Solo modddel\n'
          '\n'
          'Given a solo modddel with a validationStep that has two validations\n'
          'When one or more validations fail(s)\n'
          'Then the created modddel is an instance of the matching invalid-step union-case\n'
          'And for both the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure(s)\n'
          'And for the matching invalid-step union-case :\n'
          '* Each nullable failure field holds the failure of its validation if it failed, or else holds null\n'
          '* Each hasFailure getter returns true if its validation failed, or else returns false\n'
          'And for both the abstract invalid union-case and the invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure(s)\n',
          () {
        final soloTestSupport = FailuresSoloTestSupport(samples: {
          SoloSampleOptions(
            'Example - First validation fails',
            lengthValidationPasses: true,
            sizeValidationPasses: false,
            formatValidationPasses: true,
          ): sampleValues,
          SoloSampleOptions(
            'Example - Second validation fails',
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: false,
          ): sampleValues,
          SoloSampleOptions(
            'Example - Both validations fail',
            lengthValidationPasses: true,
            sizeValidationPasses: false,
            formatValidationPasses: false,
          ): sampleValues,
        });

        soloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          final sampleOptions = testHelper.sampleOptions;

          testHelper.checkIsModddelOfType<
              InvalidFailuresSoloSVOValue2,
              InvalidFailuresSoloMVOValue2,
              InvalidFailuresSoloSEEarly2,
              InvalidFailuresSoloIEEarly2,
              InvalidFailuresSoloI2EEarly2>();

          final expectedFailures = [
            sampleOptions.sizeValidationPasses
                ? null
                : testSubject.map(
                    valueObject: (_) =>
                        SizeValueFailure('This is a size failure'),
                    entity: (_) => SizeEntityFailure('This is a size failure')),
            sampleOptions.formatValidationPasses
                ? null
                : testSubject.map(
                    valueObject: (_) =>
                        FormatValueFailure('This is a format failure'),
                    entity: (_) =>
                        FormatEntityFailure('This is a format failure')),
          ];

          final expectedNonNullFailures =
              expectedFailures.whereNotNull().toList();

          final expectedHasFailures =
              expectedFailures.map((failure) => failure != null).toList();

          // `toBroadEither` getter
          testHelper.checkAllToBroadEitherGettersResults(
            isModddelValid: false,
            expectedFailures: expectedNonNullFailures,
          );

          // failure fields
          final failureFields =
              testHelper.getFailureFieldsFromInvalidStepUnionCase();

          check(failureFields).deepEquals(expectedFailures);

          // hasFailure getters
          final hasFailureGetters =
              testHelper.getHasFailureGettersFromInvalidStepUnionCase();

          check(hasFailureGetters).deepEquals(expectedHasFailures);

          // `failures` getter
          final invalidAbstractFailures =
              testHelper.callFailuresGetterFromAbstractInvalidUnionCase();

          final invalidStepFailures =
              testHelper.callFailuresGetterFromInvalidStepUnionCase();

          testHelper.checkFailuresGetterResult(
              invalidAbstractFailures, expectedNonNullFailures);
          testHelper.checkFailuresGetterResult(
              invalidStepFailures, expectedNonNullFailures);
        });
      });

      group(
          'Example : Multiple validations - One or more validations fail - SSealed modddel\n'
          '\n'
          'Given a ssealed modddel with a validationStep that has two validations\n'
          'When one or more validations fail(s)\n'
          'Then the created modddel is an instance of the case-modddel\'s matching invalid-step union-case\n'
          'And for the ssealed modddel, the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure(s)\n'
          'And for both the matching ssealed invalid-step mixin and the case-modddel\'s matching invalid-step union-case :\n'
          '* Each nullable failure field holds the failure of its validation if it failed, or else holds null\n'
          '* Each hasFailure getter returns true if its validation failed, or else returns false\n'
          'And for the ssealed invalid mixin, the matching ssealed invalid-step mixin, the case-modddel\'s abstract invalid union-case and the case-modddel\'s matching invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure(s)\n',
          () {
        final ssealedTestSupport = FailuresSSealedTestSupport(samples: {
          SSealedSampleOptions(
            'Example - First factory constructor - First validation fails',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: false,
            formatValidationPasses: true,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor - First validation fails',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: false,
            formatValidationPasses: true,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - First factory constructor - Second validation fails',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: false,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor - Second validation fails',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
            formatValidationPasses: false,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - First factory constructor - Both validations fail',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: false,
            formatValidationPasses: false,
          ): sampleValues,
          SSealedSampleOptions(
            'Example - Second factory constructor - Both validations fail',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: false,
            formatValidationPasses: false,
          ): sampleValues,
        });

        ssealedTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final testSubject = testHelper.testSubject;

          final sampleOptions = testHelper.sampleOptions;

          final usedFactoryConstructor =
              testHelper.sampleOptions.usedFactoryConstructor;

          switch (usedFactoryConstructor) {
            case FactoryConstructor.first:
              testHelper.checkIsModddelOfType<
                  InvalidFirstFailuresSSealedSVOValue2,
                  InvalidFirstFailuresSSealedMVOValue2,
                  InvalidFirstFailuresSSealedSELate2,
                  InvalidFirstFailuresSSealedIELate2,
                  InvalidFirstFailuresSSealedI2ELate2>();
              break;
            case FactoryConstructor.second:
              testHelper.checkIsModddelOfType<
                  InvalidSecondFailuresSSealedSVOValue2,
                  InvalidSecondFailuresSSealedMVOValue2,
                  InvalidSecondFailuresSSealedSELate2,
                  InvalidSecondFailuresSSealedIELate2,
                  InvalidSecondFailuresSSealedI2ELate2>();
              break;
          }

          final expectedFailures = [
            sampleOptions.sizeValidationPasses
                ? null
                : testSubject.map(
                    valueObject: (_) =>
                        SizeValueFailure('This is a size failure'),
                    entity: (_) => SizeEntityFailure('This is a size failure')),
            sampleOptions.formatValidationPasses
                ? null
                : testSubject.map(
                    valueObject: (_) =>
                        FormatValueFailure('This is a format failure'),
                    entity: (_) =>
                        FormatEntityFailure('This is a format failure')),
          ];

          final expectedNonNullFailures =
              expectedFailures.whereNotNull().toList();

          final expectedHasFailures =
              expectedFailures.map((failure) => failure != null).toList();

          // `toBroadEither` getter
          testHelper.checkAllToBroadEitherGettersResults(
            isModddelValid: false,
            expectedFailures: expectedNonNullFailures,
          );

          // failure fields
          final sSealedFailureFields =
              testHelper.getFailureFieldsFromSSealedInvalidStepMixin();

          final modddelFailureFields =
              testHelper.getFailureFieldsFromModddelInvalidStepUnionCase();

          check(sSealedFailureFields).deepEquals(expectedFailures);
          check(modddelFailureFields).deepEquals(expectedFailures);

          // hasFailure getters
          final sSealedHasFailureGetters =
              testHelper.getHasFailureGettersFromSSealedInvalidStepMixin();

          final modddelHasFailureGetters =
              testHelper.getHasFailureGettersFromModddelInvalidStepUnionCase();

          check(sSealedHasFailureGetters).deepEquals(expectedHasFailures);
          check(modddelHasFailureGetters).deepEquals(expectedHasFailures);

          // `failures` getter
          final invalidSSealedFailures =
              testHelper.callFailuresGetterFromSSealedInvalidMixin();

          final invalidStepSSealedFailures =
              testHelper.callFailuresGetterFromSSealedInvalidStepMixin();

          final invalidModddelFailures = testHelper
              .callFailuresGetterFromModddelAbstractInvalidUnionCase();

          final invalidStepModddelFailures =
              testHelper.callFailuresGetterFromModddelInvalidStepUnionCase();

          testHelper.checkFailuresGetterResult(
              invalidSSealedFailures, expectedNonNullFailures);
          testHelper.checkFailuresGetterResult(
              invalidStepSSealedFailures, expectedNonNullFailures);
          testHelper.checkFailuresGetterResult(
              invalidModddelFailures, expectedNonNullFailures);
          testHelper.checkFailuresGetterResult(
              invalidStepModddelFailures, expectedNonNullFailures);
        });
      });
    });
  });
}
