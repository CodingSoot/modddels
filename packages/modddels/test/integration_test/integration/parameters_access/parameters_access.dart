// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../_common.dart';
part 'parameters_access.modddel.dart';

// Modddels groups : SSealed modddels that have :
//
// - A. Solo modddels that have :
//   - A1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters
//   - A2 : Member parameters with the `@withGetter` annotation
// - B. SSealed modddels that have :
//   - B1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters (Not shared)
//   - B2 : Member parameters with the `@withGetter` annotation (Not shared)
//

/* -------------------------------------------------------------------------- */
/*                                  Modddels                                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  generateTestClasses: true,
)
class ParamsAccessSoloSVO extends SingleValueObject<InvalidParamsAccessSoloSVO,
    ValidParamsAccessSoloSVO> with _$ParamsAccessSoloSVO {
  ParamsAccessSoloSVO._();

  factory ParamsAccessSoloSVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSoloSVO._create(
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

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class ParamsAccessSoloMVO extends MultiValueObject<InvalidParamsAccessSoloMVO,
    ValidParamsAccessSoloMVO> with _$ParamsAccessSoloMVO {
  ParamsAccessSoloMVO._();

  factory ParamsAccessSoloMVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSoloMVO._create(
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

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class ParamsAccessSoloSE
    extends SimpleEntity<InvalidParamsAccessSoloSE, ValidParamsAccessSoloSE>
    with _$ParamsAccessSoloSE {
  ParamsAccessSoloSE._();

  factory ParamsAccessSoloSE({
    required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSoloSE._create(
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

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class ParamsAccessSoloIE
    extends ListEntity<InvalidParamsAccessSoloIE, ValidParamsAccessSoloIE>
    with _$ParamsAccessSoloIE {
  ParamsAccessSoloIE._();

  factory ParamsAccessSoloIE({
    required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSoloIE._create(
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

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class ParamsAccessSoloI2E
    extends MapEntity<InvalidParamsAccessSoloI2E, ValidParamsAccessSoloI2E>
    with _$ParamsAccessSoloI2E {
  ParamsAccessSoloI2E._();

  factory ParamsAccessSoloI2E({
    required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSoloI2E._create(
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

/* ----------------------------------- A2 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class WithGetterParamsAccessSoloSVO extends SingleValueObject<
    InvalidWithGetterParamsAccessSoloSVO,
    ValidWithGetterParamsAccessSoloSVO> with _$WithGetterParamsAccessSoloSVO {
  WithGetterParamsAccessSoloSVO._();

  factory WithGetterParamsAccessSoloSVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSoloSVO._create(
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

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class WithGetterParamsAccessSoloMVO extends MultiValueObject<
    InvalidWithGetterParamsAccessSoloMVO,
    ValidWithGetterParamsAccessSoloMVO> with _$WithGetterParamsAccessSoloMVO {
  WithGetterParamsAccessSoloMVO._();

  factory WithGetterParamsAccessSoloMVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSoloMVO._create(
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

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class WithGetterParamsAccessSoloSE extends SimpleEntity<
    InvalidWithGetterParamsAccessSoloSE,
    ValidWithGetterParamsAccessSoloSE> with _$WithGetterParamsAccessSoloSE {
  WithGetterParamsAccessSoloSE._();

  factory WithGetterParamsAccessSoloSE({
    @withGetter required MyModddel param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSoloSE._create(
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

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class WithGetterParamsAccessSoloIE extends ListEntity<
    InvalidWithGetterParamsAccessSoloIE,
    ValidWithGetterParamsAccessSoloIE> with _$WithGetterParamsAccessSoloIE {
  WithGetterParamsAccessSoloIE._();

  factory WithGetterParamsAccessSoloIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSoloIE._create(
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

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class WithGetterParamsAccessSoloI2E extends MapEntity<
    InvalidWithGetterParamsAccessSoloI2E,
    ValidWithGetterParamsAccessSoloI2E> with _$WithGetterParamsAccessSoloI2E {
  WithGetterParamsAccessSoloI2E._();

  factory WithGetterParamsAccessSoloI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSoloI2E._create(
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

/* ----------------------------------- B1 ----------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class ParamsAccessSSealedSVO extends SingleValueObject<
    InvalidParamsAccessSSealedSVO,
    ValidParamsAccessSSealedSVO> with _$ParamsAccessSSealedSVO {
  ParamsAccessSSealedSVO._();

  factory ParamsAccessSSealedSVO.namedParamsAccessSSealedSVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSSealedSVO._createNamedParamsAccessSSealedSVO(
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
        'param': subholder.mapParamsAccessSSealedSVO(
            namedParamsAccessSSealedSVO: (caseModddelSubholder) =>
                caseModddelSubholder.param),
        'dependency': subholder.mapParamsAccessSSealedSVO(
            namedParamsAccessSSealedSVO: (caseModddelSubholder) =>
                caseModddelSubholder.dependency),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class ParamsAccessSSealedMVO extends MultiValueObject<
    InvalidParamsAccessSSealedMVO,
    ValidParamsAccessSSealedMVO> with _$ParamsAccessSSealedMVO {
  ParamsAccessSSealedMVO._();

  factory ParamsAccessSSealedMVO.namedParamsAccessSSealedMVO({
    required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSSealedMVO._createNamedParamsAccessSSealedMVO(
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
        'param': subholder.mapParamsAccessSSealedMVO(
            namedParamsAccessSSealedMVO: (caseModddelSubholder) =>
                caseModddelSubholder.param),
        'dependency': subholder.mapParamsAccessSSealedMVO(
            namedParamsAccessSSealedMVO: (caseModddelSubholder) =>
                caseModddelSubholder.dependency),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class ParamsAccessSSealedSE extends SimpleEntity<InvalidParamsAccessSSealedSE,
    ValidParamsAccessSSealedSE> with _$ParamsAccessSSealedSE {
  ParamsAccessSSealedSE._();

  factory ParamsAccessSSealedSE.namedParamsAccessSSealedSE({
    required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSSealedSE._createNamedParamsAccessSSealedSE(
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
        'param': subholder.mapParamsAccessSSealedSE(
            namedParamsAccessSSealedSE: (caseModddelSubholder) =>
                caseModddelSubholder.param),
        'dependency': subholder.mapParamsAccessSSealedSE(
            namedParamsAccessSSealedSE: (caseModddelSubholder) =>
                caseModddelSubholder.dependency),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class ParamsAccessSSealedIE
    extends ListEntity<InvalidParamsAccessSSealedIE, ValidParamsAccessSSealedIE>
    with _$ParamsAccessSSealedIE {
  ParamsAccessSSealedIE._();

  factory ParamsAccessSSealedIE.namedParamsAccessSSealedIE({
    required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSSealedIE._createNamedParamsAccessSSealedIE(
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
        'param': subholder.mapParamsAccessSSealedIE(
            namedParamsAccessSSealedIE: (caseModddelSubholder) =>
                caseModddelSubholder.param),
        'dependency': subholder.mapParamsAccessSSealedIE(
            namedParamsAccessSSealedIE: (caseModddelSubholder) =>
                caseModddelSubholder.dependency),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class ParamsAccessSSealedI2E extends MapEntity<InvalidParamsAccessSSealedI2E,
    ValidParamsAccessSSealedI2E> with _$ParamsAccessSSealedI2E {
  ParamsAccessSSealedI2E._();

  factory ParamsAccessSSealedI2E.namedParamsAccessSSealedI2E({
    required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$ParamsAccessSSealedI2E._createNamedParamsAccessSSealedI2E(
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
        'param': subholder.mapParamsAccessSSealedI2E(
            namedParamsAccessSSealedI2E: (caseModddelSubholder) =>
                caseModddelSubholder.param),
        'dependency': subholder.mapParamsAccessSSealedI2E(
            namedParamsAccessSSealedI2E: (caseModddelSubholder) =>
                caseModddelSubholder.dependency),
      });
    }
    return subholder.$isModddelValid ? none() : some(LengthEntityFailure());
  }
}

/* ----------------------------------- B2 ----------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class WithGetterParamsAccessSSealedSVO extends SingleValueObject<
        InvalidWithGetterParamsAccessSSealedSVO,
        ValidWithGetterParamsAccessSSealedSVO>
    with _$WithGetterParamsAccessSSealedSVO {
  WithGetterParamsAccessSSealedSVO._();

  factory WithGetterParamsAccessSSealedSVO.namedWithGetterParamsAccessSSealedSVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSSealedSVO
        ._createNamedWithGetterParamsAccessSSealedSVO(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.mapWithGetterParamsAccessSSealedSVO(
            namedWithGetterParamsAccessSSealedSVO: (caseModddelSubholder) =>
                caseModddelSubholder.param),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class WithGetterParamsAccessSSealedMVO extends MultiValueObject<
        InvalidWithGetterParamsAccessSSealedMVO,
        ValidWithGetterParamsAccessSSealedMVO>
    with _$WithGetterParamsAccessSSealedMVO {
  WithGetterParamsAccessSSealedMVO._();

  factory WithGetterParamsAccessSSealedMVO.namedWithGetterParamsAccessSSealedMVO({
    @withGetter required String param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSSealedMVO
        ._createNamedWithGetterParamsAccessSSealedMVO(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.mapWithGetterParamsAccessSSealedMVO(
            namedWithGetterParamsAccessSSealedMVO: (caseModddelSubholder) =>
                caseModddelSubholder.param),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class WithGetterParamsAccessSSealedSE extends SimpleEntity<
        InvalidWithGetterParamsAccessSSealedSE,
        ValidWithGetterParamsAccessSSealedSE>
    with _$WithGetterParamsAccessSSealedSE {
  WithGetterParamsAccessSSealedSE._();

  factory WithGetterParamsAccessSSealedSE.namedWithGetterParamsAccessSSealedSE({
    @withGetter required MyModddel param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSSealedSE
        ._createNamedWithGetterParamsAccessSSealedSE(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.mapWithGetterParamsAccessSSealedSE(
            namedWithGetterParamsAccessSSealedSE: (caseModddelSubholder) =>
                caseModddelSubholder.param),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class WithGetterParamsAccessSSealedIE extends ListEntity<
        InvalidWithGetterParamsAccessSSealedIE,
        ValidWithGetterParamsAccessSSealedIE>
    with _$WithGetterParamsAccessSSealedIE {
  WithGetterParamsAccessSSealedIE._();

  factory WithGetterParamsAccessSSealedIE.namedWithGetterParamsAccessSSealedIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSSealedIE
        ._createNamedWithGetterParamsAccessSSealedIE(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.mapWithGetterParamsAccessSSealedIE(
            namedWithGetterParamsAccessSSealedIE: (caseModddelSubholder) =>
                caseModddelSubholder.param),
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
    SharedProp('bool', '\$isModddelValid'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class WithGetterParamsAccessSSealedI2E extends MapEntity<
        InvalidWithGetterParamsAccessSSealedI2E,
        ValidWithGetterParamsAccessSSealedI2E>
    with _$WithGetterParamsAccessSSealedI2E {
  WithGetterParamsAccessSSealedI2E._();

  factory WithGetterParamsAccessSSealedI2E.namedWithGetterParamsAccessSSealedI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required bool $isModddelValid,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$WithGetterParamsAccessSSealedI2E
        ._createNamedWithGetterParamsAccessSSealedI2E(
      param: param,
      $isModddelValid: $isModddelValid,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    if (subholder.$validateMethodShouldThrowInfos) {
      throw ValidateMethodParametersInformation(parameters: {
        'param': subholder.mapWithGetterParamsAccessSSealedI2E(
            namedWithGetterParamsAccessSSealedI2E: (caseModddelSubholder) =>
                caseModddelSubholder.param),
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
