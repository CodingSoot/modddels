// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../_common.dart';

part 'shared_parameters_access.modddel.dart';

// Modddels groups : SSealed modddels that have :
//
// - A. Member parameters (without the `@withGetter` annotation) + Dependency
//   parameters
//   - A1 : The parameters are not shared
//   - A2 : The parameters are shared
// - B. Member parameters with the `@withGetter` annotation
//   - B1 : The parameters are not shared
//   - B2 : The parameters are shared
//

/* -------------------------------------------------------------------------- */
/*                                  Modddels                                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class NonSharedParamsAccessSVO extends SingleValueObject<
    InvalidNonSharedParamsAccessSVO,
    ValidNonSharedParamsAccessSVO> with _$NonSharedParamsAccessSVO {
  NonSharedParamsAccessSVO._();

  factory NonSharedParamsAccessSVO.firstNonSharedParamsAccessSVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessSVO._createFirstNonSharedParamsAccessSVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  factory NonSharedParamsAccessSVO.secondNonSharedParamsAccessSVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessSVO._createSecondNonSharedParamsAccessSVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class NonSharedParamsAccessMVO extends MultiValueObject<
    InvalidNonSharedParamsAccessMVO,
    ValidNonSharedParamsAccessMVO> with _$NonSharedParamsAccessMVO {
  NonSharedParamsAccessMVO._();

  factory NonSharedParamsAccessMVO.firstNonSharedParamsAccessMVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessMVO._createFirstNonSharedParamsAccessMVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  factory NonSharedParamsAccessMVO.secondNonSharedParamsAccessMVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessMVO._createSecondNonSharedParamsAccessMVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class NonSharedParamsAccessSE extends SimpleEntity<
    InvalidNonSharedParamsAccessSE,
    ValidNonSharedParamsAccessSE> with _$NonSharedParamsAccessSE {
  NonSharedParamsAccessSE._();

  factory NonSharedParamsAccessSE.firstNonSharedParamsAccessSE({
    required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessSE._createFirstNonSharedParamsAccessSE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  factory NonSharedParamsAccessSE.secondNonSharedParamsAccessSE({
    required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessSE._createSecondNonSharedParamsAccessSE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class NonSharedParamsAccessIE extends ListEntity<InvalidNonSharedParamsAccessIE,
    ValidNonSharedParamsAccessIE> with _$NonSharedParamsAccessIE {
  NonSharedParamsAccessIE._();

  factory NonSharedParamsAccessIE.firstNonSharedParamsAccessIE({
    required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessIE._createFirstNonSharedParamsAccessIE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  factory NonSharedParamsAccessIE.secondNonSharedParamsAccessIE({
    required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessIE._createSecondNonSharedParamsAccessIE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class NonSharedParamsAccessI2E extends MapEntity<
    InvalidNonSharedParamsAccessI2E,
    ValidNonSharedParamsAccessI2E> with _$NonSharedParamsAccessI2E {
  NonSharedParamsAccessI2E._();

  factory NonSharedParamsAccessI2E.firstNonSharedParamsAccessI2E({
    required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessI2E._createFirstNonSharedParamsAccessI2E(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  factory NonSharedParamsAccessI2E.secondNonSharedParamsAccessI2E({
    required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$NonSharedParamsAccessI2E._createSecondNonSharedParamsAccessI2E(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

/* ----------------------------------- A2 ----------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('String', 'param'),
    SharedProp('MyService', 'dependency'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class SharedParamsAccessSVO extends SingleValueObject<
    InvalidSharedParamsAccessSVO,
    ValidSharedParamsAccessSVO> with _$SharedParamsAccessSVO {
  SharedParamsAccessSVO._();

  factory SharedParamsAccessSVO.firstSharedParamsAccessSVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessSVO._createFirstSharedParamsAccessSVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory SharedParamsAccessSVO.secondSharedParamsAccessSVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessSVO._createSecondSharedParamsAccessSVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
        'dependency': subholder.dependency,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('String', 'param'),
    SharedProp('MyService', 'dependency'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class SharedParamsAccessMVO extends MultiValueObject<
    InvalidSharedParamsAccessMVO,
    ValidSharedParamsAccessMVO> with _$SharedParamsAccessMVO {
  SharedParamsAccessMVO._();

  factory SharedParamsAccessMVO.firstSharedParamsAccessMVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessMVO._createFirstSharedParamsAccessMVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory SharedParamsAccessMVO.secondSharedParamsAccessMVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessMVO._createSecondSharedParamsAccessMVO(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
        'dependency': subholder.dependency,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [
    SharedProp('MyModddel', 'param'),
    SharedProp('MyService', 'dependency'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class SharedParamsAccessSE
    extends SimpleEntity<InvalidSharedParamsAccessSE, ValidSharedParamsAccessSE>
    with _$SharedParamsAccessSE {
  SharedParamsAccessSE._();

  factory SharedParamsAccessSE.firstSharedParamsAccessSE({
    required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessSE._createFirstSharedParamsAccessSE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory SharedParamsAccessSE.secondSharedParamsAccessSE({
    required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessSE._createSecondSharedParamsAccessSE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
        'dependency': subholder.dependency,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [
    SharedProp('List<MyModddel>', 'param'),
    SharedProp('MyService', 'dependency'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class SharedParamsAccessIE
    extends ListEntity<InvalidSharedParamsAccessIE, ValidSharedParamsAccessIE>
    with _$SharedParamsAccessIE {
  SharedParamsAccessIE._();

  factory SharedParamsAccessIE.firstSharedParamsAccessIE({
    required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessIE._createFirstSharedParamsAccessIE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory SharedParamsAccessIE.secondSharedParamsAccessIE({
    required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessIE._createSecondSharedParamsAccessIE(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
        'dependency': subholder.dependency,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [
    SharedProp('Map<MyModddel, MyModddel>', 'param'),
    SharedProp('MyService', 'dependency'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class SharedParamsAccessI2E
    extends MapEntity<InvalidSharedParamsAccessI2E, ValidSharedParamsAccessI2E>
    with _$SharedParamsAccessI2E {
  SharedParamsAccessI2E._();

  factory SharedParamsAccessI2E.firstSharedParamsAccessI2E({
    required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessI2E._createFirstSharedParamsAccessI2E(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory SharedParamsAccessI2E.secondSharedParamsAccessI2E({
    required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$SharedParamsAccessI2E._createSecondSharedParamsAccessI2E(
      param: param,
      dependency: dependency,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
        'dependency': subholder.dependency,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

/* ----------------------------------- B1 ----------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class WithGetterNonSharedParamsAccessSVO extends SingleValueObject<
        InvalidWithGetterNonSharedParamsAccessSVO,
        ValidWithGetterNonSharedParamsAccessSVO>
    with _$WithGetterNonSharedParamsAccessSVO {
  WithGetterNonSharedParamsAccessSVO._();

  factory WithGetterNonSharedParamsAccessSVO.firstWithGetterNonSharedParamsAccessSVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessSVO
        ._createFirstWithGetterNonSharedParamsAccessSVO(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  factory WithGetterNonSharedParamsAccessSVO.secondWithGetterNonSharedParamsAccessSVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessSVO
        ._createSecondWithGetterNonSharedParamsAccessSVO(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class WithGetterNonSharedParamsAccessMVO extends MultiValueObject<
        InvalidWithGetterNonSharedParamsAccessMVO,
        ValidWithGetterNonSharedParamsAccessMVO>
    with _$WithGetterNonSharedParamsAccessMVO {
  WithGetterNonSharedParamsAccessMVO._();

  factory WithGetterNonSharedParamsAccessMVO.firstWithGetterNonSharedParamsAccessMVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessMVO
        ._createFirstWithGetterNonSharedParamsAccessMVO(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  factory WithGetterNonSharedParamsAccessMVO.secondWithGetterNonSharedParamsAccessMVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessMVO
        ._createSecondWithGetterNonSharedParamsAccessMVO(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class WithGetterNonSharedParamsAccessSE extends SimpleEntity<
        InvalidWithGetterNonSharedParamsAccessSE,
        ValidWithGetterNonSharedParamsAccessSE>
    with _$WithGetterNonSharedParamsAccessSE {
  WithGetterNonSharedParamsAccessSE._();

  factory WithGetterNonSharedParamsAccessSE.firstWithGetterNonSharedParamsAccessSE({
    @withGetter required MyModddel param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessSE
        ._createFirstWithGetterNonSharedParamsAccessSE(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  factory WithGetterNonSharedParamsAccessSE.secondWithGetterNonSharedParamsAccessSE({
    @withGetter required MyModddel param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessSE
        ._createSecondWithGetterNonSharedParamsAccessSE(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class WithGetterNonSharedParamsAccessIE extends ListEntity<
        InvalidWithGetterNonSharedParamsAccessIE,
        ValidWithGetterNonSharedParamsAccessIE>
    with _$WithGetterNonSharedParamsAccessIE {
  WithGetterNonSharedParamsAccessIE._();

  factory WithGetterNonSharedParamsAccessIE.firstWithGetterNonSharedParamsAccessIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessIE
        ._createFirstWithGetterNonSharedParamsAccessIE(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  factory WithGetterNonSharedParamsAccessIE.secondWithGetterNonSharedParamsAccessIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessIE
        ._createSecondWithGetterNonSharedParamsAccessIE(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [SharedProp('bool', '\$isModddelValid')],
)
class WithGetterNonSharedParamsAccessI2E extends MapEntity<
        InvalidWithGetterNonSharedParamsAccessI2E,
        ValidWithGetterNonSharedParamsAccessI2E>
    with _$WithGetterNonSharedParamsAccessI2E {
  WithGetterNonSharedParamsAccessI2E._();

  factory WithGetterNonSharedParamsAccessI2E.firstWithGetterNonSharedParamsAccessI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessI2E
        ._createFirstWithGetterNonSharedParamsAccessI2E(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  factory WithGetterNonSharedParamsAccessI2E.secondWithGetterNonSharedParamsAccessI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required bool $isModddelValid,
  }) {
    return _$WithGetterNonSharedParamsAccessI2E
        ._createSecondWithGetterNonSharedParamsAccessI2E(
      param: param,
      $isModddelValid: $isModddelValid,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

/* ----------------------------------- B2 ----------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('String', 'param'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class WithGetterSharedParamsAccessSVO extends SingleValueObject<
        InvalidWithGetterSharedParamsAccessSVO,
        ValidWithGetterSharedParamsAccessSVO>
    with _$WithGetterSharedParamsAccessSVO {
  WithGetterSharedParamsAccessSVO._();

  factory WithGetterSharedParamsAccessSVO.firstWithGetterSharedParamsAccessSVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessSVO
        ._createFirstWithGetterSharedParamsAccessSVO(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory WithGetterSharedParamsAccessSVO.secondWithGetterSharedParamsAccessSVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessSVO
        ._createSecondWithGetterSharedParamsAccessSVO(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('String', 'param'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class WithGetterSharedParamsAccessMVO extends MultiValueObject<
        InvalidWithGetterSharedParamsAccessMVO,
        ValidWithGetterSharedParamsAccessMVO>
    with _$WithGetterSharedParamsAccessMVO {
  WithGetterSharedParamsAccessMVO._();

  factory WithGetterSharedParamsAccessMVO.firstWithGetterSharedParamsAccessMVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessMVO
        ._createFirstWithGetterSharedParamsAccessMVO(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory WithGetterSharedParamsAccessMVO.secondWithGetterSharedParamsAccessMVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessMVO
        ._createSecondWithGetterSharedParamsAccessMVO(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthValueFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [
    SharedProp('MyModddel', 'param'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class WithGetterSharedParamsAccessSE extends SimpleEntity<
    InvalidWithGetterSharedParamsAccessSE,
    ValidWithGetterSharedParamsAccessSE> with _$WithGetterSharedParamsAccessSE {
  WithGetterSharedParamsAccessSE._();

  factory WithGetterSharedParamsAccessSE.firstWithGetterSharedParamsAccessSE({
    @withGetter required MyModddel param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessSE
        ._createFirstWithGetterSharedParamsAccessSE(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory WithGetterSharedParamsAccessSE.secondWithGetterSharedParamsAccessSE({
    @withGetter required MyModddel param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessSE
        ._createSecondWithGetterSharedParamsAccessSE(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [
    SharedProp('List<MyModddel>', 'param'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class WithGetterSharedParamsAccessIE extends ListEntity<
    InvalidWithGetterSharedParamsAccessIE,
    ValidWithGetterSharedParamsAccessIE> with _$WithGetterSharedParamsAccessIE {
  WithGetterSharedParamsAccessIE._();

  factory WithGetterSharedParamsAccessIE.firstWithGetterSharedParamsAccessIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessIE
        ._createFirstWithGetterSharedParamsAccessIE(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory WithGetterSharedParamsAccessIE.secondWithGetterSharedParamsAccessIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessIE
        ._createSecondWithGetterSharedParamsAccessIE(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
      Validation('length', FailureType<LengthEntityFailure>()),
    ])
  ],
  sharedProps: [
    SharedProp('Map<MyModddel, MyModddel>', 'param'),
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos')
  ],
)
class WithGetterSharedParamsAccessI2E extends MapEntity<
        InvalidWithGetterSharedParamsAccessI2E,
        ValidWithGetterSharedParamsAccessI2E>
    with _$WithGetterSharedParamsAccessI2E {
  WithGetterSharedParamsAccessI2E._();

  factory WithGetterSharedParamsAccessI2E.firstWithGetterSharedParamsAccessI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessI2E
        ._createFirstWithGetterSharedParamsAccessI2E(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  factory WithGetterSharedParamsAccessI2E.secondWithGetterSharedParamsAccessI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterSharedParamsAccessI2E
        ._createSecondWithGetterSharedParamsAccessI2E(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.param,
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

/// Error thrown inside the validate method and that holds information about
/// the parameters of the subholder.
///
class ValidateMethodParametersInformation extends Error {
  ValidateMethodParametersInformation({
    required this.parameters,
  });

  /// A Map of the names of the accessed subholder parameters and their values.
  ///
  final Map<String, dynamic> parameters;
}
