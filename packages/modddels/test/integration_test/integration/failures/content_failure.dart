// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../_common.dart';

part 'content_failure.modddel.dart';

// Entities groups :
//
// - A. Solo entities with :
//   - A1 : A contentValidationStep that has one validation
//   - A2 : A contentValidationStep that has two validations
// - B. SSealed entities with :
//   - B1 : A contentValidationStep that has one validation
//   - B2 : A contentValidationStep that has two validations
//

/* -------------------------------------------------------------------------- */
/*                                  Entities                                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
])
class OneValidationSoloSE
    extends SimpleEntity<InvalidOneValidationSoloSE, ValidOneValidationSoloSE>
    with _$OneValidationSoloSE {
  OneValidationSoloSE._();

  factory OneValidationSoloSE({
    required CustomModddel param1,
    required CustomModddel param2,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSoloSE._create(
      param1: param1,
      param2: param2,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<SizeEntityFailure> validateSize(oneValidationSoloSE) {
    return oneValidationSoloSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
])
class OneValidationSoloIE
    extends ListEntity<InvalidOneValidationSoloIE, ValidOneValidationSoloIE>
    with _$OneValidationSoloIE {
  OneValidationSoloIE._();

  factory OneValidationSoloIE({
    required List<CustomModddel> params,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSoloIE._create(
      params: params,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<SizeEntityFailure> validateSize(oneValidationSoloIE) {
    return oneValidationSoloIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
])
class OneValidationSoloI2E
    extends MapEntity<InvalidOneValidationSoloI2E, ValidOneValidationSoloI2E>
    with _$OneValidationSoloI2E {
  OneValidationSoloI2E._();

  factory OneValidationSoloI2E({
    required Map<CustomModddel, CustomModddel> params,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSoloI2E._create(
      params: params,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<SizeEntityFailure> validateSize(oneValidationSoloI2E) {
    return oneValidationSoloI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

/* ----------------------------------- A2 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
])
class MultipleValidationsSoloSE extends SimpleEntity<
    InvalidMultipleValidationsSoloSE,
    ValidMultipleValidationsSoloSE> with _$MultipleValidationsSoloSE {
  MultipleValidationsSoloSE._();

  factory MultipleValidationsSoloSE({
    required CustomModddel param1,
    required CustomModddel param2,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSoloSE._create(
      param1: param1,
      param2: param2,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(multipleValidationsSoloSE) {
    return multipleValidationsSoloSE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(multipleValidationsSoloSE) {
    return multipleValidationsSoloSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
])
class MultipleValidationsSoloIE extends ListEntity<
    InvalidMultipleValidationsSoloIE,
    ValidMultipleValidationsSoloIE> with _$MultipleValidationsSoloIE {
  MultipleValidationsSoloIE._();

  factory MultipleValidationsSoloIE({
    required List<CustomModddel> params,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSoloIE._create(
      params: params,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(multipleValidationsSoloIE) {
    return multipleValidationsSoloIE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(multipleValidationsSoloIE) {
    return multipleValidationsSoloIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
])
class MultipleValidationsSoloI2E extends MapEntity<
    InvalidMultipleValidationsSoloI2E,
    ValidMultipleValidationsSoloI2E> with _$MultipleValidationsSoloI2E {
  MultipleValidationsSoloI2E._();

  factory MultipleValidationsSoloI2E({
    required Map<CustomModddel, CustomModddel> params,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSoloI2E._create(
      params: params,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(multipleValidationsSoloI2E) {
    return multipleValidationsSoloI2E.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(multipleValidationsSoloI2E) {
    return multipleValidationsSoloI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

/* ----------------------------------- B1 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
], sharedProps: [
  SharedProp('bool', '\$sizeValidationPasses')
])
class OneValidationSSealedSE extends SimpleEntity<InvalidOneValidationSSealedSE,
    ValidOneValidationSSealedSE> with _$OneValidationSSealedSE {
  OneValidationSSealedSE._();

  factory OneValidationSSealedSE.firstOneValidationSSealedSE({
    required CustomModddel param1,
    required CustomModddel param2,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSSealedSE._createFirstOneValidationSSealedSE(
      param1: param1,
      param2: param2,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  factory OneValidationSSealedSE.secondOneValidationSSealedSE({
    required CustomModddel param1,
    required CustomModddel param2,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSSealedSE._createSecondOneValidationSSealedSE(
      param1: param1,
      param2: param2,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<SizeEntityFailure> validateSize(oneValidationSSealedSE) {
    return oneValidationSSealedSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
], sharedProps: [
  SharedProp('bool', '\$sizeValidationPasses')
])
class OneValidationSSealedIE extends ListEntity<InvalidOneValidationSSealedIE,
    ValidOneValidationSSealedIE> with _$OneValidationSSealedIE {
  OneValidationSSealedIE._();

  factory OneValidationSSealedIE.firstOneValidationSSealedIE({
    required List<CustomModddel> params,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSSealedIE._createFirstOneValidationSSealedIE(
      params: params,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  factory OneValidationSSealedIE.secondOneValidationSSealedIE({
    required List<CustomModddel> params,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSSealedIE._createSecondOneValidationSSealedIE(
      params: params,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<SizeEntityFailure> validateSize(oneValidationSSealedIE) {
    return oneValidationSSealedIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
], sharedProps: [
  SharedProp('bool', '\$sizeValidationPasses')
])
class OneValidationSSealedI2E extends MapEntity<InvalidOneValidationSSealedI2E,
    ValidOneValidationSSealedI2E> with _$OneValidationSSealedI2E {
  OneValidationSSealedI2E._();

  factory OneValidationSSealedI2E.firstOneValidationSSealedI2E({
    required Map<CustomModddel, CustomModddel> params,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSSealedI2E._createFirstOneValidationSSealedI2E(
      params: params,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  factory OneValidationSSealedI2E.secondOneValidationSSealedI2E({
    required Map<CustomModddel, CustomModddel> params,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$OneValidationSSealedI2E._createSecondOneValidationSSealedI2E(
      params: params,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<SizeEntityFailure> validateSize(oneValidationSSealedI2E) {
    return oneValidationSSealedI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

/* ----------------------------------- B2 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
])
class MultipleValidationsSSealedSE extends SimpleEntity<
    InvalidMultipleValidationsSSealedSE,
    ValidMultipleValidationsSSealedSE> with _$MultipleValidationsSSealedSE {
  MultipleValidationsSSealedSE._();

  factory MultipleValidationsSSealedSE.firstMultipleValidationsSSealedSE({
    required CustomModddel param1,
    required CustomModddel param2,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSSealedSE
        ._createFirstMultipleValidationsSSealedSE(
      param1: param1,
      param2: param2,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  factory MultipleValidationsSSealedSE.secondMultipleValidationsSSealedSE({
    required CustomModddel param1,
    required CustomModddel param2,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSSealedSE
        ._createSecondMultipleValidationsSSealedSE(
      param1: param1,
      param2: param2,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(multipleValidationsSSealedSE) {
    return multipleValidationsSSealedSE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(multipleValidationsSSealedSE) {
    return multipleValidationsSSealedSE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
])
class MultipleValidationsSSealedIE extends ListEntity<
    InvalidMultipleValidationsSSealedIE,
    ValidMultipleValidationsSSealedIE> with _$MultipleValidationsSSealedIE {
  MultipleValidationsSSealedIE._();

  factory MultipleValidationsSSealedIE.firstMultipleValidationsSSealedIE({
    required List<CustomModddel> params,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSSealedIE
        ._createFirstMultipleValidationsSSealedIE(
      params: params,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  factory MultipleValidationsSSealedIE.secondMultipleValidationsSSealedIE({
    required List<CustomModddel> params,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSSealedIE
        ._createSecondMultipleValidationsSSealedIE(
      params: params,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(multipleValidationsSSealedIE) {
    return multipleValidationsSSealedIE.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(multipleValidationsSSealedIE) {
    return multipleValidationsSSealedIE.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ]),
  ValidationStep([Validation('size', FailureType<SizeEntityFailure>())])
], sharedProps: [
  SharedProp('bool', '\$lengthValidationPasses'),
  SharedProp('bool', '\$sizeValidationPasses'),
])
class MultipleValidationsSSealedI2E extends MapEntity<
    InvalidMultipleValidationsSSealedI2E,
    ValidMultipleValidationsSSealedI2E> with _$MultipleValidationsSSealedI2E {
  MultipleValidationsSSealedI2E._();

  factory MultipleValidationsSSealedI2E.firstMultipleValidationsSSealedI2E({
    required Map<CustomModddel, CustomModddel> params,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSSealedI2E
        ._createFirstMultipleValidationsSSealedI2E(
      params: params,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  factory MultipleValidationsSSealedI2E.secondMultipleValidationsSSealedI2E({
    required Map<CustomModddel, CustomModddel> params,
    @dependencyParam required bool $lengthValidationPasses,
    @dependencyParam required bool $sizeValidationPasses,
  }) {
    return _$MultipleValidationsSSealedI2E
        ._createSecondMultipleValidationsSSealedI2E(
      params: params,
      $lengthValidationPasses: $lengthValidationPasses,
      $sizeValidationPasses: $sizeValidationPasses,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(multipleValidationsSSealedI2E) {
    return multipleValidationsSSealedI2E.$lengthValidationPasses
        ? none()
        : some(LengthEntityFailure('This is a length failure'));
  }

  @override
  Option<SizeEntityFailure> validateSize(multipleValidationsSSealedI2E) {
    return multipleValidationsSSealedI2E.$sizeValidationPasses
        ? none()
        : some(SizeEntityFailure('This is a size failure'));
  }
}
