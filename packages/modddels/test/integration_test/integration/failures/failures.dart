// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../_common.dart';

part 'failures.modddel.dart';

// Modddels groups :
//
// - A. Solo modddels
// - B. SSealed modddels
//

/* -------------------------------------------------------------------------- */
/*                                  Modddels                                  */
/* -------------------------------------------------------------------------- */

/* ------------------------------------ A ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeValueFailure>()),
    Validation('format', FailureType<FormatValueFailure>()),
  ])
])
class FailuresSoloSVO
    extends SingleValueObject<InvalidFailuresSoloSVO, ValidFailuresSoloSVO>
    with _$FailuresSoloSVO {
  FailuresSoloSVO._();

  factory FailuresSoloSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSoloSVO._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(twoVStepsSoloSVO) {
    return twoVStepsSoloSVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure('This is a length failure'));
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSoloSVO) {
    return twoVStepsSoloSVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure('This is a size failure'));
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSoloSVO) {
    return twoVStepsSoloSVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeValueFailure>()),
    Validation('format', FailureType<FormatValueFailure>()),
  ])
])
class FailuresSoloMVO
    extends MultiValueObject<InvalidFailuresSoloMVO, ValidFailuresSoloMVO>
    with _$FailuresSoloMVO {
  FailuresSoloMVO._();

  factory FailuresSoloMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSoloMVO._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(twoVStepsSoloMVO) {
    return twoVStepsSoloMVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure('This is a length failure'));
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSoloMVO) {
    return twoVStepsSoloMVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure('This is a size failure'));
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSoloMVO) {
    return twoVStepsSoloMVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthEntityFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ]),
  ValidationStep([contentValidation]),
])
class FailuresSoloSE
    extends SimpleEntity<InvalidFailuresSoloSE, ValidFailuresSoloSE>
    with _$FailuresSoloSE {
  FailuresSoloSE._();

  factory FailuresSoloSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSoloSE._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(twoVStepsSoloSE) {
    return twoVStepsSoloSE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSoloSE) {
    return twoVStepsSoloSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSoloSE) {
    return twoVStepsSoloSE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthEntityFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ]),
  ValidationStep([contentValidation]),
])
class FailuresSoloIE
    extends ListEntity<InvalidFailuresSoloIE, ValidFailuresSoloIE>
    with _$FailuresSoloIE {
  FailuresSoloIE._();

  factory FailuresSoloIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSoloIE._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(twoVStepsSoloIE) {
    return twoVStepsSoloIE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSoloIE) {
    return twoVStepsSoloIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSoloIE) {
    return twoVStepsSoloIE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthEntityFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ]),
  ValidationStep([contentValidation]),
])
class FailuresSoloI2E
    extends MapEntity<InvalidFailuresSoloI2E, ValidFailuresSoloI2E>
    with _$FailuresSoloI2E {
  FailuresSoloI2E._();

  factory FailuresSoloI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSoloI2E._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(twoVStepsSoloI2E) {
    return twoVStepsSoloI2E.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSoloI2E) {
    return twoVStepsSoloI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSoloI2E) {
    return twoVStepsSoloI2E.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure('This is a format failure'));
  }
}

/* ------------------------------------ B ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeValueFailure>()),
    Validation('format', FailureType<FormatValueFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class FailuresSSealedSVO extends SingleValueObject<InvalidFailuresSSealedSVO,
    ValidFailuresSSealedSVO> with _$FailuresSSealedSVO {
  FailuresSSealedSVO._();

  factory FailuresSSealedSVO.firstFailuresSSealedSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedSVO._createFirstFailuresSSealedSVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory FailuresSSealedSVO.secondFailuresSSealedSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedSVO._createSecondFailuresSSealedSVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(twoVStepsSSealedSVO) {
    return twoVStepsSSealedSVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure('This is a length failure'));
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSSealedSVO) {
    return twoVStepsSSealedSVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure('This is a size failure'));
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSSealedSVO) {
    return twoVStepsSSealedSVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeValueFailure>()),
    Validation('format', FailureType<FormatValueFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class FailuresSSealedMVO
    extends MultiValueObject<InvalidFailuresSSealedMVO, ValidFailuresSSealedMVO>
    with _$FailuresSSealedMVO {
  FailuresSSealedMVO._();

  factory FailuresSSealedMVO.firstFailuresSSealedMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedMVO._createFirstFailuresSSealedMVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory FailuresSSealedMVO.secondFailuresSSealedMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedMVO._createSecondFailuresSSealedMVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(twoVStepsSSealedMVO) {
    return twoVStepsSSealedMVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure('This is a length failure'));
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSSealedMVO) {
    return twoVStepsSSealedMVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure('This is a size failure'));
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSSealedMVO) {
    return twoVStepsSSealedMVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('length', FailureType<LengthEntityFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class FailuresSSealedSE
    extends SimpleEntity<InvalidFailuresSSealedSE, ValidFailuresSSealedSE>
    with _$FailuresSSealedSE {
  FailuresSSealedSE._();

  factory FailuresSSealedSE.firstFailuresSSealedSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedSE._createFirstFailuresSSealedSE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory FailuresSSealedSE.secondFailuresSSealedSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedSE._createSecondFailuresSSealedSE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(twoVStepsSSealedSE) {
    return twoVStepsSSealedSE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSSealedSE) {
    return twoVStepsSSealedSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSSealedSE) {
    return twoVStepsSSealedSE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('length', FailureType<LengthEntityFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class FailuresSSealedIE
    extends ListEntity<InvalidFailuresSSealedIE, ValidFailuresSSealedIE>
    with _$FailuresSSealedIE {
  FailuresSSealedIE._();

  factory FailuresSSealedIE.firstFailuresSSealedIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedIE._createFirstFailuresSSealedIE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory FailuresSSealedIE.secondFailuresSSealedIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedIE._createSecondFailuresSSealedIE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(twoVStepsSSealedIE) {
    return twoVStepsSSealedIE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSSealedIE) {
    return twoVStepsSSealedIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSSealedIE) {
    return twoVStepsSSealedIE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure('This is a format failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('length', FailureType<LengthEntityFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class FailuresSSealedI2E
    extends MapEntity<InvalidFailuresSSealedI2E, ValidFailuresSSealedI2E>
    with _$FailuresSSealedI2E {
  FailuresSSealedI2E._();

  factory FailuresSSealedI2E.firstFailuresSSealedI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedI2E._createFirstFailuresSSealedI2E(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory FailuresSSealedI2E.secondFailuresSSealedI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$FailuresSSealedI2E._createSecondFailuresSSealedI2E(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(twoVStepsSSealedI2E) {
    return twoVStepsSSealedI2E.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSSealedI2E) {
    return twoVStepsSSealedI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSSealedI2E) {
    return twoVStepsSSealedI2E.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure('This is a format failure'));
  }
}
