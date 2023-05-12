// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../integration_test_utils/integration_test_utils.dart';

part '_common.modddel.dart';

/* -------------------------------------------------------------------------- */
/*                                  Failures                                  */
/* -------------------------------------------------------------------------- */

class SizeValueFailure extends ValueFailure {
  SizeValueFailure([this.message]);

  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SizeValueFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class SizeEntityFailure extends EntityFailure {
  SizeEntityFailure([this.message]);

  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SizeEntityFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class LengthValueFailure extends ValueFailure {
  LengthValueFailure([this.message]);

  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LengthValueFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class LengthEntityFailure extends EntityFailure {
  LengthEntityFailure([this.message]);

  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LengthEntityFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class FormatValueFailure extends ValueFailure {
  FormatValueFailure([this.message]);

  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormatValueFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class FormatEntityFailure extends EntityFailure {
  FormatEntityFailure([this.message]);

  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormatEntityFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

/* -------------------------------------------------------------------------- */
/*                                Dependencies                                */
/* -------------------------------------------------------------------------- */

class MyService {
  MyService([this.isActive = false, this.details = '']);

  final bool isActive;

  final String details;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyService &&
        other.isActive == isActive &&
        other.details == details;
  }

  @override
  int get hashCode => isActive.hashCode ^ details.hashCode;
}

/* -------------------------------------------------------------------------- */
/*                                 Modddels                                   */
/* -------------------------------------------------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class MyModddel extends SingleValueObject<InvalidMyModddel, ValidMyModddel>
    with _$MyModddel {
  MyModddel._();

  factory MyModddel({
    required String param,
    @dependencyParam required MyService dependency,
  }) {
    return _$MyModddel._create(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(myModddel) {
    if (myModddel.param.isEmpty) {
      return some(LengthValueFailure());
    }
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class CustomModddel
    extends SingleValueObject<InvalidCustomModddel, ValidCustomModddel>
    with _$CustomModddel {
  CustomModddel._();

  factory CustomModddel({
    required String param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$CustomModddel._create(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(customModddel) {
    return customModddel.$isModddelValid
        ? none()
        : some(LengthValueFailure('Custom modddel has invalid length'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('size', FailureType<SizeValueFailure>())])
])
class AlwaysValidModddel extends SingleValueObject<InvalidAlwaysValidModddel,
    ValidAlwaysValidModddel> with _$AlwaysValidModddel {
  AlwaysValidModddel._();

  factory AlwaysValidModddel({
    required int param,
  }) {
    return _$AlwaysValidModddel._create(
      param: param,
    );
  }

  @override
  Option<SizeValueFailure> validateSize(alwaysValidModddel) {
    return none();
  }
}

/* -------------------------------------------------------------------------- */
/*                                Sample Values                               */
/* -------------------------------------------------------------------------- */

/// Sample values where the [MyModddel] is used for [paramModddel],
/// [paramListModddel] and [paramMapModddel].
///
/// NB : [MyModddel] is valid because [paramString] isn't an empty string.
///
abstract class SampleValues1 {
  static const paramString = ParamWithSource('Dash', "'Dash'");

  static final paramModddel = ParamWithSource(
    MyModddel(param: paramString.value, dependency: dependency.value),
    'MyModddel(param: ${paramString.src}, dependency: ${dependency.src})',
  );

  static final paramListModddel =
      ParamWithSource([paramModddel.value], '[${paramModddel.src}]');

  static final paramMapModddel = ParamWithSource(
      {paramModddel.value: paramModddel.value},
      '{${paramModddel.src}: ${paramModddel.src}}');

  static final dependency =
      ParamWithSource(MyService(true, 'Bird'), "MyService(true, 'Bird')");
}

/// Sample values where the [MyModddel] is used for [paramModddel],
/// [paramListModddel] and [paramMapModddel].
///
/// NB : [MyModddel] is invalid because [paramString] is an empty string.
///
abstract class SampleValues2 {
  static const paramString = ParamWithSource('', "''");

  static final paramModddel = ParamWithSource(
    MyModddel(param: paramString.value, dependency: dependency.value),
    'MyModddel(param: ${paramString.src}, dependency: ${dependency.src})',
  );

  static final paramListModddel =
      ParamWithSource([paramModddel.value], '[${paramModddel.src}]');

  static final paramMapModddel = ParamWithSource(
      {paramModddel.value: paramModddel.value},
      '{${paramModddel.src}: ${paramModddel.src}}');

  static final dependency =
      ParamWithSource(MyService(false, 'Nature'), "MyService(false, 'Nature')");
}

/// Sample values where the [CustomModddel] is used for [getParamModddel],
/// [getParamListModddel] and [getParamMapModddel].
///
/// The [CustomModddel] can either be valid or not using `shouldBeValid`.
///
abstract class CustomSampleValues {
  static const paramString = ParamWithSource('Dash', "'Dash'");

  static ParamWithSource<CustomModddel> getParamModddel(
          {required bool shouldBeValid}) =>
      ParamWithSource(
        CustomModddel(param: paramString.value, $isModddelValid: shouldBeValid),
        'CustomModddel(param: ${paramString.src}, \$isModddelValid: $shouldBeValid)',
      );

  static ParamWithSource<List<CustomModddel>> getParamListModddel(
      {required bool shouldBeValid}) {
    final paramModddel = getParamModddel(shouldBeValid: shouldBeValid);

    return ParamWithSource([paramModddel.value], '[${paramModddel.src}]');
  }

  static ParamWithSource<Map<CustomModddel, CustomModddel>> getParamMapModddel(
      {required bool shouldBeValid}) {
    final paramModddel = getParamModddel(shouldBeValid: shouldBeValid);

    return ParamWithSource({paramModddel.value: paramModddel.value},
        '{${paramModddel.src}: ${paramModddel.src}}');
  }
}

/// Sample values where the [AlwaysValidModddel] is used for [paramModddel],
/// [paramListModddel] and [paramMapModddel].
///
abstract class AlwaysValidSampleValues {
  static const paramInt = ParamWithSource(10, '10');

  static final paramModddel = ParamWithSource(
    AlwaysValidModddel(param: paramInt.value),
    'AlwaysValidModddel(param: ${paramInt.src})',
  );

  static final paramListModddel =
      ParamWithSource([paramModddel.value], '[${paramModddel.src}]');

  static final paramMapModddel = ParamWithSource(
      {paramModddel.value: paramModddel.value},
      '{${paramModddel.src}: ${paramModddel.src}}');
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

enum FactoryConstructor {
  first,
  second,
}
