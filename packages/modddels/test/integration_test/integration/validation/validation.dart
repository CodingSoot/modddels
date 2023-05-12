import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../_common.dart';

part 'validation.modddel.dart';

// Modddels groups :
//
// - A1. Solo modddels with one validationStep
// - A2. Solo modddels with two validationSteps
// - B1. SSealed modddels with one validationStep
// - B2. SSealed modddels with two validationSteps
//

/* -------------------------------------------------------------------------- */
/*                                  Modddels                                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class OneVStepSoloSVO
    extends SingleValueObject<InvalidOneVStepSoloSVO, ValidOneVStepSoloSVO>
    with _$OneVStepSoloSVO {
  OneVStepSoloSVO._();

  factory OneVStepSoloSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSoloSVO._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(oneVStepSoloSVO) {
    return oneVStepSoloSVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class OneVStepSoloMVO
    extends MultiValueObject<InvalidOneVStepSoloMVO, ValidOneVStepSoloMVO>
    with _$OneVStepSoloMVO {
  OneVStepSoloMVO._();

  factory OneVStepSoloMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSoloMVO._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(oneVStepSoloMVO) {
    return oneVStepSoloMVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ])
])
class OneVStepSoloSE
    extends SimpleEntity<InvalidOneVStepSoloSE, ValidOneVStepSoloSE>
    with _$OneVStepSoloSE {
  OneVStepSoloSE._();

  factory OneVStepSoloSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSoloSE._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(oneVStepSoloSE) {
    return oneVStepSoloSE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ])
])
class OneVStepSoloIE
    extends ListEntity<InvalidOneVStepSoloIE, ValidOneVStepSoloIE>
    with _$OneVStepSoloIE {
  OneVStepSoloIE._();

  factory OneVStepSoloIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSoloIE._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(oneVStepSoloIE) {
    return oneVStepSoloIE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ])
])
class OneVStepSoloI2E
    extends MapEntity<InvalidOneVStepSoloI2E, ValidOneVStepSoloI2E>
    with _$OneVStepSoloI2E {
  OneVStepSoloI2E._();

  factory OneVStepSoloI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSoloI2E._create(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(oneVStepSoloI2E) {
    return oneVStepSoloI2E.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure());
  }
}

/* ----------------------------------- A2 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeValueFailure>()),
    Validation('format', FailureType<FormatValueFailure>()),
  ])
])
class MultipleVStepsSoloSVO extends SingleValueObject<
    InvalidMultipleVStepsSoloSVO,
    ValidMultipleVStepsSoloSVO> with _$MultipleVStepsSoloSVO {
  MultipleVStepsSoloSVO._();

  factory MultipleVStepsSoloSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSoloSVO._create(
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
        : some(LengthValueFailure());
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSoloSVO) {
    return twoVStepsSoloSVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure());
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSoloSVO) {
    return twoVStepsSoloSVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())]),
  ValidationStep([
    Validation('size', FailureType<SizeValueFailure>()),
    Validation('format', FailureType<FormatValueFailure>()),
  ])
])
class MultipleVStepsSoloMVO extends MultiValueObject<
    InvalidMultipleVStepsSoloMVO,
    ValidMultipleVStepsSoloMVO> with _$MultipleVStepsSoloMVO {
  MultipleVStepsSoloMVO._();

  factory MultipleVStepsSoloMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSoloMVO._create(
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
        : some(LengthValueFailure());
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSoloMVO) {
    return twoVStepsSoloMVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure());
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSoloMVO) {
    return twoVStepsSoloMVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
])
class MultipleVStepsSoloSE
    extends SimpleEntity<InvalidMultipleVStepsSoloSE, ValidMultipleVStepsSoloSE>
    with _$MultipleVStepsSoloSE {
  MultipleVStepsSoloSE._();

  factory MultipleVStepsSoloSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSoloSE._create(
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
        : some(LengthEntityFailure());
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSoloSE) {
    return twoVStepsSoloSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure());
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSoloSE) {
    return twoVStepsSoloSE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
])
class MultipleVStepsSoloIE
    extends ListEntity<InvalidMultipleVStepsSoloIE, ValidMultipleVStepsSoloIE>
    with _$MultipleVStepsSoloIE {
  MultipleVStepsSoloIE._();

  factory MultipleVStepsSoloIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSoloIE._create(
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
        : some(LengthEntityFailure());
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSoloIE) {
    return twoVStepsSoloIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure());
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSoloIE) {
    return twoVStepsSoloIE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
])
class MultipleVStepsSoloI2E
    extends MapEntity<InvalidMultipleVStepsSoloI2E, ValidMultipleVStepsSoloI2E>
    with _$MultipleVStepsSoloI2E {
  MultipleVStepsSoloI2E._();

  factory MultipleVStepsSoloI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSoloI2E._create(
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
        : some(LengthEntityFailure());
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSoloI2E) {
    return twoVStepsSoloI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure());
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSoloI2E) {
    return twoVStepsSoloI2E.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure());
  }
}

/* ----------------------------------- B1 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
])
class OneVStepSSealedSVO extends SingleValueObject<InvalidOneVStepSSealedSVO,
    ValidOneVStepSSealedSVO> with _$OneVStepSSealedSVO {
  OneVStepSSealedSVO._();

  factory OneVStepSSealedSVO.firstOneVStepSSealedSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedSVO._createFirstOneVStepSSealedSVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  factory OneVStepSSealedSVO.secondOneVStepSSealedSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedSVO._createSecondOneVStepSSealedSVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(oneVStepSSealedSVO) {
    return oneVStepSSealedSVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
])
class OneVStepSSealedMVO
    extends MultiValueObject<InvalidOneVStepSSealedMVO, ValidOneVStepSSealedMVO>
    with _$OneVStepSSealedMVO {
  OneVStepSSealedMVO._();

  factory OneVStepSSealedMVO.firstOneVStepSSealedMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedMVO._createFirstOneVStepSSealedMVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  factory OneVStepSSealedMVO.secondOneVStepSSealedMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedMVO._createSecondOneVStepSSealedMVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(oneVStepSSealedMVO) {
    return oneVStepSSealedMVO.$lengthValidationPasses
        ? none()
        : some(LengthValueFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
])
class OneVStepSSealedSE
    extends SimpleEntity<InvalidOneVStepSSealedSE, ValidOneVStepSSealedSE>
    with _$OneVStepSSealedSE {
  OneVStepSSealedSE._();

  factory OneVStepSSealedSE.firstOneVStepSSealedSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedSE._createFirstOneVStepSSealedSE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  factory OneVStepSSealedSE.secondOneVStepSSealedSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedSE._createSecondOneVStepSSealedSE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(oneVStepSSealedSE) {
    return oneVStepSSealedSE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
])
class OneVStepSSealedIE
    extends ListEntity<InvalidOneVStepSSealedIE, ValidOneVStepSSealedIE>
    with _$OneVStepSSealedIE {
  OneVStepSSealedIE._();

  factory OneVStepSSealedIE.firstOneVStepSSealedIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedIE._createFirstOneVStepSSealedIE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  factory OneVStepSSealedIE.secondOneVStepSSealedIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedIE._createSecondOneVStepSSealedIE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(oneVStepSSealedIE) {
    return oneVStepSSealedIE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
])
class OneVStepSSealedI2E
    extends MapEntity<InvalidOneVStepSSealedI2E, ValidOneVStepSSealedI2E>
    with _$OneVStepSSealedI2E {
  OneVStepSSealedI2E._();

  factory OneVStepSSealedI2E.firstOneVStepSSealedI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedI2E._createFirstOneVStepSSealedI2E(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  factory OneVStepSSealedI2E.secondOneVStepSSealedI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
  }) {
    return _$OneVStepSSealedI2E._createSecondOneVStepSSealedI2E(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(oneVStepSSealedI2E) {
    return oneVStepSSealedI2E.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure());
  }
}

/* ----------------------------------- B2 ----------------------------------- */

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
class MultipleVStepsSSealedSVO extends SingleValueObject<
    InvalidMultipleVStepsSSealedSVO,
    ValidMultipleVStepsSSealedSVO> with _$MultipleVStepsSSealedSVO {
  MultipleVStepsSSealedSVO._();

  factory MultipleVStepsSSealedSVO.firstMultipleVStepsSSealedSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedSVO._createFirstMultipleVStepsSSealedSVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory MultipleVStepsSSealedSVO.secondMultipleVStepsSSealedSVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedSVO._createSecondMultipleVStepsSSealedSVO(
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
        : some(LengthValueFailure());
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSSealedSVO) {
    return twoVStepsSSealedSVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure());
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSSealedSVO) {
    return twoVStepsSSealedSVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure());
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
class MultipleVStepsSSealedMVO extends MultiValueObject<
    InvalidMultipleVStepsSSealedMVO,
    ValidMultipleVStepsSSealedMVO> with _$MultipleVStepsSSealedMVO {
  MultipleVStepsSSealedMVO._();

  factory MultipleVStepsSSealedMVO.firstMultipleVStepsSSealedMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedMVO._createFirstMultipleVStepsSSealedMVO(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory MultipleVStepsSSealedMVO.secondMultipleVStepsSSealedMVO({
    required int param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedMVO._createSecondMultipleVStepsSSealedMVO(
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
        : some(LengthValueFailure());
  }

  @override
  Option<SizeValueFailure> validateSize(twoVStepsSSealedMVO) {
    return twoVStepsSSealedMVO.$sizeValidationPasses
        ? none()
        : some(SizeValueFailure());
  }

  @override
  Option<FormatValueFailure> validateFormat(twoVStepsSSealedMVO) {
    return twoVStepsSSealedMVO.$formatValidationPasses
        ? none()
        : some(FormatValueFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class MultipleVStepsSSealedSE extends SimpleEntity<
    InvalidMultipleVStepsSSealedSE,
    ValidMultipleVStepsSSealedSE> with _$MultipleVStepsSSealedSE {
  MultipleVStepsSSealedSE._();

  factory MultipleVStepsSSealedSE.firstMultipleVStepsSSealedSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedSE._createFirstMultipleVStepsSSealedSE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory MultipleVStepsSSealedSE.secondMultipleVStepsSSealedSE({
    required AlwaysValidModddel param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedSE._createSecondMultipleVStepsSSealedSE(
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
        : some(LengthEntityFailure());
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSSealedSE) {
    return twoVStepsSSealedSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure());
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSSealedSE) {
    return twoVStepsSSealedSE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class MultipleVStepsSSealedIE extends ListEntity<InvalidMultipleVStepsSSealedIE,
    ValidMultipleVStepsSSealedIE> with _$MultipleVStepsSSealedIE {
  MultipleVStepsSSealedIE._();

  factory MultipleVStepsSSealedIE.firstMultipleVStepsSSealedIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedIE._createFirstMultipleVStepsSSealedIE(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory MultipleVStepsSSealedIE.secondMultipleVStepsSSealedIE({
    required List<AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedIE._createSecondMultipleVStepsSSealedIE(
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
        : some(LengthEntityFailure());
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSSealedIE) {
    return twoVStepsSSealedIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure());
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSSealedIE) {
    return twoVStepsSSealedIE.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure());
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>())
  ]),
  ValidationStep([
    Validation('size', FailureType<SizeEntityFailure>()),
    Validation('format', FailureType<FormatEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
  SharedProp('bool', '\$formatValidationPasses'),
])
class MultipleVStepsSSealedI2E extends MapEntity<
    InvalidMultipleVStepsSSealedI2E,
    ValidMultipleVStepsSSealedI2E> with _$MultipleVStepsSSealedI2E {
  MultipleVStepsSSealedI2E._();

  factory MultipleVStepsSSealedI2E.firstMultipleVStepsSSealedI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedI2E._createFirstMultipleVStepsSSealedI2E(
      param: param,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
      $formatValidationPasses: $formatValidationPasses,
    );
  }

  factory MultipleVStepsSSealedI2E.secondMultipleVStepsSSealedI2E({
    required Map<AlwaysValidModddel, AlwaysValidModddel> param,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
    @dependencyParam required bool $formatValidationPasses,
  }) {
    return _$MultipleVStepsSSealedI2E._createSecondMultipleVStepsSSealedI2E(
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
        : some(LengthEntityFailure());
  }

  @override
  Option<SizeEntityFailure> validateSize(twoVStepsSSealedI2E) {
    return twoVStepsSSealedI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure());
  }

  @override
  Option<FormatEntityFailure> validateFormat(twoVStepsSSealedI2E) {
    return twoVStepsSSealedI2E.$formatValidationPasses
        ? none()
        : some(FormatEntityFailure());
  }
}
