import 'package:analyzer/dart/analysis/results.dart';
import 'package:checks/checks.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import 'integration/_common.dart';
import 'integration/validation/validation_support.dart';
import 'integration/validation/validation.dart';
import 'integration_test_utils/integration_test_utils.dart';

void main() async {
  final sourcesLibrary =
      await resolveIntegrationImport('validation/validation');
  test(
    'validation/validation file has no issue',
    () async {
      final errorResult = await sourcesLibrary.session.getErrors(
              '/modddels/test/integration_test/integration/validation/validation.dart')
          as ErrorsResult;

      printOnFailure('Errors : ${errorResult.errors}');

      check(errorResult.errors).isEmpty();
    },
    timeout: Timeout(Duration(seconds: 60)),
  );

  group('Feature : Modddel validation\n', () {
    group(
        'Rule : For each validation-step, a matching invalid-step union-case '
        'is generated\n', () {
      group(
          'Scenario Outline : Solo modddel\n'
          '\n'
          'Given a solo modddel with <number_of_vsteps> validationStep(s)\n'
          'When the code is generated\n'
          'Then <number_of_vsteps> matching invalid-step union-case(s) should be generated\n'
          '\n'
          'Examples :\n'
          '| number_of_vsteps |\n', () {
        group('| one              |\n', () {
          final oneVStepSoloTestSupport = OneVStepSoloTestSupport(samples: {
            OneVStepSoloSampleOptions(
              'Example 1',
              lengthValidationPasses: true,
            ): sampleValues,
          });

          oneVStepSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final invalidStepUnionCases =
                testHelper.getAllGeneratedInvalidStepUnionCases(sourcesLibrary);

            testHelper.checkIsOneInvalidVStepClass(invalidStepUnionCases,
                testHelper.invalidStepUnionCasesNames.single);
          });
        });

        group('| two              |\n', () {
          final multipleVStepsSoloTestSupport =
              MultipleVStepsSoloTestSupport(samples: {
            MultipleVStepsSoloSampleOptions(
              'Example 1',
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
          });

          multipleVStepsSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final invalidStepUnionCases =
                testHelper.getAllGeneratedInvalidStepUnionCases(sourcesLibrary);

            testHelper.checkIsMultipleInvalidVStepsClasses(
                invalidStepUnionCases, testHelper.invalidStepUnionCasesNames);
          });
        });
      });

      group(
          'Scenario Outline : SSealed modddel\n'
          '\n'
          'Given a ssealed modddel with <number_of_vsteps> validationStep(s)\n'
          'When the code is generated\n'
          'Then <number_of_vsteps> matching invalid-step ssealed class(es) should be generated\n'
          'And <number_of_vsteps> matching invalid-step union-case(s) should be generated for each case-modddel\n'
          '\n'
          'Examples :\n'
          '| number_of_vsteps |\n', () {
        group('| one              |\n', () {
          final oneVStepSSealedTestSupport =
              OneVStepSSealedTestSupport(samples: {
            OneVStepSSealedSampleOptions(
              'Example 1',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
            ): sampleValues,
          });

          oneVStepSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final modddelInvalidStepUnionCases = testHelper
                .getAllGeneratedModddelInvalidStepUnionCases(sourcesLibrary);

            testHelper.checkIsOneInvalidVStepClass(modddelInvalidStepUnionCases,
                testHelper.modddelInvalidStepUnionCasesNames.single);

            final sSealedInvalidStepsMixins = testHelper
                .getAllGeneratedSSealedInvalidStepsMixins(sourcesLibrary);

            testHelper.checkIsOneInvalidVStepClass(sSealedInvalidStepsMixins,
                testHelper.sSealedInvalidStepsMixinsNames.single);
          });
        });

        group('| two              |\n', () {
          final multipleVStepsSSealedTestSupport =
              MultipleVStepsSSealedTestSupport(samples: {
            MultipleVStepsSSealedSampleOptions(
              'Example 1',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
          });

          multipleVStepsSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final modddelInvalidStepUnionCases = testHelper
                .getAllGeneratedModddelInvalidStepUnionCases(sourcesLibrary);

            testHelper.checkIsMultipleInvalidVStepsClasses(
                modddelInvalidStepUnionCases,
                testHelper.modddelInvalidStepUnionCasesNames);

            final sSealedInvalidStepMixins = testHelper
                .getAllGeneratedSSealedInvalidStepsMixins(sourcesLibrary);

            testHelper.checkIsMultipleInvalidVStepsClasses(
                sSealedInvalidStepMixins,
                testHelper.sSealedInvalidStepsMixinsNames);
          });
        });
      });
    });

    group('Rule : Validation is working\n', () {
      group(
          'Scenario Outline : All validations pass - Solo modddel\n'
          '\n'
          'Given a solo modddel with <number_of_vsteps> validationStep(s)\n'
          'When all validations pass\n'
          'Then the created modddel is an instance of the valid union-case\n'
          'And for both the base modddel and the solo modddel :\n'
          '* Calling the `isValid` getter returns true\n'
          '* Calling the `toEither` getter returns a Right that contains the valid union-case\n'
          '\n'
          'Examples :\n'
          '| number_of_vsteps |\n', () {
        group('| one              |\n', () {
          final oneVStepSoloTestSupport = OneVStepSoloTestSupport(samples: {
            OneVStepSoloSampleOptions(
              'Example 1',
              lengthValidationPasses: true,
            ): sampleValues,
          });

          oneVStepSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            testHelper.checkIsModddelOfType<
                ValidOneVStepSoloSVO,
                ValidOneVStepSoloMVO,
                ValidOneVStepSoloSE,
                ValidOneVStepSoloIE,
                ValidOneVStepSoloI2E>();

            testHelper.checkAllIsValidGettersResults(isModddelValid: true);

            testHelper.checkAllToEitherGettersResults(isModddelValid: true);
          });
        });

        group('| two              |\n', () {
          final multipleVStepsSoloTestSupport =
              MultipleVStepsSoloTestSupport(samples: {
            MultipleVStepsSoloSampleOptions(
              'Example 1',
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
          });

          multipleVStepsSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            testHelper.checkIsModddelOfType<
                ValidMultipleVStepsSoloSVO,
                ValidMultipleVStepsSoloMVO,
                ValidMultipleVStepsSoloSE,
                ValidMultipleVStepsSoloIE,
                ValidMultipleVStepsSoloI2E>();

            testHelper.checkAllIsValidGettersResults(isModddelValid: true);

            testHelper.checkAllToEitherGettersResults(isModddelValid: true);
          });
        });
      });

      group(
          'Scenario Outline : All validations pass - SSealed modddel\n'
          '\n'
          'Given a ssealed modddel with <number_of_vsteps> validationStep(s)\n'
          'When all validations pass\n'
          'Then the created case-modddel is an instance of the case-modddel\'s valid union-case\n'
          'And for the base modddel, the ssealed modddel and the case-modddel :\n'
          '* Calling the `isValid` getter returns true\n'
          '* Calling the `toEither` getter returns a Right that contains the valid union-case\n'
          '\n'
          'Examples :\n'
          '| number_of_vsteps |\n', () {
        group('| one              |\n', () {
          final oneVStepSSealedTestSupport =
              OneVStepSSealedTestSupport(samples: {
            OneVStepSSealedSampleOptions(
              'Example 1 - First factory constructor',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
            ): sampleValues,
            OneVStepSSealedSampleOptions(
              'Example 1 - Second factory constructor',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: true,
            ): sampleValues,
          });

          oneVStepSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final usedFactoryConstructor =
                testHelper.sampleOptions.usedFactoryConstructor;

            switch (usedFactoryConstructor) {
              case FactoryConstructor.first:
                testHelper.checkIsModddelOfType<
                    ValidFirstOneVStepSSealedSVO,
                    ValidFirstOneVStepSSealedMVO,
                    ValidFirstOneVStepSSealedSE,
                    ValidFirstOneVStepSSealedIE,
                    ValidFirstOneVStepSSealedI2E>();

                break;
              case FactoryConstructor.second:
                testHelper.checkIsModddelOfType<
                    ValidSecondOneVStepSSealedSVO,
                    ValidSecondOneVStepSSealedMVO,
                    ValidSecondOneVStepSSealedSE,
                    ValidSecondOneVStepSSealedIE,
                    ValidSecondOneVStepSSealedI2E>();
                break;
            }

            testHelper.checkAllIsValidGettersResults(isModddelValid: true);

            testHelper.checkAllToEitherGettersResults(isModddelValid: true);
          });
        });

        group('| two              |\n', () {
          final multipleVStepsSSealedTestSupport =
              MultipleVStepsSSealedTestSupport(samples: {
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - First factory constructor',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - Second factory constructor',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
          });

          multipleVStepsSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final usedFactoryConstructor =
                testHelper.sampleOptions.usedFactoryConstructor;

            switch (usedFactoryConstructor) {
              case FactoryConstructor.first:
                testHelper.checkIsModddelOfType<
                    ValidFirstMultipleVStepsSSealedSVO,
                    ValidFirstMultipleVStepsSSealedMVO,
                    ValidFirstMultipleVStepsSSealedSE,
                    ValidFirstMultipleVStepsSSealedIE,
                    ValidFirstMultipleVStepsSSealedI2E>();

                break;
              case FactoryConstructor.second:
                testHelper.checkIsModddelOfType<
                    ValidSecondMultipleVStepsSSealedSVO,
                    ValidSecondMultipleVStepsSSealedMVO,
                    ValidSecondMultipleVStepsSSealedSE,
                    ValidSecondMultipleVStepsSSealedIE,
                    ValidSecondMultipleVStepsSSealedI2E>();
                break;
            }

            testHelper.checkAllIsValidGettersResults(isModddelValid: true);

            testHelper.checkAllToEitherGettersResults(isModddelValid: true);
          });
        });
      });

      group(
          'Scenario Outline : One or more validations fail - Solo modddel\n'
          '\n'
          'Given a solo modddel with <number_of_vsteps> validationStep(s)\n'
          'When <failed_validations> of the <vstep_index> validationStep fail(s)\n'
          'Then the created modddel is an instance of the <vstep_index> invalid-step union-case\n'
          'And for both the base modddel and the solo modddel :\n'
          '* Calling the `isValid` getter returns false\n'
          '* Calling the `toEither` getter returns a Left that contains the <vstep_index> invalid-step union-case\n'
          '\n'
          'Examples :\n'
          '| number_of_vsteps | vstep_index | failed_validations    |\n', () {
        group('| one              | only        | the only validation   |\n',
            () {
          final oneVStepSoloTestSupport = OneVStepSoloTestSupport(samples: {
            OneVStepSoloSampleOptions(
              'Example 1',
              lengthValidationPasses: false,
            ): sampleValues,
          });

          oneVStepSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            testHelper.checkIsModddelOfType<
                InvalidOneVStepSoloSVOValue,
                InvalidOneVStepSoloMVOValue,
                InvalidOneVStepSoloSEMid,
                InvalidOneVStepSoloIEMid,
                InvalidOneVStepSoloI2EMid>();

            testHelper.checkAllIsValidGettersResults(isModddelValid: false);

            testHelper.checkAllToEitherGettersResults(isModddelValid: false);
          });
        });

        group('| two              | first       | the only validation   |\n',
            () {
          final multipleVStepsSoloTestSupport =
              MultipleVStepsSoloTestSupport(samples: {
            MultipleVStepsSoloSampleOptions(
              'Example 1 - Next vstep validations pass',
              lengthValidationPasses: false,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSoloSampleOptions(
              'Example 1 - One next vstep validation fails',
              lengthValidationPasses: false,
              formatValidationPasses: false,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSoloSampleOptions(
              'Example 1 - All next vstep validations fail',
              lengthValidationPasses: false,
              formatValidationPasses: false,
              sizeValidationPasses: false,
            ): sampleValues,
          });

          multipleVStepsSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            testHelper.checkIsModddelOfType<
                InvalidMultipleVStepsSoloSVOValue1,
                InvalidMultipleVStepsSoloMVOValue1,
                InvalidMultipleVStepsSoloSEMid,
                InvalidMultipleVStepsSoloIEMid,
                InvalidMultipleVStepsSoloI2EMid>();

            testHelper.checkAllIsValidGettersResults(isModddelValid: false);

            testHelper.checkAllToEitherGettersResults(isModddelValid: false);
          });
        });

        group(
            '| two              | second      | the first validation  |\n'
            '| two              | second      | the second validation |\n'
            '| two              | second      | both validations      |\n', () {
          final multipleVStepsSoloTestSupport =
              MultipleVStepsSoloTestSupport(samples: {
            MultipleVStepsSoloSampleOptions(
              'Example 1',
              lengthValidationPasses: true,
              formatValidationPasses: false,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSoloSampleOptions(
              'Example 2',
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: false,
            ): sampleValues,
            MultipleVStepsSoloSampleOptions(
              'Example 3',
              lengthValidationPasses: true,
              formatValidationPasses: false,
              sizeValidationPasses: false,
            ): sampleValues,
          });

          multipleVStepsSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            testHelper.checkIsModddelOfType<
                InvalidMultipleVStepsSoloSVOValue2,
                InvalidMultipleVStepsSoloMVOValue2,
                InvalidMultipleVStepsSoloSELate,
                InvalidMultipleVStepsSoloIELate,
                InvalidMultipleVStepsSoloI2ELate>();

            testHelper.checkAllIsValidGettersResults(isModddelValid: false);

            testHelper.checkAllToEitherGettersResults(isModddelValid: false);
          });
        });
      });

      group(
          'Scenario Outline : One or more validations fail - SSealed modddel\n'
          '\n'
          'Given a ssealed modddel with <number_of_vsteps> validationStep(s)\n'
          'When <failed_validations> of the <vstep_index> validationStep fail(s)\n'
          'Then the created case-modddel is an instance of the case-modddel\'s <vstep_index> invalid-step union-case\n'
          'And for the base modddel, the ssealed modddel and the case-modddel :\n'
          '* Calling the `isValid` getter returns false\n'
          '* Calling the `toEither` getter returns a Left that contains the <vstep_index> invalid-step union-case\n'
          '\n'
          'Examples :\n'
          '| number_of_vsteps | vstep_index | failed_validations    |\n', () {
        group('| one              | only        | the only validation   |\n',
            () {
          final oneVStepSSealedTestSupport =
              OneVStepSSealedTestSupport(samples: {
            OneVStepSSealedSampleOptions(
              'Example 1 - First factory constructor',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: false,
            ): sampleValues,
            OneVStepSSealedSampleOptions(
              'Example 1 - Second factory constructor',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: false,
            ): sampleValues,
          });

          oneVStepSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final usedFactoryConstructor =
                testHelper.sampleOptions.usedFactoryConstructor;

            switch (usedFactoryConstructor) {
              case FactoryConstructor.first:
                testHelper.checkIsModddelOfType<
                    InvalidFirstOneVStepSSealedSVOValue,
                    InvalidFirstOneVStepSSealedMVOValue,
                    InvalidFirstOneVStepSSealedSEMid,
                    InvalidFirstOneVStepSSealedIEMid,
                    InvalidFirstOneVStepSSealedI2EMid>();

                break;
              case FactoryConstructor.second:
                testHelper.checkIsModddelOfType<
                    InvalidSecondOneVStepSSealedSVOValue,
                    InvalidSecondOneVStepSSealedMVOValue,
                    InvalidSecondOneVStepSSealedSEMid,
                    InvalidSecondOneVStepSSealedIEMid,
                    InvalidSecondOneVStepSSealedI2EMid>();
                break;
            }
            testHelper.checkAllIsValidGettersResults(isModddelValid: false);

            testHelper.checkAllToEitherGettersResults(isModddelValid: false);
          });
        });

        group('| two              | first       | the only validation   |\n',
            () {
          final multipleVStepsSSealedTestSupport =
              MultipleVStepsSSealedTestSupport(samples: {
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - First factory constructor - Next vstep validations pass',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: false,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - Second factory constructor - Next vstep validations pass',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: false,
              formatValidationPasses: true,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - First factory constructor - One next vstep validation fails',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: false,
              formatValidationPasses: false,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - Second factory constructor - One next vstep validation fails',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: false,
              formatValidationPasses: true,
              sizeValidationPasses: false,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - First factory constructor - All next vstep validations fail',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: false,
              formatValidationPasses: false,
              sizeValidationPasses: false,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - Second factory constructor - All next vstep validations fail',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: false,
              formatValidationPasses: false,
              sizeValidationPasses: false,
            ): sampleValues,
          });

          multipleVStepsSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final usedFactoryConstructor =
                testHelper.sampleOptions.usedFactoryConstructor;

            switch (usedFactoryConstructor) {
              case FactoryConstructor.first:
                testHelper.checkIsModddelOfType<
                    InvalidFirstMultipleVStepsSSealedSVOValue1,
                    InvalidFirstMultipleVStepsSSealedMVOValue1,
                    InvalidFirstMultipleVStepsSSealedSEMid,
                    InvalidFirstMultipleVStepsSSealedIEMid,
                    InvalidFirstMultipleVStepsSSealedI2EMid>();

                break;
              case FactoryConstructor.second:
                testHelper.checkIsModddelOfType<
                    InvalidSecondMultipleVStepsSSealedSVOValue1,
                    InvalidSecondMultipleVStepsSSealedMVOValue1,
                    InvalidSecondMultipleVStepsSSealedSEMid,
                    InvalidSecondMultipleVStepsSSealedIEMid,
                    InvalidSecondMultipleVStepsSSealedI2EMid>();
                break;
            }

            testHelper.checkAllIsValidGettersResults(isModddelValid: false);

            testHelper.checkAllToEitherGettersResults(isModddelValid: false);
          });
        });

        group(
            '| two              | second      | the first validation  |\n'
            '| two              | second      | the second validation |\n'
            '| two              | second      | both validations      |\n', () {
          final multipleVStepsSSealedTestSupport =
              MultipleVStepsSSealedTestSupport(samples: {
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - First factory constructor',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
              formatValidationPasses: false,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 1 - Second factory constructor',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: true,
              formatValidationPasses: false,
              sizeValidationPasses: true,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 2 - First factory constructor',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: false,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 2 - Second factory constructor',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: true,
              formatValidationPasses: true,
              sizeValidationPasses: false,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 3 - First factory constructor',
              usedFactoryConstructor: FactoryConstructor.first,
              lengthValidationPasses: true,
              formatValidationPasses: false,
              sizeValidationPasses: false,
            ): sampleValues,
            MultipleVStepsSSealedSampleOptions(
              'Example 3 - Second factory constructor',
              usedFactoryConstructor: FactoryConstructor.second,
              lengthValidationPasses: true,
              formatValidationPasses: false,
              sizeValidationPasses: false,
            ): sampleValues,
          });

          multipleVStepsSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            final usedFactoryConstructor =
                testHelper.sampleOptions.usedFactoryConstructor;

            switch (usedFactoryConstructor) {
              case FactoryConstructor.first:
                testHelper.checkIsModddelOfType<
                    InvalidFirstMultipleVStepsSSealedSVOValue2,
                    InvalidFirstMultipleVStepsSSealedMVOValue2,
                    InvalidFirstMultipleVStepsSSealedSELate,
                    InvalidFirstMultipleVStepsSSealedIELate,
                    InvalidFirstMultipleVStepsSSealedI2ELate>();

                break;
              case FactoryConstructor.second:
                testHelper.checkIsModddelOfType<
                    InvalidSecondMultipleVStepsSSealedSVOValue2,
                    InvalidSecondMultipleVStepsSSealedMVOValue2,
                    InvalidSecondMultipleVStepsSSealedSELate,
                    InvalidSecondMultipleVStepsSSealedIELate,
                    InvalidSecondMultipleVStepsSSealedI2ELate>();
                break;
            }

            testHelper.checkAllIsValidGettersResults(isModddelValid: false);

            testHelper.checkAllToEitherGettersResults(isModddelValid: false);
          });
        });
      });
    });
  });
}
