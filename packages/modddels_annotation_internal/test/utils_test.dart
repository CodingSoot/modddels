import 'package:checks/checks.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Feature : Ellipsize\n', () {
    group('Rule : The string is ellipsized when longer than maxLength\n', () {
      group('Scenario : String is ellipsized without the ellipsis count\n', () {
        test(
            'Given the string "Hello there !"\n'
            'When it is ellipsized to 6 characters\n'
            'And the ellipsis count is disabled\n'
            'Then it equals "Hello…"\n', () {
          final string = 'Hello there !';
          final ellipsized =
              ellipsize(string, maxLength: 6, showEllipsisCount: false);
          check(ellipsized).equals('Hello…');
        });

        /// Special characters
        test(
            'Given the string with special characters "Hëllò there !"\n'
            'When it is ellipsized to 6 characters\n'
            'And the ellipsis count is disabled\n'
            'Then it equals "Hëllò…"\n', () {
          final string = 'Hëllò there !';
          final ellipsized =
              ellipsize(string, maxLength: 6, showEllipsisCount: false);
          check(ellipsized).equals('Hëllò…');
        });

        /// Multiline string
        test(
            'Given the multiline string "Hello\\n there !"\n'
            'When it is ellipsized to 10 characters\n'
            'And the ellipsis count is disabled\n'
            'Then it equals "Hello\\n th…"\n', () {
          final string = 'Hello\n there !';
          final ellipsized =
              ellipsize(string, maxLength: 10, showEllipsisCount: false);
          check(ellipsized).equals('Hello\n th…');
        });
      });
      group('Scenario : String is ellipsized with the ellipsis count\n', () {
        test(
            'Given the string "Hello there !"\n'
            'When it is ellipsized to 9 characters\n'
            'And the ellipsis count is enabled\n'
            'Then it equals "He… (+11)"\n', () {
          final string = 'Hello there !';
          final ellipsized =
              ellipsize(string, maxLength: 9, showEllipsisCount: true);
          check(ellipsized).equals('He… (+11)');
        });

        test(
            'Given the string "Hello there !"\n'
            'When it is ellipsized to 6 characters\n'
            'And the ellipsis count is enabled\n'
            'Then it equals "… (+13)"\n', () {
          final string = 'Hello there !';
          final ellipsized =
              ellipsize(string, maxLength: 6, showEllipsisCount: true);
          check(ellipsized).equals('… (+13)');
        });
      });
    });

    group(
        'Rule : The string is not ellipsized when same length or shorter than maxLength\n',
        () {
      group('Scenario : String is not ellipsized\n', () {
        test(
            'Given the string "Hello there !"\n'
            'When it is ellipsized to 13 characters\n'
            'Then it stays unchanged\n', () {
          final string = 'Hello there !';
          final ellipsized =
              ellipsize(string, maxLength: 13, showEllipsisCount: false);
          check(ellipsized).equals(string);

          final ellipsized2 =
              ellipsize(string, maxLength: 13, showEllipsisCount: true);
          check(ellipsized2).equals(string);
        });

        test(
            'Given the string "Hello there !"\n'
            'When it is ellipsized to 20 characters\n'
            'Then it stays unchanged\n', () {
          final string = 'Hello there !';
          final ellipsized =
              ellipsize(string, maxLength: 20, showEllipsisCount: false);
          check(ellipsized).equals(string);

          final ellipsized2 =
              ellipsize(string, maxLength: 20, showEllipsisCount: true);
          check(ellipsized2).equals(string);
        });
      });
    });
  });
}
