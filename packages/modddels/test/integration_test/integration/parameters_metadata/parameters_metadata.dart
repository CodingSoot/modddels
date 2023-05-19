// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../_common.dart';

part 'parameters_metadata.modddel.dart';

// Modddels groups : SSealed modddels that have :
//
// - A. Solo modddels that have :
//   - A1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters
//   - A2 : Member parameters with the `@withGetter` annotation
// - B. SSealed modddels that have :
//   - B1 : Member parameters (without the `@withGetter` annotation) +
//     Dependency parameters
//     - B1a : The parameters are not shared
//     - B1b : The parameters are shared
//   - B2 : Member parameters with the `@withGetter` annotation
//     - B2a : The parameters are not shared
//     - B2b : The parameters are shared
//

/* -------------------------------------------------------------------------- */
/*                                  Modddels                                  */
/* -------------------------------------------------------------------------- */

/* ----------------------------------- A1 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class ParametersSoloSVO
    extends SingleValueObject<InvalidParametersSoloSVO, ValidParametersSoloSVO>
    with _$ParametersSoloSVO {
  ParametersSoloSVO._();

  factory ParametersSoloSVO({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required String param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSoloSVO._create(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(parametersSoloSVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class ParametersSoloMVO
    extends MultiValueObject<InvalidParametersSoloMVO, ValidParametersSoloMVO>
    with _$ParametersSoloMVO {
  ParametersSoloMVO._();

  factory ParametersSoloMVO({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required String param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSoloMVO._create(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(parametersSoloMVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class ParametersSoloSE
    extends SimpleEntity<InvalidParametersSoloSE, ValidParametersSoloSE>
    with _$ParametersSoloSE {
  ParametersSoloSE._();

  factory ParametersSoloSE({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required MyModddel param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSoloSE._create(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersSoloSE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class ParametersSoloIE
    extends ListEntity<InvalidParametersSoloIE, ValidParametersSoloIE>
    with _$ParametersSoloIE {
  ParametersSoloIE._();

  factory ParametersSoloIE({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required List<MyModddel> param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSoloIE._create(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersSoloIE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class ParametersSoloI2E
    extends MapEntity<InvalidParametersSoloI2E, ValidParametersSoloI2E>
    with _$ParametersSoloI2E {
  ParametersSoloI2E._();

  factory ParametersSoloI2E({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required Map<MyModddel, MyModddel> param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSoloI2E._create(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersSoloI2E) {
    return none();
  }
}

/* ----------------------------------- A2 ----------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class WithGetterParametersSoloSVO extends SingleValueObject<
    InvalidWithGetterParametersSoloSVO,
    ValidWithGetterParametersSoloSVO> with _$WithGetterParametersSoloSVO {
  WithGetterParametersSoloSVO._();

  factory WithGetterParametersSoloSVO({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required String param,
  }) {
    return _$WithGetterParametersSoloSVO._create(
      param: param,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(withGetterParametersSoloSVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class WithGetterParametersSoloMVO extends MultiValueObject<
    InvalidWithGetterParametersSoloMVO,
    ValidWithGetterParametersSoloMVO> with _$WithGetterParametersSoloMVO {
  WithGetterParametersSoloMVO._();

  factory WithGetterParametersSoloMVO({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required String param,
  }) {
    return _$WithGetterParametersSoloMVO._create(
      param: param,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(withGetterParametersSoloMVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class WithGetterParametersSoloSE extends SimpleEntity<
    InvalidWithGetterParametersSoloSE,
    ValidWithGetterParametersSoloSE> with _$WithGetterParametersSoloSE {
  WithGetterParametersSoloSE._();

  factory WithGetterParametersSoloSE({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required MyModddel param,
  }) {
    return _$WithGetterParametersSoloSE._create(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(withGetterParametersSoloSE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class WithGetterParametersSoloIE extends ListEntity<
    InvalidWithGetterParametersSoloIE,
    ValidWithGetterParametersSoloIE> with _$WithGetterParametersSoloIE {
  WithGetterParametersSoloIE._();

  factory WithGetterParametersSoloIE({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required List<MyModddel> param,
  }) {
    return _$WithGetterParametersSoloIE._create(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(withGetterParametersSoloIE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class WithGetterParametersSoloI2E extends MapEntity<
    InvalidWithGetterParametersSoloI2E,
    ValidWithGetterParametersSoloI2E> with _$WithGetterParametersSoloI2E {
  WithGetterParametersSoloI2E._();

  factory WithGetterParametersSoloI2E({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param')
    @withGetter
    required Map<MyModddel, MyModddel> param,
  }) {
    return _$WithGetterParametersSoloI2E._create(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(withGetterParametersSoloI2E) {
    return none();
  }
}

/* ----------------------------------- B1a ---------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class ParametersNonSharedSSealedSVO extends SingleValueObject<
    InvalidParametersNonSharedSSealedSVO,
    ValidParametersNonSharedSSealedSVO> with _$ParametersNonSharedSSealedSVO {
  ParametersNonSharedSSealedSVO._();

  factory ParametersNonSharedSSealedSVO.namedParametersNonSharedSSealedSVO({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required String param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersNonSharedSSealedSVO
        ._createNamedParametersNonSharedSSealedSVO(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(parametersNonSharedSSealedSVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class ParametersNonSharedSSealedMVO extends MultiValueObject<
    InvalidParametersNonSharedSSealedMVO,
    ValidParametersNonSharedSSealedMVO> with _$ParametersNonSharedSSealedMVO {
  ParametersNonSharedSSealedMVO._();

  factory ParametersNonSharedSSealedMVO.namedParametersNonSharedSSealedMVO({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required String param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersNonSharedSSealedMVO
        ._createNamedParametersNonSharedSSealedMVO(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(parametersNonSharedSSealedMVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class ParametersNonSharedSSealedSE extends SimpleEntity<
    InvalidParametersNonSharedSSealedSE,
    ValidParametersNonSharedSSealedSE> with _$ParametersNonSharedSSealedSE {
  ParametersNonSharedSSealedSE._();

  factory ParametersNonSharedSSealedSE.namedParametersNonSharedSSealedSE({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required MyModddel param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersNonSharedSSealedSE
        ._createNamedParametersNonSharedSSealedSE(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersNonSharedSSealedSE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class ParametersNonSharedSSealedIE extends ListEntity<
    InvalidParametersNonSharedSSealedIE,
    ValidParametersNonSharedSSealedIE> with _$ParametersNonSharedSSealedIE {
  ParametersNonSharedSSealedIE._();

  factory ParametersNonSharedSSealedIE.namedParametersNonSharedSSealedIE({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required List<MyModddel> param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersNonSharedSSealedIE
        ._createNamedParametersNonSharedSSealedIE(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersNonSharedSSealedIE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class ParametersNonSharedSSealedI2E extends MapEntity<
    InvalidParametersNonSharedSSealedI2E,
    ValidParametersNonSharedSSealedI2E> with _$ParametersNonSharedSSealedI2E {
  ParametersNonSharedSSealedI2E._();

  factory ParametersNonSharedSSealedI2E.namedParametersNonSharedSSealedI2E({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required Map<MyModddel, MyModddel> param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersNonSharedSSealedI2E
        ._createNamedParametersNonSharedSSealedI2E(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersNonSharedSSealedI2E) {
    return none();
  }
}

/* ----------------------------------- B1b ---------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], sharedProps: [
  SharedProp('String', 'param'),
  SharedProp('MyService', 'dependency'),
], generateTestClasses: true)
class ParametersSharedSSealedSVO extends SingleValueObject<
    InvalidParametersSharedSSealedSVO,
    ValidParametersSharedSSealedSVO> with _$ParametersSharedSSealedSVO {
  ParametersSharedSSealedSVO._();

  factory ParametersSharedSSealedSVO.namedParametersSharedSSealedSVO({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required String param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSharedSSealedSVO._createNamedParametersSharedSSealedSVO(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(parametersSharedSSealedSVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], sharedProps: [
  SharedProp('String', 'param'),
  SharedProp('MyService', 'dependency'),
], generateTestClasses: true)
class ParametersSharedSSealedMVO extends MultiValueObject<
    InvalidParametersSharedSSealedMVO,
    ValidParametersSharedSSealedMVO> with _$ParametersSharedSSealedMVO {
  ParametersSharedSSealedMVO._();

  factory ParametersSharedSSealedMVO.namedParametersSharedSSealedMVO({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required String param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSharedSSealedMVO._createNamedParametersSharedSSealedMVO(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(parametersSharedSSealedMVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('MyModddel', 'param'),
  SharedProp('MyService', 'dependency'),
], generateTestClasses: true)
class ParametersSharedSSealedSE extends SimpleEntity<
    InvalidParametersSharedSSealedSE,
    ValidParametersSharedSSealedSE> with _$ParametersSharedSSealedSE {
  ParametersSharedSSealedSE._();

  factory ParametersSharedSSealedSE.namedParametersSharedSSealedSE({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required MyModddel param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSharedSSealedSE._createNamedParametersSharedSSealedSE(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersSharedSSealedSE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('List<MyModddel>', 'param'),
  SharedProp('MyService', 'dependency'),
], generateTestClasses: true)
class ParametersSharedSSealedIE extends ListEntity<
    InvalidParametersSharedSSealedIE,
    ValidParametersSharedSSealedIE> with _$ParametersSharedSSealedIE {
  ParametersSharedSSealedIE._();

  factory ParametersSharedSSealedIE.namedParametersSharedSSealedIE({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required List<MyModddel> param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSharedSSealedIE._createNamedParametersSharedSSealedIE(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersSharedSSealedIE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('Map<MyModddel, MyModddel>', 'param'),
  SharedProp('MyService', 'dependency'),
], generateTestClasses: true)
class ParametersSharedSSealedI2E extends MapEntity<
    InvalidParametersSharedSSealedI2E,
    ValidParametersSharedSSealedI2E> with _$ParametersSharedSSealedI2E {
  ParametersSharedSSealedI2E._();

  factory ParametersSharedSSealedI2E.namedParametersSharedSSealedI2E({
    /// The very long multiline comment
    /// for member parameter
    @Deprecated('old param') required Map<MyModddel, MyModddel> param,

    /// The comment for a dependency parameter
    @Deprecated('old dependency')
    @dependencyParam
    required MyService dependency,
  }) {
    return _$ParametersSharedSSealedI2E._createNamedParametersSharedSSealedI2E(
      param: param,
      dependency: dependency,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(parametersSharedSSealedI2E) {
    return none();
  }
}

/* ----------------------------------- B2a ---------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class WithGetterParametersNonSharedSSealedSVO extends SingleValueObject<
        InvalidWithGetterParametersNonSharedSSealedSVO,
        ValidWithGetterParametersNonSharedSSealedSVO>
    with _$WithGetterParametersNonSharedSSealedSVO {
  WithGetterParametersNonSharedSSealedSVO._();

  factory WithGetterParametersNonSharedSSealedSVO.namedWithGetterParametersNonSharedSSealedSVO({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required String param,
  }) {
    return _$WithGetterParametersNonSharedSSealedSVO
        ._createNamedWithGetterParametersNonSharedSSealedSVO(
      param: param,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(
      withGetterParametersNonSharedSSealedSVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], generateTestClasses: true)
class WithGetterParametersNonSharedSSealedMVO extends MultiValueObject<
        InvalidWithGetterParametersNonSharedSSealedMVO,
        ValidWithGetterParametersNonSharedSSealedMVO>
    with _$WithGetterParametersNonSharedSSealedMVO {
  WithGetterParametersNonSharedSSealedMVO._();

  factory WithGetterParametersNonSharedSSealedMVO.namedWithGetterParametersNonSharedSSealedMVO({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required String param,
  }) {
    return _$WithGetterParametersNonSharedSSealedMVO
        ._createNamedWithGetterParametersNonSharedSSealedMVO(
      param: param,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(
      withGetterParametersNonSharedSSealedMVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class WithGetterParametersNonSharedSSealedSE extends SimpleEntity<
        InvalidWithGetterParametersNonSharedSSealedSE,
        ValidWithGetterParametersNonSharedSSealedSE>
    with _$WithGetterParametersNonSharedSSealedSE {
  WithGetterParametersNonSharedSSealedSE._();

  factory WithGetterParametersNonSharedSSealedSE.namedWithGetterParametersNonSharedSSealedSE({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required MyModddel param,
  }) {
    return _$WithGetterParametersNonSharedSSealedSE
        ._createNamedWithGetterParametersNonSharedSSealedSE(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(
      withGetterParametersNonSharedSSealedSE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class WithGetterParametersNonSharedSSealedIE extends ListEntity<
        InvalidWithGetterParametersNonSharedSSealedIE,
        ValidWithGetterParametersNonSharedSSealedIE>
    with _$WithGetterParametersNonSharedSSealedIE {
  WithGetterParametersNonSharedSSealedIE._();

  factory WithGetterParametersNonSharedSSealedIE.namedWithGetterParametersNonSharedSSealedIE({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required List<MyModddel> param,
  }) {
    return _$WithGetterParametersNonSharedSSealedIE
        ._createNamedWithGetterParametersNonSharedSSealedIE(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(
      withGetterParametersNonSharedSSealedIE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], generateTestClasses: true)
class WithGetterParametersNonSharedSSealedI2E extends MapEntity<
        InvalidWithGetterParametersNonSharedSSealedI2E,
        ValidWithGetterParametersNonSharedSSealedI2E>
    with _$WithGetterParametersNonSharedSSealedI2E {
  WithGetterParametersNonSharedSSealedI2E._();

  factory WithGetterParametersNonSharedSSealedI2E.namedWithGetterParametersNonSharedSSealedI2E({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param')
    @withGetter
    required Map<MyModddel, MyModddel> param,
  }) {
    return _$WithGetterParametersNonSharedSSealedI2E
        ._createNamedWithGetterParametersNonSharedSSealedI2E(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(
      withGetterParametersNonSharedSSealedI2E) {
    return none();
  }
}

/* ----------------------------------- B2b ---------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], sharedProps: [
  SharedProp('String', 'param')
], generateTestClasses: true)
class WithGetterParametersSharedSSealedSVO extends SingleValueObject<
        InvalidWithGetterParametersSharedSSealedSVO,
        ValidWithGetterParametersSharedSSealedSVO>
    with _$WithGetterParametersSharedSSealedSVO {
  WithGetterParametersSharedSSealedSVO._();

  factory WithGetterParametersSharedSSealedSVO.namedWithGetterParametersSharedSSealedSVO({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required String param,
  }) {
    return _$WithGetterParametersSharedSSealedSVO
        ._createNamedWithGetterParametersSharedSSealedSVO(
      param: param,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(
      withGetterParametersSharedSSealedSVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
], sharedProps: [
  SharedProp('String', 'param')
], generateTestClasses: true)
class WithGetterParametersSharedSSealedMVO extends MultiValueObject<
        InvalidWithGetterParametersSharedSSealedMVO,
        ValidWithGetterParametersSharedSSealedMVO>
    with _$WithGetterParametersSharedSSealedMVO {
  WithGetterParametersSharedSSealedMVO._();

  factory WithGetterParametersSharedSSealedMVO.namedWithGetterParametersSharedSSealedMVO({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required String param,
  }) {
    return _$WithGetterParametersSharedSSealedMVO
        ._createNamedWithGetterParametersSharedSSealedMVO(
      param: param,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(
      withGetterParametersSharedSSealedMVO) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('MyModddel', 'param')
], generateTestClasses: true)
class WithGetterParametersSharedSSealedSE extends SimpleEntity<
        InvalidWithGetterParametersSharedSSealedSE,
        ValidWithGetterParametersSharedSSealedSE>
    with _$WithGetterParametersSharedSSealedSE {
  WithGetterParametersSharedSSealedSE._();

  factory WithGetterParametersSharedSSealedSE.namedWithGetterParametersSharedSSealedSE({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required MyModddel param,
  }) {
    return _$WithGetterParametersSharedSSealedSE
        ._createNamedWithGetterParametersSharedSSealedSE(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(
      withGetterParametersSharedSSealedSE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('List<MyModddel>', 'param')
], generateTestClasses: true)
class WithGetterParametersSharedSSealedIE extends ListEntity<
        InvalidWithGetterParametersSharedSSealedIE,
        ValidWithGetterParametersSharedSSealedIE>
    with _$WithGetterParametersSharedSSealedIE {
  WithGetterParametersSharedSSealedIE._();

  factory WithGetterParametersSharedSSealedIE.namedWithGetterParametersSharedSSealedIE({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param') @withGetter required List<MyModddel> param,
  }) {
    return _$WithGetterParametersSharedSSealedIE
        ._createNamedWithGetterParametersSharedSSealedIE(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(
      withGetterParametersSharedSSealedIE) {
    return none();
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
], sharedProps: [
  SharedProp('Map<MyModddel, MyModddel>', 'param')
], generateTestClasses: true)
class WithGetterParametersSharedSSealedI2E extends MapEntity<
        InvalidWithGetterParametersSharedSSealedI2E,
        ValidWithGetterParametersSharedSSealedI2E>
    with _$WithGetterParametersSharedSSealedI2E {
  WithGetterParametersSharedSSealedI2E._();

  factory WithGetterParametersSharedSSealedI2E.namedWithGetterParametersSharedSSealedI2E({
    /// This is a comment for a "withGetter" param
    @Deprecated('old param')
    @withGetter
    required Map<MyModddel, MyModddel> param,
  }) {
    return _$WithGetterParametersSharedSSealedI2E
        ._createNamedWithGetterParametersSharedSSealedI2E(
      param: param,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(
      withGetterParametersSharedSSealedI2E) {
    return none();
  }
}
