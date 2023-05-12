import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:checks/checks.dart';
import 'package:test/scaffolding.dart';

import 'integration/_common.dart';
import 'integration/shared_parameters_access/shared_parameters_access.dart';
import 'integration/shared_parameters_access/shared_parameters_access_support.dart';
import 'integration_test_utils/integration_test_utils.dart';

void main() {
  test(
    'shared_parameters_access file has no issue',
    () async {
      final library = await resolveIntegrationImport(
          'shared_parameters_access/shared_parameters_access');

      final errorResult = await library.session.getErrors(
              '/modddels/test/integration_test/integration/shared_parameters_access/shared_parameters_access.dart')
          as ErrorsResult;

      printOnFailure('Errors : ${errorResult.errors}');

      check(errorResult.errors).isEmpty();
    },
    timeout: Timeout(Duration(seconds: 60)),
  );

  group('Feature : Shared parameters access\n', () {
    group('Rule : Accessing shared member parameters\n', () {
      group(
          'Scenario : Accessing non-shared member parameters from the ssealed '
          'classes (base - valid - invalid - invalid-step and subholder) is not '
          'possible\n', () {
        group(
            'Given a ssealed modddel with a non-shared member parameter\n'
            'When I try to access the member parameter :\n'
            '* From the base ssealed class\n'
            '* From the valid ssealed class\n'
            '* From the invalid ssealed class\n'
            '* From the invalid-step ssealed class\n'
            '* From the subholder ssealed class (in the validate method)\n'
            'Then it should not compile\n', () {
          final nonSharedTestSupport =
              NonSharedParamsAccessTestSupport(samples: {
            NonSharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
            ): withoutGetterSampleValues1,
            NonSharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
            ): withoutGetterSampleValues1
          });

          nonSharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            final sSealedName = testHelper.sSealedName;

            final invalidStepCallbackName =
                testHelper.getInvalidStepCallbackName(0);

            final library = await resolveMain('''
              import 'shared_parameters_access/shared_parameters_access.dart';
              // ignore: unused_import
              import '_common.dart';

              void main(){
                final modddel = ${testHelper.getSampleInstanceInvocationSrc()};

                final result1 = modddel.param;

                final result2 = modddel.map(
                  valid: (valid) => valid.param,
                  $invalidStepCallbackName: ($invalidStepCallbackName) => $invalidStepCallbackName.param,
                );

                final result3 = modddel.mapValidity(
                  valid: (valid) => valid.param,
                  invalid: (invalid) => invalid.param,
                );

                print('\$result1 - \$result2 - \$result3');
              }

              mixin MyMixin on $sSealedName {
                @override
                validateLength(subholder) {
                  print(subholder.param);
                  return super.validateLength(subholder);
                }
              }
              ''');

            final errorResult = await library.session.getErrors(
                    '/modddels/test/integration_test/integration/main.dart')
                as ErrorsResult;

            printOnFailure('errors ${errorResult.errors}');

            final errors = errorResult.errors;

            check(errors).length.equals(6);

            check(errors).every(it()
              ..has((error) => error.errorCode.name, 'error code name')
                  .equals('UNDEFINED_GETTER')
              ..has((error) => error.severity, 'severity')
                  .equals(Severity.error));
          });
        });
      });

      group(
          'Scenario : Accessing the shared member parameters from the base '
          'ssealed class is not possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'When I try to access the member parameter from the base ssealed class\n'
            'Then it should not compile\n', () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1
          });

          sharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            final library = await resolveMain('''
              import 'shared_parameters_access/shared_parameters_access.dart';
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
      });

      group(
          'Scenario : Accessing the shared member parameters from the valid '
          'ssealed class is possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'When I try to access the member parameter from the valid ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1
          });

          sharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // is the valid ssealed class
            testHelper.checkIsModddelOfType<
                ValidSharedParamsAccessSVO,
                ValidSharedParamsAccessMVO,
                ValidSharedParamsAccessSE,
                ValidSharedParamsAccessIE,
                ValidSharedParamsAccessI2E>();

            final param =
                testHelper.getParamFromValidOrInvalidStepSSealedClass();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared member parameters from the invalid '
          'ssealed class and the invalid-step ssealed class is possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'When I try to access the member parameter :\n'
            '* From the invalid ssealed class\n'
            '* From the invalid-step ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          sharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // is the invalid ssealed class
            testHelper.checkIsModddelOfType<
                InvalidSharedParamsAccessSVO,
                InvalidSharedParamsAccessMVO,
                InvalidSharedParamsAccessSE,
                InvalidSharedParamsAccessIE,
                InvalidSharedParamsAccessI2E>();

            // is the invalid-step ssealed class
            testHelper.checkIsModddelOfType<
                InvalidSharedParamsAccessSVOValue,
                InvalidSharedParamsAccessMVOValue,
                InvalidSharedParamsAccessSEMid,
                InvalidSharedParamsAccessIEMid,
                InvalidSharedParamsAccessI2EMid>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final paramFromInvalid =
                testHelper.getParamFromInvalidSSealedClass();

            final paramFromInvalidStep =
                testHelper.getParamFromValidOrInvalidStepSSealedClass();

            checkEqualsOrDeepEquals(paramFromInvalid, paramInstantiationValue);

            checkEqualsOrDeepEquals(
                paramFromInvalidStep, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared member parameters from the ssealed '
          'subholder (in the validate method) is possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'When I try to access the member parameter from the ssealed subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1
          });

          sharedTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) async {
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

    group(
        'Rule : Accessing shared member parameters annotated with `@withGetter` '
        'in all case-modddels\n', () {
      group(
          'Scenario : Accessing non-shared member parameters annotated with '
          '`@withGetter` in all case-modddels from the ssealed classes (base - '
          'valid - invalid - invalid-step and subholder) is not possible\n',
          () {
        group(
            'Given a ssealed modddel with a non-shared member parameter`\n'
            'And the parameter is annotated with `@withGetter` in all case-modddels\n'
            'When I try to access the member parameter :\n'
            '* From the base ssealed class\n'
            '* From the valid ssealed class\n'
            '* From the invalid ssealed class\n'
            '* From the invalid-step ssealed class\n'
            '* From the subholder ssealed class (in the validate method)\n'
            'Then it should not compile\n', () {
          final withGetterNonSharedTestSupport =
              WithGetterNonSharedParamsAccessTestSupport(samples: {
            NonSharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
            ): withGetterSampleValues1,
            NonSharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
            ): withGetterSampleValues1,
          });

          withGetterNonSharedTestSupport
              .runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            final sSealedName = testHelper.sSealedName;
            final invalidStepCallbackName =
                testHelper.getInvalidStepCallbackName(0);

            final library = await resolveMain('''
              import 'shared_parameters_access/shared_parameters_access.dart';
              // ignore: unused_import
              import '_common.dart';

              void main(){
                final modddel = ${testHelper.getSampleInstanceInvocationSrc()};

                final result1 = modddel.param;

                final result2 = modddel.map(
                  valid: (valid) => valid.param,
                  $invalidStepCallbackName: ($invalidStepCallbackName) => $invalidStepCallbackName.param,
                );

                final result3 = modddel.mapValidity(
                  valid: (valid) => valid.param,
                  invalid: (invalid) => invalid.param,
                );

                print('\$result1 - \$result2 - \$result3');
              }

              mixin MyMixin on $sSealedName {
                @override
                validateLength(subholder) {
                  print(subholder.param);
                  return super.validateLength(subholder);
                }
              }
              ''');

            final errorResult = await library.session.getErrors(
                    '/modddels/test/integration_test/integration/main.dart')
                as ErrorsResult;

            printOnFailure('errors ${errorResult.errors}');

            final errors = errorResult.errors;

            check(errors).length.equals(6);

            check(errors).every(it()
              ..has((error) => error.errorCode.name, 'error code name')
                  .equals('UNDEFINED_GETTER')
              ..has((error) => error.severity, 'severity')
                  .equals(Severity.error));
          });
        });
      });

      group(
          'Scenario : Accessing the shared member parameters annotated with '
          '`@withGetter` in all case-modddels from the base ssealed class '
          'is possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'And the parameter is annotated with `@withGetter` in all case-modddels\n'
            'When I try to access the member parameter from the base ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterSharedTestSupport =
              WithGetterSharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterSharedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // is the base ssealed class
            testHelper.checkIsModddelOfType<
                WithGetterSharedParamsAccessSVO,
                WithGetterSharedParamsAccessMVO,
                WithGetterSharedParamsAccessSE,
                WithGetterSharedParamsAccessIE,
                WithGetterSharedParamsAccessI2E>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final param = testHelper.getParamFromBaseSSealedClass();

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared member parameters annotated with '
          '`@withGetter` in all case-modddels from the valid ssealed class '
          'is possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'And the parameter is annotated with `@withGetter` in all case-modddels\n'
            'When I try to access the member parameter from the valid ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterSharedTestSupport =
              WithGetterSharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterSharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // is the valid ssealed class
            testHelper.checkIsModddelOfType<
                ValidWithGetterSharedParamsAccessSVO,
                ValidWithGetterSharedParamsAccessMVO,
                ValidWithGetterSharedParamsAccessSE,
                ValidWithGetterSharedParamsAccessIE,
                ValidWithGetterSharedParamsAccessI2E>();

            final param =
                testHelper.getParamFromValidOrInvalidStepSSealedClass();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            checkEqualsOrDeepEquals(param, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared member parameters annotated with '
          '`@withGetter` in all case-modddels from the invalid ssealed class '
          'and the invalid-step ssealed class is possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'When I try to access the member parameter :\n'
            '* From the invalid ssealed class\n'
            '* From the invalid-step ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterSharedTestSupport =
              WithGetterSharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withGetterSampleValues1,
          });

          withGetterSharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // is the invalid ssealed class
            testHelper.checkIsModddelOfType<
                InvalidWithGetterSharedParamsAccessSVO,
                InvalidWithGetterSharedParamsAccessMVO,
                InvalidWithGetterSharedParamsAccessSE,
                InvalidWithGetterSharedParamsAccessIE,
                InvalidWithGetterSharedParamsAccessI2E>();

            // is the invalid-step ssealed class
            testHelper.checkIsModddelOfType<
                InvalidWithGetterSharedParamsAccessSVOValue,
                InvalidWithGetterSharedParamsAccessMVOValue,
                InvalidWithGetterSharedParamsAccessSEMid,
                InvalidWithGetterSharedParamsAccessIEMid,
                InvalidWithGetterSharedParamsAccessI2EMid>();

            final paramInstantiationValue = testHelper.sampleParams.param.value;

            final paramFromInvalid =
                testHelper.getParamFromInvalidSSealedClass();

            final paramFromInvalidStep =
                testHelper.getParamFromValidOrInvalidStepSSealedClass();

            checkEqualsOrDeepEquals(paramFromInvalid, paramInstantiationValue);

            checkEqualsOrDeepEquals(
                paramFromInvalidStep, paramInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared member parameters annotated with '
          '`@withGetter` in all case-modddels from the ssealed subholder '
          '(in the validate method) is possible\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'And the parameter is annotated with `@withGetter` in all case-modddels\n'
            'When I try to access the member parameter from the ssealed subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final withGetterSharedTestSupport =
              WithGetterSharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: true,
            ): withGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: true,
            ): withGetterSampleValues1
          });

          withGetterSharedTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) async {
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

    group('Rule : Accessing shared dependency parameters\n', () {
      group(
          'Scenario : Accessing non-shared dependency parameters from the '
          'ssealed classes (base - valid - invalid - invalid-step and subholder) '
          'is not possible\n', () {
        group(
            'Given a ssealed modddel with a non-shared dependency parameter\n'
            'When I try to access the dependency parameter\n'
            '* From the base ssealed class\n'
            '* From the valid ssealed class\n'
            '* From the invalid ssealed class\n'
            '* From the invalid-step ssealed class\n'
            '* From the subholder ssealed class (in the validate method)\n'
            'Then it should not compile\n', () {
          final nonSharedTestSupport =
              NonSharedParamsAccessTestSupport(samples: {
            NonSharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
            ): withoutGetterSampleValues1,
            NonSharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
            ): withoutGetterSampleValues1,
          });

          nonSharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            final sSealedName = testHelper.sSealedName;
            final invalidStepCallbackName =
                testHelper.getInvalidStepCallbackName(0);

            final library = await resolveMain('''
              import 'shared_parameters_access/shared_parameters_access.dart';
              // ignore: unused_import
              import '_common.dart';

              void main(){
                final modddel = ${testHelper.getSampleInstanceInvocationSrc()};

              final result1 = modddel.dependency;

              final result2 = modddel.map(
                valid: (valid) => valid.dependency,
                $invalidStepCallbackName: ($invalidStepCallbackName) => $invalidStepCallbackName.dependency,
              );

              final result3 = modddel.mapValidity(
                valid: (valid) => valid.dependency,
                invalid: (invalid) => invalid.dependency,
              );

              print('\$result1 - \$result2 - \$result3');
              }

              mixin MyMixin on $sSealedName {
                @override
                validateLength(subholder) {
                  print(subholder.param);
                  return super.validateLength(subholder);
                }
              }
              ''');

            final errorResult = await library.session.getErrors(
                    '/modddels/test/integration_test/integration/main.dart')
                as ErrorsResult;

            printOnFailure('errors ${errorResult.errors}');

            final errors = errorResult.errors;

            check(errors).length.equals(6);

            check(errors).every(it()
              ..has((error) => error.errorCode.name, 'error code name')
                  .equals('UNDEFINED_GETTER')
              ..has((error) => error.severity, 'severity')
                  .equals(Severity.error));
          });
        });
      });

      group(
          'Scenario : Accessing the shared dependency parameters from the base '
          'ssealed class is possible\n', () {
        group(
            'Given a ssealed modddel with a shared dependency parameter\n'
            'When I try to access the dependency parameter from the base ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          sharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // is the base ssealed class
            testHelper.checkIsModddelOfType<
                SharedParamsAccessSVO,
                SharedParamsAccessMVO,
                SharedParamsAccessSE,
                SharedParamsAccessIE,
                SharedParamsAccessI2E>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependency = testHelper.getDependencyFromBaseSSealedClass();

            checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared dependency parameters from the valid '
          'ssealed class is possible\n', () {
        group(
            'Given a ssealed modddel with a shared dependency parameter\n'
            'When I try to access the dependency parameter from the valid ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          sharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // is the valid ssealed class
            testHelper.checkIsModddelOfType<
                ValidSharedParamsAccessSVO,
                ValidSharedParamsAccessMVO,
                ValidSharedParamsAccessSE,
                ValidSharedParamsAccessIE,
                ValidSharedParamsAccessI2E>();

            final dependency =
                testHelper.getDependencyFromValidOrInvalidStepSSealedClass();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            checkEqualsOrDeepEquals(dependency, dependencyInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared dependency parameters from the invalid '
          'ssealed class and the invalid-step ssealed class is possible\n', () {
        group(
            'Given a ssealed modddel with a shared dependency parameter\n'
            'When I try to access the dependency parameter :\n'
            '* From the invalid ssealed class\n'
            '* From the invalid-step ssealed class\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: false,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: false,
            ): withoutGetterSampleValues1,
          });

          sharedTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // is the invalid ssealed class
            testHelper.checkIsModddelOfType<
                InvalidSharedParamsAccessSVO,
                InvalidSharedParamsAccessMVO,
                InvalidSharedParamsAccessSE,
                InvalidSharedParamsAccessIE,
                InvalidSharedParamsAccessI2E>();

            // is the invalid-step ssealed class
            testHelper.checkIsModddelOfType<
                InvalidSharedParamsAccessSVOValue,
                InvalidSharedParamsAccessMVOValue,
                InvalidSharedParamsAccessSEMid,
                InvalidSharedParamsAccessIEMid,
                InvalidSharedParamsAccessI2EMid>();

            final dependencyInstantiationValue =
                testHelper.sampleParams.dependency.value;

            final dependencyFromInvalid =
                testHelper.getDependencyFromInvalidSSealedClass();

            final dependencyFromInvalidStep =
                testHelper.getDependencyFromValidOrInvalidStepSSealedClass();

            checkEqualsOrDeepEquals(
                dependencyFromInvalid, dependencyInstantiationValue);

            checkEqualsOrDeepEquals(
                dependencyFromInvalidStep, dependencyInstantiationValue);
          });
        });
      });

      group(
          'Scenario : Accessing the shared dependency parameters from the ssealed '
          'subholder (in the validate method) is possible\n', () {
        group(
            'Given a ssealed modddel with a shared dependency parameter\n'
            'When I try to access the dependency parameter from the ssealed subholder\n'
            'Then it is accessible\n'
            'And the accessed parameter value matches its instantiation value\n',
            () {
          final sharedTestSupport = SharedParamsAccessTestSupport(samples: {
            SharedSampleOptions(
              'First factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.first,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1,
            SharedSampleOptions(
              'Second factory constructor',
              isModddelValid: true,
              usedFactoryConstructor: FactoryConstructor.second,
              validateMethodShouldThrowInfos: true,
            ): withoutGetterSampleValues1
          });

          sharedTestSupport.runTestsForAllWithExtraParams(
              (createTestHelper, sampleOptions, sampleParams) async {
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
