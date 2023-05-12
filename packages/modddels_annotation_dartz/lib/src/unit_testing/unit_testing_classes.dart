import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:modddels_annotation_dartz/src/modddels/base_modddel.dart';
import 'package:modddels_annotation_dartz/src/unit_testing/base_tester.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:test/test.dart';

/* -------------------------------------------------------------------------- */
/*                                    Tests                                   */
/* -------------------------------------------------------------------------- */

/// The base class for all Test kinds.
///
abstract class BaseTest<M extends BaseModddel<I, V>, I extends InvalidModddel,
    V extends ValidModddel> {
  /// The Tester that created this test.
  ///
  BaseTester get _tester;

  /// Formats the [object]'s string representation according to
  /// [maxTestInfoLength] :
  ///
  /// - If it's a positive integer : Returns the object's `toString` after being
  ///   ellipsized if its number of characters exceeds [maxTestInfoLength].
  /// - If it equals [Modddel.noMaxLength] : Returns the object's `toString`
  ///   without any changes.
  ///
  String _format(Object? object, int? maxTestInfoLength) {
    final maxLength = maxTestInfoLength ?? _tester.maxTestInfoLength;
    if (!(maxLength > 0 || maxLength == Modddel.noMaxLength)) {
      throw ArgumentError.value(maxLength,
          'The [maxTestInfoLength] should be > 0 or should equal Modddel.noMaxLength');
    }
    if (maxLength == Modddel.noMaxLength) {
      return object.toString();
    }
    return ellipsize(object.toString(), maxLength: maxLength);
  }
}

/* ------------------------------- Test Kinds ------------------------------- */

/// A [ValidTest] is a callable class that tests that a modddel [M], when
/// instantiated with the given [ModddelParams], is valid.
///
class ValidTest<M extends BaseModddel<I, V>, I extends InvalidModddel,
    V extends ValidModddel> extends BaseTest<M, I, V> {
  ValidTest(this._tester);

  @override
  final BaseTester _tester;

  void call(
    ModddelParams<M> params, {
    int? maxTestInfoLength,
    String? testOn,
    Timeout? timeout,
    dynamic skip,
    dynamic tags,
    Map<String, dynamic>? onPlatform,
    int? retry,
  }) {
    final className = params._className;
    final validClassName = 'Valid$className';

    final steps = [
      'Given a $className ${params._modddelKind}',
      'When instantiated with ${_format(params, maxTestInfoLength)}',
      'Then the $className is a $validClassName',
    ];

    final description = steps.join('\n');

    test(
      description,
      () {
        final modddel = params.toModddel();
        expect(modddel, isA<V>());
        expect(modddel.isValid, true);
      },
      testOn: testOn,
      timeout: timeout,
      skip: skip,
      tags: tags,
      onPlatform: onPlatform,
      retry: retry,
    );
  }
}

/// A [SanitizedTest] is a callable class that tests that a modddel [M], when
/// instantiated with the given [ModddelParams], holds the `sanitizedParams`.
///
class SanitizedTest<M extends BaseModddel<I, V>, I extends InvalidModddel,
    V extends ValidModddel> extends BaseTest<M, I, V> {
  SanitizedTest(this._tester);

  @override
  final BaseTester _tester;

  void call(
    ModddelParams<M> params, {
    required ModddelParams<M> sanitizedParams,
    int? maxTestInfoLength,
    String? testOn,
    Timeout? timeout,
    dynamic skip,
    dynamic tags,
    Map<String, dynamic>? onPlatform,
    int? retry,
  }) {
    final className = params._className;

    final steps = [
      'Given a $className ${params._modddelKind}',
      'When instantiated with ${_format(params, maxTestInfoLength)}',
      'Then the $className holds ${_format(sanitizedParams, maxTestInfoLength)}',
    ];

    final description = steps.join('\n');

    test(
      description,
      () {
        expect(params.sanitizedParams, sanitizedParams);
      },
      testOn: testOn,
      timeout: timeout,
      skip: skip,
      tags: tags,
      onPlatform: onPlatform,
      retry: retry,
    );
  }
}

/// This is the superclass of "InvalidStep" tests.
///
/// An [InvalidStepTest] is a callable class that tests that a modddel [M], when
/// instantiated with the given [ModddelParams], is an instance of the
/// invalid-step union-case matching the validation step, and holds the given
/// failures.
///
abstract class InvalidStepTest<
    M extends BaseModddel<I, V>,
    I extends InvalidModddel,
    V extends ValidModddel> extends BaseTest<M, I, V> {
  InvalidStepTest(this._tester, {required String vStepName})
      : _vStepName = vStepName;

  @override
  final BaseTester _tester;

  final String _vStepName;

  /// Returns the "Given-When-Then" gherkin steps, which are common between all
  /// "InvalidStep" tests.
  ///
  @protected
  List<String> $getCommonSteps(
    ModddelParams<M> params,
    int? maxTestInfoLength,
  ) {
    final className = params._className;
    final invalidStepClassName = 'Invalid$className$_vStepName';

    return [
      'Given a $className ${params._modddelKind}',
      'When instantiated with ${_format(params, maxTestInfoLength)}',
      'Then the $className is an $invalidStepClassName',
    ];
  }

  /// Returns the "And" gherkin step that represents whether the modddel is
  /// supposed to hold the failure named [failureName] or not.
  ///
  @protected
  String $hasFailureStep(
      String failureName, Failure? failure, int? maxTestInfoLength) {
    if (failure == null) {
      return 'And has no $failureName';
    }
    return 'And has a $failureName that equals "${_format(failure, maxTestInfoLength)}"';
  }
}

/* -------------------------------------------------------------------------- */
/*                                Modddel Params                               */
/* -------------------------------------------------------------------------- */

/// This is the base class of all ModddelParams.
///
/// A [ModddelParams] represents the parameters of a modddel [M].
///
abstract class ModddelParams<M extends BaseModddel> extends Equatable {
  const ModddelParams({
    required String modddelKind,
    required String className,
  })  : _modddelKind = modddelKind,
        _className = className;

  /// The name of the modddel.
  ///
  /// Example : `Rainy`
  ///
  final String _className;

  /// The modddel kind.
  ///
  /// Example : `MultiValueObject`
  ///
  final String _modddelKind;

  /// Returns a modddel instantiated with the parameters represented by this
  /// [ModddelParams].
  M toModddel();

  /// Returns the [ModddelParams] which represents the parameters that are held
  /// by the modddel after being instantiated with the parameters represented by
  /// this [ModddelParams].
  ///
  ModddelParams<M> get sanitizedParams;
}
