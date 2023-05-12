import 'package:analyzer/dart/analysis/results.dart';
import 'package:checks/checks.dart';
import 'package:collection/collection.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import 'integration/_common.dart';
import 'integration/failures/content_failure.dart';
import 'integration/failures/content_failure_support.dart';
import 'integration_test_utils/integration_test_utils.dart';

void main() async {
  final sourcesLibrary =
      await resolveIntegrationImport('failures/content_failure');
  test(
    'failures/content_failure file has no issue',
    () async {
      final errorResult = await sourcesLibrary.session.getErrors(
              '/modddels/test/integration_test/integration/failures/content_failure.dart')
          as ErrorsResult;

      printOnFailure('Errors : ${errorResult.errors}');

      check(errorResult.errors).isEmpty();
    },
    timeout: Timeout(Duration(seconds: 60)),
  );

  group('Feature : ContentFailure\n', () {
    /// TODO : Test that the failures can't be accessed from the invalid
    /// union-case.
    group(
        'Rule : For the contentValidation, a failure field ± hasFailure getter '
        'is generated\n', () {
      group(
          'Example : One validation - Solo entity\n'
          '\n'
          'Given a solo entity with a validationStep that has the contentValidation\n'
          'When the code is generated\n'
          'Then the mid invalid-step union-case should contain :\n'
          '* One non-nullable failure property\n'
          '* No "hasFailure" getter\n', () {
        final oneValidationSoloTestSupport =
            OneValidationSoloTestSupport(samples: {
          OneValidationSoloSampleOptions(
            'Example',
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true)
        });

        oneValidationSoloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();

          final midInvalidStepUnionCase =
              testHelper.getInvalidStepUnionCaseClass(
            sourcesLibrary,
            vStepIndex: 0,
          );

          final contentFailureProperty =
              midInvalidStepUnionCase.getProperty('contentFailure');

          testHelper.checkFailureFieldProperty(
            contentFailureProperty,
            expectedFailureType: 'ContentFailure',
            isNullable: false,
          );

          final hasContentFailureGetter =
              midInvalidStepUnionCase.getGetter('hasContentFailure');

          check(hasContentFailureGetter).isNull();
        });
      });

      group(
          'Example : One validation - SSealed entity\n'
          '\n'
          'Given a ssealed entity with a validationStep that has the contentValidation\n'
          'When the code is generated\n'
          'Then the matching invalid-step ssealed class should contain :\n'
          '* One non-nullable failure getter\n'
          '* No "hasFailure" getter\n'
          'And each case-modddel\'s mid invalid-step union-case should contain :\n'
          '* One non-nullable failure property\n'
          '* No "hasFailure" getter\n', () {
        final oneValidationSSealedTestSupport =
            OneValidationSSealedTestSupport(samples: {
          OneValidationSSealedSampleOptions(
            'Example - First factory constructor',
            usedFactoryConstructor: FactoryConstructor.first,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true),
          OneValidationSSealedSampleOptions(
            'Example - Second factory constructor',
            usedFactoryConstructor: FactoryConstructor.second,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true),
        });

        oneValidationSSealedTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();

          final midSSealedInvalidStepMixin = testHelper
              .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 0);

          final midModddelInvalidStepUnionCase =
              testHelper.getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                  vStepIndex: 0);

          final sSealedContentFailureGetter = midSSealedInvalidStepMixin
              .getFieldsInterface()!
              .getGetter('contentFailure');

          testHelper.checkFailureFieldGetter(
            sSealedContentFailureGetter,
            expectedFailureType: 'ContentFailure',
            isNullable: false,
          );

          final modddelContentFailureProperty =
              midModddelInvalidStepUnionCase.getProperty('contentFailure');

          testHelper.checkFailureFieldProperty(
            modddelContentFailureProperty,
            expectedFailureType: 'ContentFailure',
            isNullable: false,
          );

          final sSealedHasContentFailureGetter =
              midSSealedInvalidStepMixin.getGetter('hasContentFailure');

          check(sSealedHasContentFailureGetter).isNull();

          final modddelHasContentFailureGetter =
              midModddelInvalidStepUnionCase.getGetter('hasContentFailure');

          check(modddelHasContentFailureGetter).isNull();
        });
      });

      group(
          'Example : Multiple validations - Solo entity\n'
          '\n'
          'Given a solo entity with a validationStep that has the contentValidation + another validation\n'
          'When the code is generated\n'
          'Then the mid invalid-step union-case should contain :\n'
          '* Two nullable failures properties\n'
          '* Two "hasFailure" getters\n', () {
        final multipleValidationsSoloTestSupport =
            MultipleValidationsSoloTestSupport(samples: {
          MultipleValidationsSoloSampleOptions(
            'Example',
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true)
        });

        multipleValidationsSoloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();

          final midInvalidStepUnionCase =
              testHelper.getInvalidStepUnionCaseClass(
            sourcesLibrary,
            vStepIndex: 0,
          );

          // content failure
          final contentFailureProperty =
              midInvalidStepUnionCase.getProperty('contentFailure');

          testHelper.checkFailureFieldProperty(
            contentFailureProperty,
            expectedFailureType: 'ContentFailure',
            isNullable: true,
          );

          final hasContentFailureGetter =
              midInvalidStepUnionCase.getGetter('hasContentFailure');

          testHelper.checkHasFailureGetter(hasContentFailureGetter);

          // length failure

          final lengthFailureProperty =
              midInvalidStepUnionCase.getProperty('lengthFailure');

          testHelper.checkFailureFieldProperty(
            lengthFailureProperty,
            expectedFailureType: 'LengthEntityFailure',
            isNullable: true,
          );

          final hasLengthFailureGetter =
              midInvalidStepUnionCase.getGetter('hasLengthFailure');

          testHelper.checkHasFailureGetter(hasLengthFailureGetter);
        });
      });

      group(
          'Example : Multiple validations - SSealed entity\n'
          '\n'
          'Given a ssealed entity with a validationStep that has the contentValidation + another validation\n'
          'When the code is generated\n'
          'Then the matching invalid-step ssealed class should contain :\n'
          '* Two nullable failures getters\n'
          '* Two "hasFailure" getters\n'
          'And each case-modddel\'s mid invalid-step union-case should contain :\n'
          '* Two nullable failures properties\n'
          '* Two "hasFailure" getters\n', () {
        final multipleValidationsSSealedTestSupport =
            MultipleValidationsSSealedTestSupport(samples: {
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true)
        });

        multipleValidationsSSealedTestSupport
            .runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();

          final midSSealedInvalidStepMixin = testHelper
              .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 0);

          final midModddelInvalidStepUnionCase =
              testHelper.getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                  vStepIndex: 0);

          // content failure

          final sSealedContentFailureGetter = midSSealedInvalidStepMixin
              .getFieldsInterface()!
              .getGetter('contentFailure');

          testHelper.checkFailureFieldGetter(
            sSealedContentFailureGetter,
            expectedFailureType: 'ContentFailure',
            isNullable: true,
          );

          final modddelContentFailureProperty =
              midModddelInvalidStepUnionCase.getProperty('contentFailure');

          testHelper.checkFailureFieldProperty(
            modddelContentFailureProperty,
            expectedFailureType: 'ContentFailure',
            isNullable: true,
          );

          final sSealedHasContentFailureGetter =
              midSSealedInvalidStepMixin.getGetter('hasContentFailure');

          testHelper.checkHasFailureGetter(sSealedHasContentFailureGetter);

          final modddelHasContentFailureGetter =
              midModddelInvalidStepUnionCase.getGetter('hasContentFailure');

          testHelper.checkHasFailureGetter(modddelHasContentFailureGetter);

          // length failure

          final sSealedLengthFailureGetter = midSSealedInvalidStepMixin
              .getFieldsInterface()!
              .getGetter('lengthFailure');

          testHelper.checkFailureFieldGetter(
            sSealedLengthFailureGetter,
            expectedFailureType: 'LengthEntityFailure',
            isNullable: true,
          );

          final modddelLengthFailureProperty =
              midModddelInvalidStepUnionCase.getProperty('lengthFailure');

          testHelper.checkFailureFieldProperty(
            modddelLengthFailureProperty,
            expectedFailureType: 'LengthEntityFailure',
            isNullable: true,
          );

          final sSealedHasLengthFailureGetter =
              midSSealedInvalidStepMixin.getGetter('hasLengthFailure');

          testHelper.checkHasFailureGetter(sSealedHasLengthFailureGetter);

          final modddelHasLengthFailureGetter =
              midModddelInvalidStepUnionCase.getGetter('hasLengthFailure');

          testHelper.checkHasFailureGetter(modddelHasLengthFailureGetter);
        });
      });
    });

    group('Rule : Failures handling with the ContentFailure is working\n', () {
      group(
          'Example : One validation - The contentValidation fails - Solo entity\n'
          '\n'
          'Given a solo entity with a validationStep that has the contentValidation\n'
          'When the contentValidation fails\n'
          'Then the created entity is an instance of the mid invalid-step union-case\n'
          'And the failure is a ContentFailure that holds a list of the invalid member(s) of the Entity\n'
          'And for both the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure\n'
          'And for the mid invalid-step union-case :\n'
          '* The non-nullable failure field holds the failure of the validation\n'
          'And for both the abstract invalid union-case and the invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure\n',
          () {
        final oneValidationSoloTestSupport =
            OneValidationSoloTestSupport(samples: {
          OneValidationSoloSampleOptions(
            'Example - First member is invalid',
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          OneValidationSoloSampleOptions(
            'Example - Second member is invalid',
            sizeValidationPasses: false,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          OneValidationSoloSampleOptions(
            'Example - Both members are invalid',
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
        });

        oneValidationSoloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();

          final sampleParams = testHelper.sampleParams;

          testHelper.checkIsEntityOfType<InvalidOneValidationSoloSEMid,
              InvalidOneValidationSoloIEMid, InvalidOneValidationSoloI2EMid>();

          final expectedFailures = [
            ContentFailure([
              if (!sampleParams.param1IsValid)
                ModddelInvalidMember(
                    member: sampleParams.param1.value as InvalidModddel,
                    description: testHelper.getFirstMemberDescription()),
              if (!sampleParams.param2IsValid)
                ModddelInvalidMember(
                    member: sampleParams.param2.value as InvalidModddel,
                    description: testHelper.getSecondMemberDescription()),
            ])
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
          'Example : One validation - The contentValidation fails - SSealed entity\n'
          '\n'
          'Given a ssealed entity with a validationStep that has the contentValidation\n'
          'When the contentValidation fails\n'
          'Then the created entity is an instance of the case-modddel\'s mid invalid-step union-case\n'
          'And the failure is a ContentFailure that holds a list of the invalid member(s) of the Entity\n'
          'And for the ssealed modddel, the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure\n'
          'And for both the matching ssealed invalid-step mixin and the case-modddel\'s mid invalid-step union-case :\n'
          '* The non-nullable failure field holds the failure of the validation\n'
          'And for the ssealed invalid mixin, the matching ssealed invalid-step mixin, the case-modddel\'s abstract invalid union-case and the case-modddel\'s mid invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure\n',
          () {
        final oneValidationSSealedTestSupport =
            OneValidationSSealedTestSupport(samples: {
          OneValidationSSealedSampleOptions(
            'Example - First factory constructor - First member is invalid',
            usedFactoryConstructor: FactoryConstructor.first,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          OneValidationSSealedSampleOptions(
            'Exampl - Second factory constructore - First member is invalid',
            usedFactoryConstructor: FactoryConstructor.second,
            sizeValidationPasses: false,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          OneValidationSSealedSampleOptions(
            'Example - First factory constructor - Second member is invalid',
            usedFactoryConstructor: FactoryConstructor.first,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          OneValidationSSealedSampleOptions(
            'Example - Second factory constructor - Second member is invalid',
            usedFactoryConstructor: FactoryConstructor.second,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          OneValidationSSealedSampleOptions(
            'Example - First factory constructor - Both members are invalid',
            usedFactoryConstructor: FactoryConstructor.first,
            sizeValidationPasses: false,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
          OneValidationSSealedSampleOptions(
            'Example - Second factory constructor - Both members are invalid',
            usedFactoryConstructor: FactoryConstructor.second,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
        });

        oneValidationSSealedTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();
          final sampleParams = testHelper.sampleParams;

          final usedFactoryConstructor =
              testHelper.sampleOptions.usedFactoryConstructor;

          switch (usedFactoryConstructor) {
            case FactoryConstructor.first:
              testHelper.checkIsEntityOfType<
                  InvalidFirstOneValidationSSealedSEMid,
                  InvalidFirstOneValidationSSealedIEMid,
                  InvalidFirstOneValidationSSealedI2EMid>();
              break;
            case FactoryConstructor.second:
              testHelper.checkIsEntityOfType<
                  InvalidSecondOneValidationSSealedSEMid,
                  InvalidSecondOneValidationSSealedIEMid,
                  InvalidSecondOneValidationSSealedI2EMid>();
              break;
          }

          final expectedFailures = [
            ContentFailure([
              if (!sampleParams.param1IsValid)
                ModddelInvalidMember(
                    member: sampleParams.param1.value as InvalidModddel,
                    description: testHelper.getFirstMemberDescription()),
              if (!sampleParams.param2IsValid)
                ModddelInvalidMember(
                    member: sampleParams.param2.value as InvalidModddel,
                    description: testHelper.getSecondMemberDescription()),
            ])
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
          'Example : Multiple validations - The contentValidation ± other validation fail(s) - Solo entity\n'
          '\n'
          'Given a solo entity with a validationStep that has the contentValidation + another validation\n'
          'When one or more validations fail(s)\n'
          'Then the created entity is an instance of the mid invalid-step union-case\n'
          'And the failure of the contentValidation (if any) is a ContentFailure that holds a list of the invalid member(s) of the Entity\n'
          'And for both the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure(s)\n'
          'And for the mid invalid-step union-case :\n'
          '* Each nullable failure field holds the failure of its validation if it failed, or else holds null\n'
          '* Each hasFailure getter returns true if its validation failed, or else returns false\n'
          'And for both the abstract invalid union-case and the invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure(s)\n',
          () {
        final multipleValidationsSoloTestSupport =
            MultipleValidationsSoloTestSupport(samples: {
          MultipleValidationsSoloSampleOptions(
            'Example - First member is invalid - Other validation passes',
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          MultipleValidationsSoloSampleOptions(
            'Example - First member is invalid - Other validation fails',
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          MultipleValidationsSoloSampleOptions(
            'Example - Second member is invalid - Other validation passes',
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          MultipleValidationsSoloSampleOptions(
            'Example - Second member is invalid - Other validation fails',
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          MultipleValidationsSoloSampleOptions(
            'Example - Both members are invalid - Other validation passes',
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
          MultipleValidationsSoloSampleOptions(
            'Example - Both members are invalid - Other validation fails',
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
          MultipleValidationsSoloSampleOptions(
            'Example - ContentValidation passes - Other validation fails',
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true),
        });

        multipleValidationsSoloTestSupport.runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();

          final sampleParams = testHelper.sampleParams;
          final sampleOptions = testHelper.sampleOptions;

          testHelper.checkIsEntityOfType<
              InvalidMultipleValidationsSoloSEMid,
              InvalidMultipleValidationsSoloIEMid,
              InvalidMultipleValidationsSoloI2EMid>();

          final contentValidationPasses =
              sampleParams.param1IsValid && sampleParams.param2IsValid;

          final expectedFailures = [
            contentValidationPasses
                ? null
                : ContentFailure([
                    if (!sampleParams.param1IsValid)
                      ModddelInvalidMember(
                          member: sampleParams.param1.value as InvalidModddel,
                          description: testHelper.getFirstMemberDescription()),
                    if (!sampleParams.param2IsValid)
                      ModddelInvalidMember(
                          member: sampleParams.param2.value as InvalidModddel,
                          description: testHelper.getSecondMemberDescription()),
                  ]),
            sampleOptions.lengthValidationPasses
                ? null
                : LengthEntityFailure('This is a length failure'),
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
          'Example : Multiple validations - The contentValidation ± other validation fail(s) - SSealed entity\n'
          '\n'
          'Given a ssealed entity with a validationStep that has the contentValidation + another validation\n'
          'When one or more validations fail(s)\n'
          'Then the created entity is an instance of the case-modddel\'s mid invalid-step union-case\n'
          'And the failure of the contentValidation (if any) is a ContentFailure that holds a list of the invalid member(s) of the Entity\n'
          'And for the ssealed modddel, the base modddel and the solo modddel :\n'
          '* Calling the `toBroadEither` getter returns a Left that contains a list that contains the failure\n'
          'And for both the matching ssealed invalid-step mixin and the case-modddel\'s mid invalid-step union-case :\n'
          '* Each nullable failure field holds the failure of its validation if it failed, or else holds null\n'
          '* Each hasFailure getter returns true if its validation failed, or else returns false\n'
          'And for the ssealed invalid mixin, the matching ssealed invalid-step mixin, the case-modddel\'s abstract invalid union-case and the case-modddel\'s mid invalid-step union-case :\n'
          '* Calling the `failures` getter returns a list that contains the failure\n',
          () {
        final multipleValidationsSSealedTestSupport =
            MultipleValidationsSSealedTestSupport(samples: {
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor - First member is invalid - Other validation passes',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor - First member is invalid - Other validation passes',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor - First member is invalid - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor - First member is invalid - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: true),
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor - Second member is invalid - Other validation passes',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor - Second member is invalid - Other validation passes',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor - Second member is invalid - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor - Second member is invalid - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor - Both members are invalid - Other validation passes',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor - Both members are invalid - Other validation passes',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: true,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor - Both members are invalid - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor - Both members are invalid - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: false, param2IsValid: false),
          MultipleValidationsSSealedSampleOptions(
            'Example - First factory constructor - ContentValidation passes - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.first,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true),
          MultipleValidationsSSealedSampleOptions(
            'Example - Second factory constructor - ContentValidation passes - Other validation fails',
            usedFactoryConstructor: FactoryConstructor.second,
            lengthValidationPasses: false,
            sizeValidationPasses: true,
          ): getSampleValues(param1IsValid: true, param2IsValid: true),
        });

        multipleValidationsSSealedTestSupport
            .runTestsForAll((createTestHelper) {
          final testHelper = createTestHelper();

          final sampleParams = testHelper.sampleParams;
          final sampleOptions = testHelper.sampleOptions;

          final usedFactoryConstructor =
              testHelper.sampleOptions.usedFactoryConstructor;

          switch (usedFactoryConstructor) {
            case FactoryConstructor.first:
              testHelper.checkIsEntityOfType<
                  InvalidFirstMultipleValidationsSSealedSEMid,
                  InvalidFirstMultipleValidationsSSealedIEMid,
                  InvalidFirstMultipleValidationsSSealedI2EMid>();
              break;
            case FactoryConstructor.second:
              testHelper.checkIsEntityOfType<
                  InvalidSecondMultipleValidationsSSealedSEMid,
                  InvalidSecondMultipleValidationsSSealedIEMid,
                  InvalidSecondMultipleValidationsSSealedI2EMid>();
              break;
          }

          final contentValidationPasses =
              sampleParams.param1IsValid && sampleParams.param2IsValid;

          final expectedFailures = [
            contentValidationPasses
                ? null
                : ContentFailure([
                    if (!sampleParams.param1IsValid)
                      ModddelInvalidMember(
                          member: sampleParams.param1.value as InvalidModddel,
                          description: testHelper.getFirstMemberDescription()),
                    if (!sampleParams.param2IsValid)
                      ModddelInvalidMember(
                          member: sampleParams.param2.value as InvalidModddel,
                          description: testHelper.getSecondMemberDescription()),
                  ]),
            sampleOptions.lengthValidationPasses
                ? null
                : LengthEntityFailure('This is a length failure')
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
