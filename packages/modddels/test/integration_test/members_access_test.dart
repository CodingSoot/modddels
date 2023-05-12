import 'package:analyzer/dart/analysis/results.dart';
import 'package:checks/checks.dart';
import 'package:test/scaffolding.dart';

import 'integration_test_utils/integration_test_utils.dart';
import 'integration/members_access/members_access.dart';
import 'integration/members_access/members_access_support.dart';

void main() {
  test(
    'members_access/members_access file has no issue',
    () async {
      final library =
          await resolveIntegrationImport('members_access/members_access');

      final errorResult = await library.session.getErrors(
              '/modddels/test/integration_test/integration/members_access/members_access.dart')
          as ErrorsResult;

      printOnFailure('Errors : ${errorResult.errors}');

      check(errorResult.errors).isEmpty();
    },
    timeout: Timeout(Duration(seconds: 60)),
  );

  group('Feature : Modddel instance members access\n', () {
    group('Rule : Accessing instance members of a modddel\n', () {
      group(
          'Scenario : Accessing instance members of a modddel created using '
          'the private constructor throws\n', () {
        group(
            'Given a solo modddel created using the private constructor\n'
            'When I try to access its instance members\n'
            'Then it should throw an error\n', () {
          final privateConstructorSoloTestSupport =
              PrivateConstructorMembersAccessSoloTestSupport(samples: {
            NoSampleOptions('Example'): noParamsSampleValues,
          });

          privateConstructorSoloTestSupport.runTestsForAll((createTestHelper) {
            check(() => createTestHelper()).returnsNormally();

            final testHelper = createTestHelper();

            final modddel = testHelper.testSubject.modddel;

            check(() => modddel.isValid).throws<UnsupportedError>();
            check(() => modddel.toEither).throws<UnsupportedError>();
            check(() => modddel.toBroadEither).throws<UnsupportedError>();
            check(() => modddel.mapValidity(valid: (_) {}, invalid: (_) {}))
                .throws<UnsupportedError>();
            check(() => modddel.props).throws<UnsupportedError>();

            check(() => testHelper.accessParam()).throws<UnsupportedError>();
            check(() => testHelper.accessDependency())
                .throws<Error>()
                .isLateInitializationError();
            check(() => testHelper.accessCopyWith()).throws<UnsupportedError>();
            check(() => testHelper.accessMap()).throws<UnsupportedError>();
            check(() => testHelper.accessMaybeMap()).throws<UnsupportedError>();
            check(() => testHelper.accessMapOrNull())
                .throws<UnsupportedError>();
            check(() => testHelper.accessMaybeMapValidity())
                .throws<UnsupportedError>();
          });
        });

        group(
            'Given a ssealed modddel created using the private constructor\n'
            'When I try to access its instance members\n'
            'Then it should throw an error\n', () {
          final privateConstructorSSealedTestSupport =
              PrivateConstructorMembersAccessSSealedTestSupport(samples: {
            NoSampleOptions('Example'): noParamsSampleValues,
          });

          privateConstructorSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            check(() => createTestHelper()).returnsNormally();

            final testHelper = createTestHelper();

            final modddel = testHelper.testSubject.modddel;

            check(() => modddel.isValid).throws<UnsupportedError>();
            check(() => modddel.toEither).throws<UnsupportedError>();
            check(() => modddel.toBroadEither).throws<UnsupportedError>();
            check(() => modddel.mapValidity(valid: (_) {}, invalid: (_) {}))
                .throws<UnsupportedError>();
            check(() => modddel.props).throws<UnsupportedError>();

            check(() => testHelper.accessParam()).throws<UnsupportedError>();
            check(() => testHelper.accessDependency())
                .throws<UnsupportedError>();
            check(() => testHelper.accessCopyWith()).throws<UnsupportedError>();
            check(() => testHelper.accessMap()).throws<UnsupportedError>();
            check(() => testHelper.accessMaybeMap()).throws<UnsupportedError>();
            check(() => testHelper.accessMapOrNull())
                .throws<UnsupportedError>();
            check(() => testHelper.accessMaybeMapValidity())
                .throws<UnsupportedError>();

            check(() => testHelper.accessMapModddels())
                .throws<UnsupportedError>();
            check(() => testHelper.accessMaybeMapModddels())
                .throws<UnsupportedError>();
            check(() => testHelper.accessMapOrNullModddels())
                .throws<UnsupportedError>();
          });
        });
      });

      group(
          'Scenario : Accessing instance members of a modddel created using '
          'the factory constructor does not throw\n', () {
        group(
            'Given a solo modddel created using the factory constructor\n'
            'When I try to access its instance members\n'
            'Then it should not throw any errors\n', () {
          final factoryConstructorSoloTestSupport =
              FactoryConstructorMembersAccessSoloTestSupport(samples: {
            FactorySampleOptions('Example',
                    validateMethodShouldThrowInfos: false):
                factoryParamsSampleValues,
          });

          factoryConstructorSoloTestSupport.runTestsForAll((createTestHelper) {
            check(() => createTestHelper()).returnsNormally();

            final testHelper = createTestHelper();

            final modddel = testHelper.testSubject.modddel;

            check(() => modddel.isValid).returnsNormally();
            check(() => modddel.toEither).returnsNormally();
            check(() => modddel.toBroadEither).returnsNormally();
            check(() => modddel.mapValidity(valid: (_) {}, invalid: (_) {}))
                .returnsNormally();
            check(() => modddel.props).returnsNormally();

            check(() => testHelper.accessParam()).returnsNormally();
            check(() => testHelper.accessDependency()).returnsNormally();
            check(() => testHelper.accessCopyWith()).returnsNormally();
            check(() => testHelper.accessMap()).returnsNormally();
            check(() => testHelper.accessMaybeMap()).returnsNormally();
            check(() => testHelper.accessMapOrNull()).returnsNormally();
            check(() => testHelper.accessMaybeMapValidity()).returnsNormally();
          });
        });

        group(
            'Given a ssealed modddel created using the factory constructor\n'
            'When I try to access its instance members\n'
            'Then it should not throw any errors\n', () {
          final factoryConstructorSSealedTestSupport =
              FactoryConstructorMembersAccessSSealedTestSupport(samples: {
            FactorySampleOptions(
              'Example',
              validateMethodShouldThrowInfos: false,
            ): factoryParamsSampleValues,
          });

          factoryConstructorSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            check(() => createTestHelper()).returnsNormally();

            final testHelper = createTestHelper();

            final modddel = testHelper.testSubject.modddel;

            check(() => modddel.isValid).returnsNormally();
            check(() => modddel.toEither).returnsNormally();
            check(() => modddel.toBroadEither).returnsNormally();
            check(() => modddel.mapValidity(valid: (_) {}, invalid: (_) {}))
                .returnsNormally();
            check(() => modddel.props).returnsNormally();

            check(() => testHelper.accessParam()).returnsNormally();
            check(() => testHelper.accessDependency()).returnsNormally();
            check(() => testHelper.accessCopyWith()).returnsNormally();
            check(() => testHelper.accessMap()).returnsNormally();
            check(() => testHelper.accessMaybeMap()).returnsNormally();
            check(() => testHelper.accessMapOrNull()).returnsNormally();
            check(() => testHelper.accessMaybeMapValidity()).returnsNormally();

            check(() => testHelper.accessMapModddels()).returnsNormally();
            check(() => testHelper.accessMaybeMapModddels()).returnsNormally();
            check(() => testHelper.accessMapOrNullModddels()).returnsNormally();
          });
        });
      });
    });

    group('Rule : Accessing instance members inside the "validate" methods\n',
        () {
      group(
          'Scenario : Accessing instance members of a modddel inside '
          'the "validate" methods does not throw\n', () {
        group(
            'Given a solo modddel created using the factory constructor\n'
            'When I try to access its instance members inside the "validate" method\n'
            'Then it should throw an error\n', () {
          final factoryConstructorSoloTestSupport =
              FactoryConstructorMembersAccessSoloTestSupport(samples: {
            FactorySampleOptions(
              'Example',
              validateMethodShouldThrowInfos: true,
            ): factoryParamsSampleValues,
          });

          factoryConstructorSoloTestSupport.runTestsForAll((createTestHelper) {
            check(() => createTestHelper())
                .throws<ValidateMethodErrorsInformation>();

            try {
              createTestHelper();
            } on ValidateMethodErrorsInformation catch (e) {
              check(e.instanceErrors).length.equals(12);
              check(e.instanceErrors).values.every(it()..equals(true));
            }
          });
        });

        group(
            'Given a ssealed modddel created using the factory constructor\n'
            'When I try to access its instance members inside the "validate" method\n'
            'Then it should throw an error\n', () {
          final factoryConstructorSSealedTestSupport =
              FactoryConstructorMembersAccessSSealedTestSupport(samples: {
            FactorySampleOptions(
              'Example',
              validateMethodShouldThrowInfos: true,
            ): factoryParamsSampleValues,
          });

          factoryConstructorSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            check(() => createTestHelper())
                .throws<ValidateMethodErrorsInformation>();

            try {
              createTestHelper();
            } on ValidateMethodErrorsInformation catch (e) {
              check(e.instanceErrors).length.equals(15);
              check(e.instanceErrors).values.every(it()..equals(true));
            }
          });
        });
      });

      group(
          'Scenario : Accessing the fields of the "validate" method\'s parameter '
          'does not throw\n', () {
        group(
            'Given a solo modddel created using the factory constructor\n'
            'When I try to access the fields of the "validate" method\'s parameter\n'
            'Then it should not throw any error\n', () {
          final factoryConstructorSoloTestSupport =
              FactoryConstructorMembersAccessSoloTestSupport(samples: {
            FactorySampleOptions(
              'Example',
              validateMethodShouldThrowInfos: true,
            ): factoryParamsSampleValues,
          });

          factoryConstructorSoloTestSupport.runTestsForAll((createTestHelper) {
            check(() => createTestHelper())
                .throws<ValidateMethodErrorsInformation>();

            try {
              createTestHelper();
            } on ValidateMethodErrorsInformation catch (e) {
              check(e.subholderErrors).length.equals(2);
              check(e.subholderErrors).values.every(it()..equals(false));
            }
          });
        });

        group(
            'Given a ssealed modddel created using the factory constructor\n'
            'When I try to access the fields of the "validate" method\'s parameter\n'
            'Then it should not throw any error\n', () {
          final factoryConstructorSSealedTestSupport =
              FactoryConstructorMembersAccessSSealedTestSupport(samples: {
            FactorySampleOptions(
              'Example',
              validateMethodShouldThrowInfos: true,
            ): factoryParamsSampleValues,
          });

          factoryConstructorSSealedTestSupport
              .runTestsForAll((createTestHelper) {
            check(() => createTestHelper())
                .throws<ValidateMethodErrorsInformation>();

            try {
              createTestHelper();
            } on ValidateMethodErrorsInformation catch (e) {
              check(e.subholderErrors).length.equals(5);
              check(e.subholderErrors).values.every(it()..equals(false));
            }
          });
        });
      });
    });
  });
}
