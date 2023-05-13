import 'package:analyzer/dart/analysis/results.dart';
import 'package:test/scaffolding.dart';
import 'package:checks/checks.dart';
// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import 'integration/parameters_metadata/parameters_metadata_support.dart';
import 'integration_test_utils/integration_test_utils.dart';

void main() async {
  final sourcesLibrary =
      await resolveIntegrationImport('parameters_metadata/parameters_metadata');

  test(
    'parameters_metadata/parameters_metadata file has no issue',
    () async {
      final errorResult = await sourcesLibrary.session.getErrors(
              '/modddels/test/integration_test/integration/parameters_metadata/parameters_metadata.dart')
          as ErrorsResult;

      printOnFailure('Errors : ${errorResult.errors}');

      check(errorResult.errors).isEmpty();
    },
    timeout: Timeout(Duration(seconds: 60)),
  );

  // Member parameters without withGetter + Dependency parameters

  final parametersSoloTestSupport = ParametersSoloTestSupport(
    samples: {NoSampleOptions('Example'): withoutGetterSampleValues1},
  );

  final parametersNonSharedSSealedTestSupport =
      ParametersNonSharedSSealedTestSupport(
    samples: {NoSampleOptions('Example'): withoutGetterSampleValues1},
  );

  final parametersSharedSSealedTestSupport = ParametersSharedSSealedTestSupport(
    samples: {NoSampleOptions('Example'): withoutGetterSampleValues1},
  );

  // Member parameters with withGetter

  final withGetterParametersSoloTestSupport =
      WithGetterParametersSoloTestSupport(
    samples: {NoSampleOptions('Example'): withGetterSampleValues1},
  );

  final withGetterParametersNonSharedSSealedTestSupport =
      WithGetterParametersNonSharedSSealedTestSupport(
    samples: {NoSampleOptions('Example'): withGetterSampleValues1},
  );

  final withGetterParametersSharedSSealedTestSupport =
      WithGetterParametersSharedSSealedTestSupport(
    samples: {NoSampleOptions('Example'): withGetterSampleValues1},
  );

  group('Feature : Modddel parameters documentation\n', () {
    group(
        'Rule : Shared parameters documentation is not copied in the ssealed related '
        'classes\n', () {
      group(
          'Scenario : The documentation of a shared member parameter is not copied '
          'in the ssealed related classes\n', () {
        group(
            'Given a ssealed modddel with a shared documented member parameter\n'
            'When the code is generated\n'
            'Then the documentation is not copied to ssealed related classes\n',
            () {
          parametersSharedSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // top-level mixin getter (inexistant here)
            final topLevelMixinParam =
                testHelper.getTopLevelMixin(sourcesLibrary).getGetter('param');

            check(topLevelMixinParam).isNull();

            // valid ssealed mixin getter (in FieldsInterface)
            final validSSealedParam = testHelper
                .getSSealedValidMixin(sourcesLibrary)
                .getFieldsInterface()!
                .getGetter('param');

            // invalid ssealed mixin getter (in FieldsInterface)
            final invalidSSealedParam = testHelper
                .getSSealedInvalidMixin(sourcesLibrary)
                .getFieldsInterface()!
                .getGetter('param');

            // invalid-step ssealed mixin getter (in FieldsInterface)
            final invalidStepSSealedParam = testHelper
                .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 0)
                .getFieldsInterface()!
                .getGetter('param');

            // ssealed subholder getter
            final subholderSSealedParam = testHelper
                .getSSealedSubholderClass(sourcesLibrary,
                    validationName: 'length')
                .getGetter('param');

            // ssealed ModddelParams getter
            final modddelParamsSSealedParam = testHelper
                .getSSealedModddelParamsClass(sourcesLibrary)
                .getGetter('param');

            for (final param in [
              validSSealedParam,
              invalidSSealedParam,
              invalidStepSSealedParam,
              subholderSSealedParam,
              modddelParamsSSealedParam,
            ]) {
              testHelper.checkElementHasNoDocs(param);
            }
          });
        });
      });

      group(
          'Scenario : The documentation of a shared member parameter annotated '
          'with `@withGetter` in all case-modddels is not copied in the '
          'ssealed related classes\n', () {
        group(
            'Given a ssealed modddel with a shared documented member parameter\n'
            'And the parameter is annotated with `@withGetter` in all case-modddels\n'
            'When the code is generated\n'
            'Then the documentation is not copied to ssealed related classes\n',
            () {
          withGetterParametersSharedSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // top-level mixin getter
            final topLevelMixinParam =
                testHelper.getTopLevelMixin(sourcesLibrary).getGetter('param');

            // valid ssealed mixin getter (in FieldsInterface)
            final validSSealedParam = testHelper
                .getSSealedValidMixin(sourcesLibrary)
                .getFieldsInterface()!
                .getGetter('param');

            // invalid ssealed mixin getter (in FieldsInterface)
            final invalidSSealedParam = testHelper
                .getSSealedInvalidMixin(sourcesLibrary)
                .getFieldsInterface()!
                .getGetter('param');

            // invalid-step ssealed mixin getter (in FieldsInterface)
            final invalidStepSSealedParam = testHelper
                .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 0)
                .getFieldsInterface()!
                .getGetter('param');

            // ssealed subholder getter
            final subholderSSealedParam = testHelper
                .getSSealedSubholderClass(sourcesLibrary,
                    validationName: 'length')
                .getGetter('param');

            // ssealed ModddelParams getter
            final modddelParamsSSealedParam = testHelper
                .getSSealedModddelParamsClass(sourcesLibrary)
                .getGetter('param');

            for (final param in [
              topLevelMixinParam,
              validSSealedParam,
              invalidSSealedParam,
              invalidStepSSealedParam,
              subholderSSealedParam,
              modddelParamsSSealedParam,
            ]) {
              testHelper.checkElementHasNoDocs(param);
            }
          });
        });
      });

      group(
          'Scenario : The documentation of a shared dependency parameter is not '
          'copied in the ssealed related classes\n', () {
        group(
            'Given a ssealed modddel with a shared documented dependency parameter\n'
            'When the code is generated\n'
            'Then the documentation is not copied to ssealed related classes\n',
            () {
          parametersSharedSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // top-level mixin getter
            final topLevelMixinDependency = testHelper
                .getTopLevelMixin(sourcesLibrary)
                .getGetter('dependency');

            // ssealed subholder getter
            final subholderSSealedDependency = testHelper
                .getSSealedSubholderClass(sourcesLibrary,
                    validationName: 'length')
                .getGetter('dependency');

            // ssealed ModddelParams getter
            final modddelParamsSSealedDependency = testHelper
                .getSSealedModddelParamsClass(sourcesLibrary)
                .getGetter('dependency');

            for (final dependency in [
              topLevelMixinDependency,
              subholderSSealedDependency,
              modddelParamsSSealedDependency,
            ]) {
              testHelper.checkElementHasNoDocs(dependency);
            }
          });
        });
      });
    });

    group(
        'Rule : Parameters documentation is copied in the appropriate modddel '
        'related classes\n', () {
      group(
          'Scenario : The documentation of a member parameter is copied in '
          'the appropriate modddel related classes\n', () {
        group(
            'Given a solo modddel with a documented member parameter\n'
            'When the code is generated\n'
            'Then the documentation is copied to :\n'
            '* The valid union-case\n'
            '* The abstract invalid union-case\n'
            '* The subholder\n'
            'And is not copied in other modddel related classes\n', () {
          parametersSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // valid union-case property
            final validUnionCaseParam = testHelper
                .getValidUnionCaseClass(sourcesLibrary)
                .getProperty('param');

            // invalid abstract union-case getter
            final invalidAbstractUnionCaseParam = testHelper
                .getInvalidAbstractUnionCaseMixin(sourcesLibrary)
                .getGetter('param');

            // subholder property
            final subholderParam = testHelper
                .getSubholderClass(sourcesLibrary, validationName: 'length')
                .getProperty('param');

            for (final param in [
              validUnionCaseParam,
              invalidAbstractUnionCaseParam,
              subholderParam
            ]) {
              testHelper.checkElementHasDocs(
                  param,
                  '/// The very long multiline comment\n'
                  '/// for member parameter');
            }

            // top-level mixin getter (inexistant here)
            final topLevelMixinParam =
                testHelper.getTopLevelMixin(sourcesLibrary).getGetter('param');

            check(topLevelMixinParam).isNull();

            // invalid-step union-case property
            final invalidStepUnionCaseParam = testHelper
                .getInvalidStepUnionCaseClass(sourcesLibrary, vStepIndex: 0)
                .getProperty('param');

            // holder property
            final holderParam = testHelper
                .getHolderClass(sourcesLibrary, vStepIndex: 0)
                .getProperty('param');

            // modddel params class property
            final modddelParamsParam = testHelper
                .getModddelParamsClass(sourcesLibrary)
                .getProperty('param');

            for (final param in [
              invalidStepUnionCaseParam,
              holderParam,
              modddelParamsParam
            ]) {
              testHelper.checkElementHasNoDocs(param);
            }
          });
        });

        group(
            'Given a ssealed modddel with a documented member parameter (shared or not)\n'
            'When the code is generated\n'
            'Then the documentation is copied to :\n'
            '* The case-modddel valid union-case\n'
            '* The case-modddel abstract invalid union-case\n'
            '* The case-modddel subholder\n'
            'And is not copied in other case-modddel related classes\n', () {
          for (final testSupport in <TestSupportBase<
              SSealedTestHelperMixin<SampleParamsBase, NoSampleOptions>,
              SampleParamsBase,
              NoSampleOptions>>[
            parametersNonSharedSSealedTestSupport,
            parametersSharedSSealedTestSupport
          ]) {
            testSupport.runTestsForAll((createTestHelper) {
              final testHelper = createTestHelper();

              // case-modddel valid union-case property
              final modddelValidUnionCaseParam = testHelper
                  .getModddelValidUnionCaseClass(sourcesLibrary)
                  .getProperty('param');

              // case-modddel invalid abstract union-case getter (in
              // FieldsInterface)
              final modddelInvalidAbstractUnionCaseParam = testHelper
                  .getModddelInvalidAbstractUnionCaseMixin(sourcesLibrary)
                  .getFieldsInterface()!
                  .getGetter('param');

              // case-modddel subholder property
              final modddelSubholderParam = testHelper
                  .getModddelSubholderClass(sourcesLibrary,
                      validationName: 'length')
                  .getProperty('param');

              for (final param in [
                modddelValidUnionCaseParam,
                modddelInvalidAbstractUnionCaseParam,
                modddelSubholderParam
              ]) {
                testHelper.checkElementHasDocs(
                    param,
                    '/// The very long multiline comment\n'
                    '/// for member parameter');
              }

              // base case-modddel mixin getter (inexistant here, and thus no
              // FieldsInterface)
              final caseModddelMixinFieldsInterface = testHelper
                  .getBaseCaseModddelMixin(sourcesLibrary)
                  .getFieldsInterface();

              check(caseModddelMixinFieldsInterface).isNull();

              // case-modddel invalid-step union-case property
              final modddelInvalidStepUnionCaseParam = testHelper
                  .getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                      vStepIndex: 0)
                  .getProperty('param');

              // holder property
              final modddelHolderParam = testHelper
                  .getModddelHolderClass(sourcesLibrary, vStepIndex: 0)
                  .getProperty('param');

              // modddel params class property
              final modddelModddelParamsParam = testHelper
                  .getModddelModddelParamsClass(sourcesLibrary)
                  .getProperty('param');

              for (final param in [
                modddelInvalidStepUnionCaseParam,
                modddelHolderParam,
                modddelModddelParamsParam
              ]) {
                testHelper.checkElementHasNoDocs(param);
              }
            });
          }
        });
      });

      group(
          'Scenario : The documentation of a member parameter annotated with '
          '`@withGetter` is copied in the appropriate modddel related classes\n',
          () {
        group(
            'Given a solo modddel with a documented member parameter annotated with `@withGetter`\n'
            'When the code is generated\n'
            'Then the documentation is copied to :\n'
            '* The top-level mixin\n'
            '* The subholder\n'
            'And is not copied in other modddel related classes\n', () {
          withGetterParametersSoloTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();
            // top-level mixin getter
            final topLevelMixinParam =
                testHelper.getTopLevelMixin(sourcesLibrary).getGetter('param');

            // subholder property
            final subholderParam = testHelper
                .getSubholderClass(sourcesLibrary, validationName: 'length')
                .getProperty('param');

            for (final param in [topLevelMixinParam, subholderParam]) {
              testHelper.checkElementHasDocs(
                  param, '/// This is a comment for a "withGetter" param');
            }

            // valid union-case property
            final validUnionCaseParam = testHelper
                .getValidUnionCaseClass(sourcesLibrary)
                .getProperty('param');

            // invalid abstract union-case getter
            final invalidAbstractUnionCaseParam = testHelper
                .getInvalidAbstractUnionCaseMixin(sourcesLibrary)
                .getGetter('param');

            // invalid-step union-case property
            final invalidStepUnionCaseParam = testHelper
                .getInvalidStepUnionCaseClass(sourcesLibrary, vStepIndex: 0)
                .getProperty('param');

            // holder property
            final holderParam = testHelper
                .getHolderClass(sourcesLibrary, vStepIndex: 0)
                .getProperty('param');

            // modddel params class property
            final modddelParamsParam = testHelper
                .getModddelParamsClass(sourcesLibrary)
                .getProperty('param');

            for (final param in [
              validUnionCaseParam,
              invalidAbstractUnionCaseParam,
              invalidStepUnionCaseParam,
              holderParam,
              modddelParamsParam
            ]) {
              testHelper.checkElementHasNoDocs(param);
            }
          });
        });
        group(
            'Given a ssealed modddel with a documented member parameter (shared or not)\n'
            'And the parameter is annotated with `@withGetter` in all case-modddels\n'
            'When the code is generated\n'
            'Then the documentation is copied to :\n'
            '* The base case-modddel mixin\n'
            '* The case-modddel subholder\n'
            'And is not copied in other case-modddel related classes\n', () {
          for (final testSupport in <TestSupportBase<
              SSealedTestHelperMixin<SampleParamsBase, NoSampleOptions>,
              SampleParamsBase,
              NoSampleOptions>>[
            withGetterParametersNonSharedSSealedTestSupport,
            withGetterParametersSharedSSealedTestSupport
          ]) {
            testSupport.runTestsForAll((createTestHelper) {
              final testHelper = createTestHelper();

              // base case-modddel mixin getter
              final caseModddelMixinFieldsInterface = testHelper
                  .getBaseCaseModddelMixin(sourcesLibrary)
                  .getFieldsInterface()!
                  .getGetter('param');

              // case-modddel subholder property
              final modddelSubholderParam = testHelper
                  .getModddelSubholderClass(sourcesLibrary,
                      validationName: 'length')
                  .getProperty('param');

              for (final param in [
                caseModddelMixinFieldsInterface,
                modddelSubholderParam
              ]) {
                testHelper.checkElementHasDocs(
                    param, '/// This is a comment for a "withGetter" param');
              }

              // case-modddel valid union-case property
              final modddelValidUnionCaseParam = testHelper
                  .getModddelValidUnionCaseClass(sourcesLibrary)
                  .getProperty('param');

              // case-modddel invalid abstract union-case getter (in
              // FieldsInterface)
              final modddelInvalidAbstractUnionCaseParam = testHelper
                  .getModddelInvalidAbstractUnionCaseMixin(sourcesLibrary)
                  .getFieldsInterface()!
                  .getGetter('param');

              // case-modddel invalid-step union-case property
              final modddelInvalidStepUnionCaseParam = testHelper
                  .getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                      vStepIndex: 0)
                  .getProperty('param');

              // holder property
              final modddelHolderParam = testHelper
                  .getModddelHolderClass(sourcesLibrary, vStepIndex: 0)
                  .getProperty('param');

              // modddel params class property
              final modddelModddelParamsParam = testHelper
                  .getModddelModddelParamsClass(sourcesLibrary)
                  .getProperty('param');

              for (final param in [
                modddelValidUnionCaseParam,
                modddelInvalidAbstractUnionCaseParam,
                modddelInvalidStepUnionCaseParam,
                modddelHolderParam,
                modddelModddelParamsParam
              ]) {
                testHelper.checkElementHasNoDocs(param);
              }
            });
          }
        });
      });

      group(
          'Scenario : The documentation of a dependency parameter is copied in '
          'the appropriate modddel related classes\n', () {
        group(
            'Given a solo modddel with a documented dependency parameter`\n'
            'When the code is generated\n'
            'Then the documentation is copied to :\n'
            '* The top-level mixin\n'
            '* The subholder\n'
            'And is not copied in other modddel related classes\n', () {
          parametersSoloTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // top-level mixin property
            final topLevelMixinDependency = testHelper
                .getTopLevelMixin(sourcesLibrary)
                .getProperty('dependency');

            // subholder property
            final subholderDependency = testHelper
                .getSubholderClass(sourcesLibrary, validationName: 'length')
                .getProperty('dependency');

            for (final dependency in [
              topLevelMixinDependency,
              subholderDependency
            ]) {
              testHelper.checkElementHasDocs(
                  dependency, '/// The comment for a dependency parameter');
            }

            // dependency class property
            final dependenciesClassDependency = testHelper
                .getDependenciesClass(sourcesLibrary)
                .getProperty('dependency');

            // modddel params class property
            final modddelParamsDependency = testHelper
                .getModddelParamsClass(sourcesLibrary)
                .getProperty('dependency');

            for (final param in [
              dependenciesClassDependency,
              modddelParamsDependency,
            ]) {
              testHelper.checkElementHasNoDocs(param);
            }
          });
        });

        group(
            'Given a ssealed modddel with a documented dependency parameter (shared or not)\n'
            'When the code is generated\n'
            'Then the documentation is copied to :\n'
            '* The base case-modddel mixin\n'
            '* The case-modddel subholder\n'
            'And is not copied in other case-modddel related classes\n', () {
          for (final testSupport in <TestSupportBase<
              SSealedTestHelperMixin<SampleParamsBase, NoSampleOptions>,
              SampleParamsBase,
              NoSampleOptions>>[
            parametersNonSharedSSealedTestSupport,
            parametersSharedSSealedTestSupport
          ]) {
            testSupport.runTestsForAll((createTestHelper) {
              final testHelper = createTestHelper();

              // base case-modddel mixin property
              final caseModddelMixinDependency = testHelper
                  .getBaseCaseModddelMixin(sourcesLibrary)
                  .getProperty('dependency');

              // case-modddel subholder property
              final modddelSubholderDependency = testHelper
                  .getModddelSubholderClass(sourcesLibrary,
                      validationName: 'length')
                  .getProperty('dependency');

              for (final dependency in [
                caseModddelMixinDependency,
                modddelSubholderDependency
              ]) {
                testHelper.checkElementHasDocs(
                    dependency, '/// The comment for a dependency parameter');
              }

              // dependencies class property
              final modddelDependenciesClassDependency = testHelper
                  .getModddelDependenciesClass(sourcesLibrary)
                  .getProperty('dependency');

              // modddel params class property
              final modddelModddelParamsDependency = testHelper
                  .getModddelModddelParamsClass(sourcesLibrary)
                  .getProperty('dependency');

              for (final dependency in [
                modddelDependenciesClassDependency,
                modddelModddelParamsDependency
              ]) {
                testHelper.checkElementHasNoDocs(dependency);
              }
            });
          }
        });
      });
    });
  });
}
