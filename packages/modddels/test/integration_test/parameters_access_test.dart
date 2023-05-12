import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:checks/checks.dart';
import 'package:test/scaffolding.dart';

import 'integration_test_utils/integration_test_utils.dart';
import 'integration/parameters_access/parameters_access.dart';
import 'integration/parameters_access/parameters_access_support.dart';

/// NB : We are testing parameters for solo and ssealed classes, but not shared
/// parameters.
///
void main() {
  test(
    'parameters_access file has no issue',
    () async {
      final library =
          await resolveIntegrationImport('parameters_access/parameters_access');

      final errorResult = await library.session.getErrors(
              '/modddels/test/integration_test/integration/parameters_access/parameters_access.dart')
          as ErrorsResult;

      printOnFailure('Errors : ${errorResult.errors}');

      check(errorResult.errors).isEmpty();
    },
    timeout: Timeout(Duration(seconds: 60)),
  );

  group('Feature : Modddel parameters access\n', () {
    group('Rule : Accessing member parameters of a modddel\n', () {
      group(
          'Scenario : Accessing the member parameters of a modddel from the '
          'base modddel class is not possible\n', () {
        group(
            'Given a solo modddel with a member parameter\n'
            'When I try to access the member parameter from the base modddel class\n'
            'Then it should not compile\n', () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example 1',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SampleOptions(
              'Example 2',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            final library = await resolveMain('''
              import 'parameters_access/parameters_access.dart';
              // ignore: unused_import
              import '_common.dart';

              void main(){
                final modddel = ${testHelper.getSampleInstanceInvocationSrc()};

                print(modddel.param);
              }
              ''');

            final errorResult = await library.session.getErrors(
                    '/modddels/test/integration_test/integration/main.dart')
                as ErrorsResult;

            printOnFailure('Errors : ${errorResult.errors}');

            check(errorResult.errors).length.equals(1);

            final error = errorResult.errors.first;

            check(error)
              ..has((error) => error.errorCode.name, 'error code name')
                  .equals('UNDEFINED_GETTER')
              ..has((error) => error.severity, 'severity')
                  .equals(Severity.error);
          });
        });

        group(
            'Given a ssealed modddel with a member parameter\n'
            'When I try to access the member parameter from the base case-modddel class\n'
            'Then it should not compile\n', () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example 1',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SampleOptions(
              'Example 2',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport
              .runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            final library = await resolveMain('''
              import 'parameters_access/parameters_access.dart';
              // ignore: unused_import
              import '_common.dart';

              void main(){
                final modddel = ${testHelper.getSampleInstanceInvocationSrc()};

                final result = modddel.${testHelper.mapModddelsMethodName}(
                  ${testHelper.caseModddelCallbackName} : (caseModddel) => caseModddel.param
                );

                print(result);
              }
              ''');

            final errorResult = await library.session.getErrors(
                    '/modddels/test/integration_test/integration/main.dart')
                as ErrorsResult;

            printOnFailure('Errors : ${errorResult.errors}');

            check(errorResult.errors).length.equals(1);

            final error = errorResult.errors.first;

            check(error)
              ..has((error) => error.errorCode.name, 'error code name')
                  .equals('UNDEFINED_GETTER')
              ..has((error) => error.severity, 'severity')
                  .equals(Severity.error);
          });
        });
      });
      group(
          'Scenario : Accessing the member parameters of a modddel from the '
          'valid union-case is possible\n', () {
        group(
            'Given a valid solo modddel with a member parameter\n'
            'When I try to access the member parameter from the valid union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the valid union-case
            testHelper.checkIsModddelOfType<
                ValidParamsAccessSoloSVO,
                ValidParamsAccessSoloMVO,
                ValidParamsAccessSoloSE,
                ValidParamsAccessSoloIE,
                ValidParamsAccessSoloI2E>();

            final param = testHelper.getParamFromConcreteUnionCase();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });
        group(
            'Given a valid ssealed modddel with a member parameter\n'
            'When I try to access the member parameter from the case-modddel valid union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the case-modddel's valid union-case
            testHelper.checkIsModddelOfType<
                ValidNamedParamsAccessSSealedSVO,
                ValidNamedParamsAccessSSealedMVO,
                ValidNamedParamsAccessSSealedSE,
                ValidNamedParamsAccessSSealedIE,
                ValidNamedParamsAccessSSealedI2E>();

            final param = testHelper.getParamFromCaseModddelConcreteUnionCase();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the member parameters of a modddel from the '
          'abstract invalid union-case and the invalid-step union-case is possible\n',
          () {
        group(
            'Given an invalid solo modddel with a member parameter\n'
            'When I try to access the member parameter :\n'
            '* From the abstract invalid union-case\n'
            '* From the invalid-step union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the abstract invalid union-case
            testHelper.checkIsModddelOfType<
                InvalidParamsAccessSoloSVO,
                InvalidParamsAccessSoloMVO,
                InvalidParamsAccessSoloSE,
                InvalidParamsAccessSoloIE,
                InvalidParamsAccessSoloI2E>();

            // is the invalid-step union-case
            testHelper.checkIsModddelOfType<
                InvalidParamsAccessSoloSVOValue,
                InvalidParamsAccessSoloMVOValue,
                InvalidParamsAccessSoloSEMid,
                InvalidParamsAccessSoloIEMid,
                InvalidParamsAccessSoloI2EMid>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final paramFromAbstract =
                testHelper.getParamFromAbstractInvalidUnionCase();

            final paramFromConcrete =
                testHelper.getParamFromConcreteUnionCase();

            checkEqualsOrDeepEquals(paramFromAbstract, paramInstantiationValue);

            checkEqualsOrDeepEquals(paramFromConcrete, paramInstantiationValue);
          });
        });
        group(
            'Given an invalid ssealed modddel with a member parameter\n'
            'When I try to access the member parameter :\n'
            '* From the case-modddel abstract invalid union-case\n'
            '* From the case-modddel invalid-step union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the case-modddel's abstract invalid union-case
            testHelper.checkIsModddelOfType<
                InvalidNamedParamsAccessSSealedSVO,
                InvalidNamedParamsAccessSSealedMVO,
                InvalidNamedParamsAccessSSealedSE,
                InvalidNamedParamsAccessSSealedIE,
                InvalidNamedParamsAccessSSealedI2E>();

            // is the case-modddel's invalid-step union-case
            testHelper.checkIsModddelOfType<
                InvalidNamedParamsAccessSSealedSVOValue,
                InvalidNamedParamsAccessSSealedMVOValue,
                InvalidNamedParamsAccessSSealedSEMid,
                InvalidNamedParamsAccessSSealedIEMid,
                InvalidNamedParamsAccessSSealedI2EMid>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final paramFromAbstract =
                testHelper.getParamFromCaseModddelAbstractInvalidUnionCase();

            final paramFromConcrete =
                testHelper.getParamFromCaseModddelConcreteUnionCase();

            checkEqualsOrDeepEquals(paramFromAbstract, paramInstantiationValue);

            checkEqualsOrDeepEquals(paramFromConcrete, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the member parameters of a modddel from the '
          'modddel subholder is possible\n', () {
        group(
            'Given a solo modddel with a member parameter\n'
            'When I try to access the member parameter from the subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) {
            check(() => createTestHelper())
                .throws<ValidateMethodParametersInformation>();

            try {
              createTestHelper();
            } on ValidateMethodParametersInformation catch (error) {
              final param = error.parameters['param'];

              final paramInstantiationValue = sampleParams.param.value;

              checkEqualsOrDeepEquals(param, paramInstantiationValue);
            }
          });
        });
        group(
            'Given a ssealed modddel with a member parameter\n'
            'When I try to access the member parameter from the case-modddel subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) {
            check(() => createTestHelper())
                .throws<ValidateMethodParametersInformation>();

            try {
              createTestHelper();
            } on ValidateMethodParametersInformation catch (error) {
              final param = error.parameters['param'];

              final paramInstantiationValue = sampleParams.param.value;

              checkEqualsOrDeepEquals(param, paramInstantiationValue);
            }
          });
        });
      });
    });

    group('Rule : Accessing member parameters annotated with `@withGetter`\n',
        () {
      group(
          'Scenario : Accessing the member parameters annotated with '
          '`@withGetter` from the base modddel class is possible\n', () {
        group(
            'Given a solo modddel with a member parameter annotated with `@withGetter`\n'
            'When I try to access the member parameter from the base modddel class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSoloTestSupport =
              WithGetterParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example 1',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
            SampleOptions(
              'Example 2',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSoloTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the base modddel class
            testHelper.checkIsModddelOfType<
                WithGetterParamsAccessSoloSVO,
                WithGetterParamsAccessSoloMVO,
                WithGetterParamsAccessSoloSE,
                WithGetterParamsAccessSoloIE,
                WithGetterParamsAccessSoloI2E>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final param = testHelper.getParamFromBaseClass();

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });

        group(
            'Given a ssealed modddel with a member parameter annotated with `@withGetter`\n'
            'When I try to access the member parameter from the base case-modddel class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSSealedTestSupport =
              WithGetterParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example 1',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
            SampleOptions(
              'Example 2',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the base case-modddel class
            testHelper.checkIsModddelOfType<
                NamedWithGetterParamsAccessSSealedSVO,
                NamedWithGetterParamsAccessSSealedMVO,
                NamedWithGetterParamsAccessSSealedSE,
                NamedWithGetterParamsAccessSSealedIE,
                NamedWithGetterParamsAccessSSealedI2E>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final param = testHelper.getParamFromCaseModddelBaseClass();

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the member parameters annotated with '
          '`@withGetter` from the valid union-case is possible\n', () {
        group(
            'Given a valid solo modddel with a member parameter annotated with `@withGetter`\n'
            'When I try to access the member parameter from the valid union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSoloTestSupport =
              WithGetterParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSoloTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the valid union-case
            testHelper.checkIsModddelOfType<
                ValidWithGetterParamsAccessSoloSVO,
                ValidWithGetterParamsAccessSoloMVO,
                ValidWithGetterParamsAccessSoloSE,
                ValidWithGetterParamsAccessSoloIE,
                ValidWithGetterParamsAccessSoloI2E>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final param = testHelper.getParamFromConcreteUnionCase();

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });

        group(
            'Given a valid ssealed modddel with a member parameter annotated with `@withGetter`\n'
            'When I try to access the member parameter from the case-modddel valid union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSSealedTestSupport =
              WithGetterParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the case-modddel's valid union-case
            testHelper.checkIsModddelOfType<
                ValidNamedWithGetterParamsAccessSSealedSVO,
                ValidNamedWithGetterParamsAccessSSealedMVO,
                ValidNamedWithGetterParamsAccessSSealedSE,
                ValidNamedWithGetterParamsAccessSSealedIE,
                ValidNamedWithGetterParamsAccessSSealedI2E>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final param = testHelper.getParamFromCaseModddelConcreteUnionCase();

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the member parameters annotated with '
          '`@withGetter` from the abstract invalid union-case and the '
          'invalid-step union-case is possible\n', () {
        group(
            'Given an invalid solo modddel with a member parameter annotated with `@withGetter`\n'
            'When I try to access the member parameter :\n'
            '* From the abstract invalid union-case\n'
            '* From the invalid-step union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSoloTestSupport =
              WithGetterParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSoloTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the abstract invalid union-case
            testHelper.checkIsModddelOfType<
                InvalidWithGetterParamsAccessSoloSVO,
                InvalidWithGetterParamsAccessSoloMVO,
                InvalidWithGetterParamsAccessSoloSE,
                InvalidWithGetterParamsAccessSoloIE,
                InvalidWithGetterParamsAccessSoloI2E>();

            // is the invalid-step union-case
            testHelper.checkIsModddelOfType<
                InvalidWithGetterParamsAccessSoloSVOValue,
                InvalidWithGetterParamsAccessSoloMVOValue,
                InvalidWithGetterParamsAccessSoloSEMid,
                InvalidWithGetterParamsAccessSoloIEMid,
                InvalidWithGetterParamsAccessSoloI2EMid>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final paramFromAbstract =
                testHelper.getParamFromAbstractInvalidUnionCase();

            final paramFromConcrete =
                testHelper.getParamFromConcreteUnionCase();

            checkEqualsOrDeepEquals(paramFromAbstract, paramInstantiationValue);

            checkEqualsOrDeepEquals(paramFromConcrete, paramInstantiationValue);
          });
        });

        group(
            'Given an invalid ssealed modddel with a member parameter annotated with `@withGetter`\n'
            'When I try to access the member parameter :\n'
            '* From the case-modddel abstract invalid union-case\n'
            '* From the case-modddel invalid-step union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSSealedTestSupport =
              WithGetterParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the case-modddel's abstract invalid union-case
            testHelper.checkIsModddelOfType<
                InvalidNamedWithGetterParamsAccessSSealedSVO,
                InvalidNamedWithGetterParamsAccessSSealedMVO,
                InvalidNamedWithGetterParamsAccessSSealedSE,
                InvalidNamedWithGetterParamsAccessSSealedIE,
                InvalidNamedWithGetterParamsAccessSSealedI2E>();

            // is the case-modddel's invalid-step union-case
            testHelper.checkIsModddelOfType<
                InvalidNamedWithGetterParamsAccessSSealedSVOValue,
                InvalidNamedWithGetterParamsAccessSSealedMVOValue,
                InvalidNamedWithGetterParamsAccessSSealedSEMid,
                InvalidNamedWithGetterParamsAccessSSealedIEMid,
                InvalidNamedWithGetterParamsAccessSSealedI2EMid>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final paramFromAbstract =
                testHelper.getParamFromCaseModddelAbstractInvalidUnionCase();

            final paramFromConcrete =
                testHelper.getParamFromCaseModddelConcreteUnionCase();

            checkEqualsOrDeepEquals(paramFromAbstract, paramInstantiationValue);

            checkEqualsOrDeepEquals(paramFromConcrete, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the member parameters annotated with '
          '`@withGetter` from the modddel subholder is possible\n', () {
        group(
            'Given a solo modddel with a member parameter annotated with `@withGetter`\n'
            'When I try to access the member parameter from the subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSoloTestSupport =
              WithGetterParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: true,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSoloTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) {
            check(() => createTestHelper())
                .throws<ValidateMethodParametersInformation>();

            try {
              createTestHelper();
            } on ValidateMethodParametersInformation catch (error) {
              final param = error.parameters['param'];

              final paramInstantiationValue = sampleParams.param.value;

              checkEqualsOrDeepEquals(param, paramInstantiationValue);
            }
          });
        });
        group(
            'Given a ssealed modddel with a member parameter\n'
            'When I try to access the member parameter from the case-modddel subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterParamsAccessSSealedTestSupport =
              WithGetterParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: true,
            ): withGetterSampleValues1,
          });

          withGetterParamsAccessSSealedTestSupport
              .runTestsForAllWithExtraParams(
                  (createTestHelper, sampleOptions, sampleParams) {
            check(() => createTestHelper())
                .throws<ValidateMethodParametersInformation>();

            try {
              createTestHelper();
            } on ValidateMethodParametersInformation catch (error) {
              final param = error.parameters['param'];

              final paramInstantiationValue = sampleParams.param.value;

              checkEqualsOrDeepEquals(param, paramInstantiationValue);
            }
          });
        });
      });
    });

    group('Rule : Accessing dependency parameters of a modddel`\n', () {
      group(
          'Scenario : Accessing the dependency parameters of a modddel from '
          'the base modddel class is possible\n', () {
        group(
            'Given a solo modddel with a dependency parameter\n'
            'When I try to access the dependency parameter from the base modddel class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example 1',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SampleOptions(
              'Example 2',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the base modddel class
            testHelper.checkIsModddelOfType<
                ParamsAccessSoloSVO,
                ParamsAccessSoloMVO,
                ParamsAccessSoloSE,
                ParamsAccessSoloIE,
                ParamsAccessSoloI2E>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependency = testHelper.getDependencyFromBaseClass();

            checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
          });
        });

        group(
            'Given a ssealed modddel with a dependency parameter\n'
            'When I try to access the dependency parameter from the base case-modddel class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example 1',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SampleOptions(
              'Example 2',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the base case-modddel class
            testHelper.checkIsModddelOfType<
                NamedParamsAccessSSealedSVO,
                NamedParamsAccessSSealedMVO,
                NamedParamsAccessSSealedSE,
                NamedParamsAccessSSealedIE,
                NamedParamsAccessSSealedI2E>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependency =
                testHelper.getDependencyFromCaseModddelBaseClass();

            checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the dependency parameters of a modddel from '
          'the valid union-case is possible\n', () {
        group(
            'Given a valid solo modddel with a dependency parameter\n'
            'When I try to access the dependency parameter from the valid union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the valid union-case
            testHelper.checkIsModddelOfType<
                ValidParamsAccessSoloSVO,
                ValidParamsAccessSoloMVO,
                ValidParamsAccessSoloSE,
                ValidParamsAccessSoloIE,
                ValidParamsAccessSoloI2E>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependency = testHelper.getDependencyFromConcreteUnionCase();

            checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
          });
        });

        group(
            'Given a valid ssealed modddel with a dependency parameter\n'
            'When I try to access the dependency parameter from the case-modddel valid union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the case-modddel's valid union-case
            testHelper.checkIsModddelOfType<
                ValidNamedParamsAccessSSealedSVO,
                ValidNamedParamsAccessSSealedMVO,
                ValidNamedParamsAccessSSealedSE,
                ValidNamedParamsAccessSSealedIE,
                ValidNamedParamsAccessSSealedI2E>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependency =
                testHelper.getDependencyFromCaseModddelConcreteUnionCase();

            checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the dependency parameters of a modddel from the '
          'abstract invalid union-case and the invalid-step union-case is possible\n',
          () {
        group(
            'Given an invalid solo modddel with a dependency parameter\n'
            'When I try to access the dependency parameter :\n'
            '* From the abstract invalid union-case\n'
            '* From the invalid-step union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the abstract invalid union-case
            testHelper.checkIsModddelOfType<
                InvalidParamsAccessSoloSVO,
                InvalidParamsAccessSoloMVO,
                InvalidParamsAccessSoloSE,
                InvalidParamsAccessSoloIE,
                InvalidParamsAccessSoloI2E>();

            // is the invalid-step union-case
            testHelper.checkIsModddelOfType<
                InvalidParamsAccessSoloSVOValue,
                InvalidParamsAccessSoloMVOValue,
                InvalidParamsAccessSoloSEMid,
                InvalidParamsAccessSoloIEMid,
                InvalidParamsAccessSoloI2EMid>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependencyFromAbstract =
                testHelper.getDependencyFromAbstractInvalidUnionCase();

            final dependencyFromConcrete =
                testHelper.getDependencyFromConcreteUnionCase();

            checkEqualsOrDeepEquals(
                dependencyFromAbstract, dependencyInstantiationValue);

            checkEqualsOrDeepEquals(
                dependencyFromConcrete, dependencyInstantiationValue);
          });
        });

        group(
            'Given an invalid ssealed modddel with a dependency parameter\n'
            'When I try to access the dependency parameter :'
            '* From the case-modddel abstract invalid union-case\n'
            '* From the case-modddel invalid-step union-case\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: false,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the case-modddel's abstract invalid union-case
            testHelper.checkIsModddelOfType<
                InvalidNamedParamsAccessSSealedSVO,
                InvalidNamedParamsAccessSSealedMVO,
                InvalidNamedParamsAccessSSealedSE,
                InvalidNamedParamsAccessSSealedIE,
                InvalidNamedParamsAccessSSealedI2E>();

            // is the case-modddel's invalid-step union-case
            testHelper.checkIsModddelOfType<
                InvalidNamedParamsAccessSSealedSVOValue,
                InvalidNamedParamsAccessSSealedMVOValue,
                InvalidNamedParamsAccessSSealedSEMid,
                InvalidNamedParamsAccessSSealedIEMid,
                InvalidNamedParamsAccessSSealedI2EMid>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependencyFromAbstract = testHelper
                .getDependencyFromCaseModddelAbstractInvalidUnionCase();

            final dependencyFromConcrete =
                testHelper.getDependencyFromCaseModddelConcreteUnionCase();

            checkEqualsOrDeepEquals(
                dependencyFromAbstract, dependencyInstantiationValue);

            checkEqualsOrDeepEquals(
                dependencyFromConcrete, dependencyInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the dependency parameters of a modddel from the '
          'modddel subholder is possible\n', () {
        group(
            'Given a solo modddel with a dependency parameter\n'
            'When I try to access the dependency parameter from the subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSoloTestSupport =
              ParamsAccessSoloTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSoloTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) {
            check(() => createTestHelper())
                .throws<ValidateMethodParametersInformation>();

            try {
              createTestHelper();
            } on ValidateMethodParametersInformation catch (error) {
              final dependency = error.parameters['dependency'];

              final dependencyInstantiationValue =
                  sampleParams.dependency.value;

              checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
            }
          });
        });
        group(
            'Given a ssealed modddel with a member parameter\n'
            'When I try to access the member parameter from the case-modddel subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final paramsAccessSSealedTestSupport =
              ParamsAccessSSealedTestSupport(samples: {
            SampleOptions(
              'Example',
              isModddelValid: true,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1,
          });

          paramsAccessSSealedTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) {
            check(() => createTestHelper())
                .throws<ValidateMethodParametersInformation>();

            try {
              createTestHelper();
            } on ValidateMethodParametersInformation catch (error) {
              final dependency = error.parameters['dependency'];

              final dependencyInstantiationValue =
                  sampleParams.dependency.value;

              checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
            }
          });
        });
      });
    });
  });
}
