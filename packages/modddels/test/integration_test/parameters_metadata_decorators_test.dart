import 'package:analyzer/dart/analysis/results.dart';
import 'package:test/scaffolding.dart';
import 'package:checks/checks.dart';

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

  // ** Member parameters without withGetter + Dependency parameters

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

  // ** Member parameters with withGetter

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

  group('Feature : Modddel parameters decorators\n', () {
    group(
        'Rule : Shared parameters decorators are not copied in the ssealed related '
        'code sections\n', () {
      group(
          'Scenario : The decorators of a shared member parameter are not copied '
          'in the ssealed related code sections\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'And the parameter is annotated with `@Deprecated` in all case-modddels\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is not copied to ssealed related code sections\n',
            () {
          parametersSharedSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // * topLevel mixin
            final copyWithMethodParam = testHelper
                .getTopLevelCopyWithReturnType(sourcesLibrary)
                .getParameter('param');

            // * valid ssealed mixin
            final validSSealedMixinFieldsInterface = testHelper
                .getSSealedValidMixin(sourcesLibrary)
                .getFieldsInterface()!;

            final validSSealedParamGetter =
                validSSealedMixinFieldsInterface.getGetter('param');

            // * invalid ssealed mixin
            final invalidSSealedMixinFieldsInterface = testHelper
                .getSSealedInvalidMixin(sourcesLibrary)
                .getFieldsInterface()!;

            final invalidSSealedParamGetter =
                invalidSSealedMixinFieldsInterface.getGetter('param');

            // * invalid-step ssealed mixin
            final invalidStepSSealedMixinFieldsInterface = testHelper
                .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 0)
                .getFieldsInterface()!;

            final invalidStepSSealedParamGetter =
                invalidStepSSealedMixinFieldsInterface.getGetter('param');

            // * ssealed subholder class
            final subholderSSealedClass = testHelper.getSSealedSubholderClass(
              sourcesLibrary,
              validationName: 'length',
            );

            final subholderSSealedParamGetter =
                subholderSSealedClass.getGetter('param');

            // * ssealed ModddelParams class
            final modddelParamsSSealedClass =
                testHelper.getSSealedModddelParamsClass(sourcesLibrary);

            final modddelParamsSSealedParamGetter =
                modddelParamsSSealedClass.getGetter('param');

            // *
            for (final param in [
              copyWithMethodParam,
              validSSealedParamGetter,
              invalidSSealedParamGetter,
              invalidStepSSealedParamGetter,
              subholderSSealedParamGetter,
              modddelParamsSSealedParamGetter,
            ]) {
              testHelper.checkElementHasNoDecorators(param);
            }
          });
        });
      });

      group(
          'Scenario : The decorators of a shared member parameter annotated '
          'with `@withGetter` in all case-modddels are not copied in the '
          'ssealed related code sections\n', () {
        group(
            'Given a ssealed modddel with a shared member parameter\n'
            'And the parameter is annotated with `@withGetter` and `@Deprecated` in all case-modddels\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is not copied to ssealed related code sections\n',
            () {
          withGetterParametersSharedSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // * topLevel mixin
            final topLevelMixinParam =
                testHelper.getTopLevelMixin(sourcesLibrary).getGetter('param');

            final copyWithMethodParam = testHelper
                .getTopLevelCopyWithReturnType(sourcesLibrary)
                .getParameter('param');

            // * valid ssealed mixin
            final validSSealedMixinFieldsInterface = testHelper
                .getSSealedValidMixin(sourcesLibrary)
                .getFieldsInterface()!;

            final validSSealedParamGetter =
                validSSealedMixinFieldsInterface.getGetter('param');

            // * invalid ssealed mixin
            final invalidSSealedMixinFieldsInterface = testHelper
                .getSSealedInvalidMixin(sourcesLibrary)
                .getFieldsInterface()!;

            final invalidSSealedParamGetter =
                invalidSSealedMixinFieldsInterface.getGetter('param');

            // * invalid-step ssealed mixin
            final invalidStepSSealedMixinFieldsInterface = testHelper
                .getSSealedInvalidStepMixin(sourcesLibrary, vStepIndex: 0)
                .getFieldsInterface()!;

            final invalidStepSSealedParamGetter =
                invalidStepSSealedMixinFieldsInterface.getGetter('param');

            // * ssealed subholder class
            final subholderSSealedClass = testHelper.getSSealedSubholderClass(
                sourcesLibrary,
                validationName: 'length');

            final subholderSSealedParamGetter =
                subholderSSealedClass.getGetter('param');

            // * ssealed ModddelParams class
            final modddelParamsSSealedClass =
                testHelper.getSSealedModddelParamsClass(sourcesLibrary);

            final modddelParamsSSealedParamGetter =
                modddelParamsSSealedClass.getGetter('param');

            // *
            for (final param in [
              topLevelMixinParam,
              copyWithMethodParam,
              validSSealedParamGetter,
              invalidSSealedParamGetter,
              invalidStepSSealedParamGetter,
              subholderSSealedParamGetter,
              modddelParamsSSealedParamGetter,
            ]) {
              testHelper.checkElementHasNoDecorators(param);
            }
          });
        });
      });

      group(
          'Scenario : The decorators of a shared dependency parameter are not '
          'copied in the ssealed related code sections\n', () {
        group(
            'Given a ssealed modddel with a shared dependency parameter\n'
            'And the parameter is annotated with `@Deprecated` in all case-modddels\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is not copied to ssealed related code sections\n',
            () {
          parametersSharedSSealedTestSupport.runTestsForAll((createTestHelper) {
            final testHelper = createTestHelper();

            // * top-level mixin
            final topLevelMixin = testHelper.getTopLevelMixin(sourcesLibrary);

            final topLevelMixinDependencyGetter =
                topLevelMixin.getGetter('dependency');

            final copyWithMethodDependency = testHelper
                .getTopLevelCopyWithReturnType(sourcesLibrary)
                .getParameter('dependency');

            // * ssealed subholder
            final subholderSSealedClass = testHelper.getSSealedSubholderClass(
                sourcesLibrary,
                validationName: 'length');

            final subholderSSealedDependencyGetter =
                subholderSSealedClass.getGetter('dependency');

            // * ssealed ModddelParams
            final modddelParamsSSealedClass =
                testHelper.getSSealedModddelParamsClass(sourcesLibrary);

            final modddelParamsSSealedDependencyGetter =
                modddelParamsSSealedClass.getGetter('dependency');

            for (final dependency in [
              topLevelMixinDependencyGetter,
              copyWithMethodDependency,
              subholderSSealedDependencyGetter,
              modddelParamsSSealedDependencyGetter,
            ]) {
              testHelper.checkElementHasNoDecorators(dependency);
            }
          });
        });
      });
    });

    group(
        'Rule : Parameters decorators are copied in the appropriate modddel '
        'related code sections\n', () {
      group(
          'Scenario : The decorators of a member parameter are copied in '
          'the appropriate modddel related code sections\n', () {
        group(
            'Given a solo modddel with a member parameter annotated with `@Deprecated`\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is copied to modddel related code sections\n',
            () {
          parametersSoloTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // * topLevel mixin
            final createMethodParam = testHelper
                .getCreateMethod(sourcesLibrary)
                .getParameter('param');

            // TODO: find out why annotations in a FunctionType are ignored by
            // the dart analyzer.

            // final copyWithMethodParam = testHelper
            //     .getTopLevelCopyWithReturnType(sourcesLibrary)
            //     .getParameter('param');

            // * valid union-case class
            final validClass =
                testHelper.getValidUnionCaseClass(sourcesLibrary);

            final validConstructorParam =
                validClass.constructors.single.getParameter('param');

            final validPropertyParam = validClass.getProperty('param');

            // * invalid union-case class
            final invalidClass =
                testHelper.getInvalidAbstractUnionCaseMixin(sourcesLibrary);

            final invalidParamGetter = invalidClass.getGetter('param');

            // * invalid-step union-case class
            final invalidStepClass = testHelper
                .getInvalidStepUnionCaseClass(sourcesLibrary, vStepIndex: 0);

            final invalidStepConstructorParam =
                invalidStepClass.constructors.single.getParameter('param');

            final invalidStepParamProperty =
                invalidStepClass.getProperty('param');

            // * holder class
            final holderClass =
                testHelper.getHolderClass(sourcesLibrary, vStepIndex: 0);

            final holderConstructorParam =
                holderClass.constructors.single.getParameter('param');

            final holderParamProperty = holderClass.getProperty('param');

            // * subholder class
            final subholderClass = testHelper.getSubholderClass(sourcesLibrary,
                validationName: 'length');

            final subholderConstructorParam =
                subholderClass.constructors.single.getParameter('param');

            final subholderParamProperty = subholderClass.getProperty('param');

            // * ModddelParams class
            final modddelParamsClass =
                testHelper.getModddelParamsClass(sourcesLibrary);

            final modddelParamsConstructorParam =
                modddelParamsClass.constructors.single.getParameter('param');

            final modddelParamsParamProperty =
                modddelParamsClass.getProperty('param');

            // *
            for (final param in [
              createMethodParam,
              // copyWithMethodParam,
              validConstructorParam,
              validPropertyParam,
              invalidParamGetter,
              invalidStepConstructorParam,
              invalidStepParamProperty,
              holderConstructorParam,
              holderParamProperty,
              subholderConstructorParam,
              subholderParamProperty,
              modddelParamsConstructorParam,
              modddelParamsParamProperty,
            ]) {
              testHelper.checkElementHasDeprecatedAnnotation(
                  param, 'old param');
            }
          });
        });

        group(
            'Given a ssealed modddel with a member parameter annotated with `@Deprecated` (shared or not)\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is copied to modddel related code sections\n',
            () {
          for (final testSupport in <
              TestSupportBase<
                  SSealedTestHelperMixin<SampleParamsBase, NoSampleOptions>,
                  SampleParamsBase,
                  NoSampleOptions>>[
            parametersNonSharedSSealedTestSupport,
            parametersSharedSSealedTestSupport
          ]) {
            testSupport.runTestsForAll((createTestHelper) {
              final testHelper = createTestHelper();

              // * topLevel mixin
              final createMethodParam = testHelper
                  .getCreateMethod(sourcesLibrary)
                  .getParameter('param');

              // * ssealed ModddelParams
              final ssealedModddelParamsConstructorParam = testHelper
                  .getSSealedModddelParamsCaseModddelConstructor(sourcesLibrary)
                  .getParameter('param');

              // * case-modddel mixin (no fields interface in this case)
              final caseModddelMixinFieldsInterface = testHelper
                  .getBaseCaseModddelMixin(sourcesLibrary)
                  .getFieldsInterface();

              check(caseModddelMixinFieldsInterface).isNull();

              // TODO: find out why annotations in a FunctionType are ignored by
              // the dart analyzer.

              // final caseModddelCopyWithMethodParam = testHelper
              //     .getCaseModddelCopyWithReturnType(sourcesLibrary)
              //     .getParameter('param');

              // * case-modddel valid union-case class
              final modddelValidUnionCase =
                  testHelper.getModddelValidUnionCaseClass(sourcesLibrary);

              final validConstructorParam = modddelValidUnionCase
                  .constructors.single
                  .getParameter('param');

              final validPropertyParam =
                  modddelValidUnionCase.getProperty('param');

              // * case-modddel invalid union-case class
              final modddelInvalidAbstractUnionCaseFieldsInterface = testHelper
                  .getModddelInvalidAbstractUnionCaseMixin(sourcesLibrary)
                  .getFieldsInterface()!;

              final invalidParamGetter =
                  modddelInvalidAbstractUnionCaseFieldsInterface
                      .getGetter('param');

              // * case-modddel invalid-step union-case class
              final modddelInvalidStepUnionCase =
                  testHelper.getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                      vStepIndex: 0);

              final invalidStepConstructorParam = modddelInvalidStepUnionCase
                  .constructors.single
                  .getParameter('param');

              final invalidStepParamProperty =
                  modddelInvalidStepUnionCase.getProperty('param');

              // * case-modddel holder class
              final modddelHolderClass = testHelper
                  .getModddelHolderClass(sourcesLibrary, vStepIndex: 0);

              final holderConstructorParam =
                  modddelHolderClass.constructors.single.getParameter('param');

              final holderParamProperty =
                  modddelHolderClass.getProperty('param');

              // * case-modddel subholder class
              final modddelSubholderClass = testHelper.getModddelSubholderClass(
                  sourcesLibrary,
                  validationName: 'length');

              final subholderConstructorParam = modddelSubholderClass
                  .constructors.single
                  .getParameter('param');

              final subholderParamProperty =
                  modddelSubholderClass.getProperty('param');

              // * case-modddel ModddelParams class
              final modddelModddelParamsClass =
                  testHelper.getModddelModddelParamsClass(sourcesLibrary);

              final modddelParamsConstructorParam = modddelModddelParamsClass
                  .constructors.single
                  .getParameter('param');

              final modddelParamsParamProperty =
                  modddelModddelParamsClass.getProperty('param');

              // *
              for (final param in [
                createMethodParam,
                ssealedModddelParamsConstructorParam,
                // caseModddelCopyWithMethodParam,
                validConstructorParam,
                validPropertyParam,
                invalidParamGetter,
                invalidStepConstructorParam,
                invalidStepParamProperty,
                holderConstructorParam,
                holderParamProperty,
                subholderConstructorParam,
                subholderParamProperty,
                modddelParamsConstructorParam,
                modddelParamsParamProperty,
              ]) {
                testHelper.checkElementHasDeprecatedAnnotation(
                    param, 'old param');
              }
            });
          }
        });
      });

      group(
          'Scenario : The decorators of a member parameter annotated with '
          '`@withGetter` are copied in the appropriate modddel related code sections\n',
          () {
        group(
            'Given a solo modddel with a member parameter annotated with `@withGetter` and `@Deprecated`\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is copied to modddel related code sections\n',
            () {
          withGetterParametersSoloTestSupport
              .runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // * topLevel mixin
            final topLevelMixinGetter =
                testHelper.getTopLevelMixin(sourcesLibrary).getGetter('param');

            final createMethodParam = testHelper
                .getCreateMethod(sourcesLibrary)
                .getParameter('param');

            // TODO: find out why annotations in a FunctionType are ignored by
            // the dart analyzer.

            // final copyWithMethodParam = testHelper
            //     .getTopLevelCopyWithReturnType(sourcesLibrary)
            //     .getParameter('param');

            // * valid union-case class
            final validClass =
                testHelper.getValidUnionCaseClass(sourcesLibrary);

            final validConstructorParam =
                validClass.constructors.single.getParameter('param');

            final validPropertyParam = validClass.getProperty('param');

            // * invalid union-case class
            final invalidClass =
                testHelper.getInvalidAbstractUnionCaseMixin(sourcesLibrary);

            final invalidParamGetter = invalidClass.getGetter('param');

            // * invalid-step union-case class
            final invalidStepClass = testHelper
                .getInvalidStepUnionCaseClass(sourcesLibrary, vStepIndex: 0);

            final invalidStepConstructorParam =
                invalidStepClass.constructors.single.getParameter('param');

            final invalidStepParamProperty =
                invalidStepClass.getProperty('param');

            // * holder class
            final holderClass =
                testHelper.getHolderClass(sourcesLibrary, vStepIndex: 0);

            final holderConstructorParam =
                holderClass.constructors.single.getParameter('param');

            final holderParamProperty = holderClass.getProperty('param');

            // * subholder class
            final subholderClass = testHelper.getSubholderClass(sourcesLibrary,
                validationName: 'length');

            final subholderConstructorParam =
                subholderClass.constructors.single.getParameter('param');

            final subholderParamProperty = subholderClass.getProperty('param');

            // * ModddelParams class
            final modddelParamsClass =
                testHelper.getModddelParamsClass(sourcesLibrary);

            final modddelParamsConstructorParam =
                modddelParamsClass.constructors.single.getParameter('param');

            final modddelParamsParamProperty =
                modddelParamsClass.getProperty('param');

            // *
            for (final param in [
              topLevelMixinGetter,
              createMethodParam,
              // copyWithMethodParam,
              validConstructorParam,
              validPropertyParam,
              invalidParamGetter,
              invalidStepConstructorParam,
              invalidStepParamProperty,
              holderConstructorParam,
              holderParamProperty,
              subholderConstructorParam,
              subholderParamProperty,
              modddelParamsConstructorParam,
              modddelParamsParamProperty,
            ]) {
              testHelper.checkElementHasDeprecatedAnnotation(
                  param, 'old param');
            }
          });
        });

        group(
            'Given a ssealed modddel with a member parameter annotated with `@withGetter` and `@Deprecated` (shared or not)\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is copied to modddel related code sections\n',
            () {
          for (final testSupport in <
              TestSupportBase<
                  SSealedTestHelperMixin<SampleParamsBase, NoSampleOptions>,
                  SampleParamsBase,
                  NoSampleOptions>>[
            withGetterParametersNonSharedSSealedTestSupport,
            withGetterParametersSharedSSealedTestSupport
          ]) {
            testSupport.runTestsForAll((createTestHelper) {
              final testHelper = createTestHelper();

              // * topLevel mixin
              final createMethodParam = testHelper
                  .getCreateMethod(sourcesLibrary)
                  .getParameter('param');

              // * ssealed ModddelParams
              final ssealedModddelParamsConstructorParam = testHelper
                  .getSSealedModddelParamsCaseModddelConstructor(sourcesLibrary)
                  .getParameter('param');

              // * case-modddel mixin
              final caseModddelMixinFieldsInterface = testHelper
                  .getBaseCaseModddelMixin(sourcesLibrary)
                  .getFieldsInterface()!;

              final caseModddelMixinParamGetter =
                  caseModddelMixinFieldsInterface.getGetter('param');

              // TODO: find out why annotations in a FunctionType are ignored by
              // the dart analyzer.

              // final caseModddelCopyWithMethodParam = testHelper
              //     .getCaseModddelCopyWithReturnType(sourcesLibrary)
              //     .getParameter('param');

              // * case-modddel valid union-case class
              final modddelValidUnionCase =
                  testHelper.getModddelValidUnionCaseClass(sourcesLibrary);

              final validConstructorParam = modddelValidUnionCase
                  .constructors.single
                  .getParameter('param');

              final validPropertyParam =
                  modddelValidUnionCase.getProperty('param');

              // * case-modddel invalid union-case class
              final modddelInvalidAbstractUnionCaseFieldsInterface = testHelper
                  .getModddelInvalidAbstractUnionCaseMixin(sourcesLibrary)
                  .getFieldsInterface()!;

              final invalidParamGetter =
                  modddelInvalidAbstractUnionCaseFieldsInterface
                      .getGetter('param');

              // * case-modddel invalid-step union-case class
              final modddelInvalidStepUnionCase =
                  testHelper.getModddelInvalidStepUnionCaseClass(sourcesLibrary,
                      vStepIndex: 0);

              final invalidStepConstructorParam = modddelInvalidStepUnionCase
                  .constructors.single
                  .getParameter('param');

              final invalidStepParamProperty =
                  modddelInvalidStepUnionCase.getProperty('param');

              // * case-modddel holder class
              final modddelHolderClass = testHelper
                  .getModddelHolderClass(sourcesLibrary, vStepIndex: 0);

              final holderConstructorParam =
                  modddelHolderClass.constructors.single.getParameter('param');

              final holderParamProperty =
                  modddelHolderClass.getProperty('param');

              // * case-modddel subholder class
              final modddelSubholderClass = testHelper.getModddelSubholderClass(
                  sourcesLibrary,
                  validationName: 'length');

              final subholderConstructorParam = modddelSubholderClass
                  .constructors.single
                  .getParameter('param');

              final subholderParamProperty =
                  modddelSubholderClass.getProperty('param');

              // * case-modddel ModddelParams class
              final modddelModddelParamsClass =
                  testHelper.getModddelModddelParamsClass(sourcesLibrary);

              final modddelParamsConstructorParam = modddelModddelParamsClass
                  .constructors.single
                  .getParameter('param');

              final modddelParamsParamProperty =
                  modddelModddelParamsClass.getProperty('param');

              // *
              for (final param in [
                createMethodParam,
                ssealedModddelParamsConstructorParam,
                caseModddelMixinParamGetter,
                // caseModddelCopyWithMethodParam,
                validConstructorParam,
                validPropertyParam,
                invalidParamGetter,
                invalidStepConstructorParam,
                invalidStepParamProperty,
                holderConstructorParam,
                holderParamProperty,
                subholderConstructorParam,
                subholderParamProperty,
                modddelParamsConstructorParam,
                modddelParamsParamProperty,
              ]) {
                testHelper.checkElementHasDeprecatedAnnotation(
                    param, 'old param');
              }
            });
          }
        });
      });

      group(
          'Scenario : The decorators of a dependency parameter is copied in '
          'the appropriate modddel related code sections\n', () {
        group(
            'Given a solo modddel with a dependency parameter annotated with `@Deprecated`\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is copied to modddel related code sections\n',
            () {
          parametersSoloTestSupport.runTestsForAll((createTestHelper) async {
            final testHelper = createTestHelper();

            // * topLevel mixin
            final topLevelMixinDependencyProperty = testHelper
                .getTopLevelMixin(sourcesLibrary)
                .getProperty('dependency');

            final createMethodDependency = testHelper
                .getCreateMethod(sourcesLibrary)
                .getParameter('dependency');

            // TODO: find out why annotations in a FunctionType are ignored by
            // the dart analyzer.

            // final copyWithMethodDependency = testHelper
            //     .getTopLevelCopyWithReturnType(sourcesLibrary)
            //     .getParameter('dependency');

            // * subholder class
            final subholderClass = testHelper.getSubholderClass(sourcesLibrary,
                validationName: 'length');

            final subholderDependencyProperty =
                subholderClass.getProperty('dependency');

            // * dependencies class

            final dependenciesClass =
                testHelper.getDependenciesClass(sourcesLibrary);

            final dependenciesConstructorDependency = dependenciesClass
                .constructors.single
                .getParameter('dependency');

            final dependenciesDependencyProperty =
                dependenciesClass.getProperty('dependency');

            // * ModddelParams class
            final modddelParamsClass =
                testHelper.getModddelParamsClass(sourcesLibrary);

            final modddelParamsConstructorDependency = modddelParamsClass
                .constructors.single
                .getParameter('dependency');

            final modddelParamsDependencyProperty =
                modddelParamsClass.getProperty('dependency');

            // *
            for (final dependency in [
              topLevelMixinDependencyProperty,
              createMethodDependency,
              // copyWithMethodDependency,
              subholderDependencyProperty,
              dependenciesConstructorDependency,
              dependenciesDependencyProperty,
              modddelParamsConstructorDependency,
              modddelParamsDependencyProperty,
            ]) {
              testHelper.checkElementHasDeprecatedAnnotation(
                  dependency, 'old dependency');
            }
          });
        });

        group(
            'Given a ssealed modddel with a member parameter annotated with `@withGetter` and `@Deprecated` (shared or not)\n'
            'When the code is generated\n'
            'Then the `@Deprecated` decorator is copied to modddel related code sections\n',
            () {
          for (final testSupport in <
              TestSupportBase<
                  SSealedTestHelperMixin<SampleParamsBase, NoSampleOptions>,
                  SampleParamsBase,
                  NoSampleOptions>>[
            parametersNonSharedSSealedTestSupport,
            parametersSharedSSealedTestSupport
          ]) {
            testSupport.runTestsForAll((createTestHelper) {
              final testHelper = createTestHelper();

              // * topLevel mixin
              final createMethodDependency = testHelper
                  .getCreateMethod(sourcesLibrary)
                  .getParameter('dependency');

              // * ssealed ModddelParams
              final ssealedModddelParamsConstructorDependency = testHelper
                  .getSSealedModddelParamsCaseModddelConstructor(sourcesLibrary)
                  .getParameter('dependency');

              // * case-modddel mixin
              final caseModddelMixinDependencyProperty = testHelper
                  .getBaseCaseModddelMixin(sourcesLibrary)
                  .getProperty('dependency');

              // TODO: find out why annotations in a FunctionType are ignored by
              // the dart analyzer.

              // final caseModddelCopyWithMethodDependency = testHelper
              //     .getCaseModddelCopyWithReturnType(sourcesLibrary)
              //     .getParameter('dependency');

              // * case-modddel subholder class
              final modddelSubholderClass = testHelper.getModddelSubholderClass(
                  sourcesLibrary,
                  validationName: 'length');

              final subholderDependencyProperty =
                  modddelSubholderClass.getProperty('dependency');

              // * case-modddel dependencies class
              final modddelDependenciesClass =
                  testHelper.getModddelDependenciesClass(sourcesLibrary);

              final dependenciesConstructorDependency = modddelDependenciesClass
                  .constructors.single
                  .getParameter('dependency');

              final dependenciesDependencyProperty =
                  modddelDependenciesClass.getProperty('dependency');

              // * case-modddel ModddelParams class
              final modddelModddelParamsClass =
                  testHelper.getModddelModddelParamsClass(sourcesLibrary);

              final modddelParamsConstructorDependency =
                  modddelModddelParamsClass.constructors.single
                      .getParameter('dependency');

              final modddelParamsDependencyProperty =
                  modddelModddelParamsClass.getProperty('dependency');

              // *
              for (final dependency in [
                createMethodDependency,
                ssealedModddelParamsConstructorDependency,
                caseModddelMixinDependencyProperty,
                // caseModddelCopyWithMethodDependency,
                subholderDependencyProperty,
                dependenciesConstructorDependency,
                dependenciesDependencyProperty,
                modddelParamsConstructorDependency,
                modddelParamsDependencyProperty,
              ]) {
                testHelper.checkElementHasDeprecatedAnnotation(
                    dependency, 'old dependency');
              }
            });
          }
        });
      });
    });
  });
}
