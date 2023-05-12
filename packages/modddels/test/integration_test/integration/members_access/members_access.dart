// NB : This import will be replaced by 'modddels_annotation_dartz' during tests
// for said package. Also, to avoid any conflicts, do not import functional
// programming packages in this file like 'fp_dart' or 'dartz'.
//
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../_common.dart';
part 'members_access.modddel.dart';

// Modddels groups :
//
// - A1. Solo modddels created with the private constructor
// - A2. Solo modddels created with the factory constructor
// - B1. SSealed modddels created with the private constructor
// - B2. SSealed modddels created with the factory constructor
//

/* -------------------------------------------------------------------------- */
/*                                  Modddels                                  */
/* -------------------------------------------------------------------------- */

/* --------------------------------- A1 & A2 -------------------------------- */

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class MembersAccessSoloSVO extends SingleValueObject<
        InvalidMembersAccessSoloSVO, ValidMembersAccessSoloSVO>
    with _ValidateMethodErrorsMixin, _$MembersAccessSoloSVO {
  MembersAccessSoloSVO._();

  static MembersAccessSoloSVO privateConstructor() => MembersAccessSoloSVO._();

  factory MembersAccessSoloSVO({
    @withGetter required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSoloSVO._create(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidValue: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidValue: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidValue: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidValue: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
  }
}

@Modddel(validationSteps: [
  ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
])
class MembersAccessSoloMVO extends MultiValueObject<InvalidMembersAccessSoloMVO,
        ValidMembersAccessSoloMVO>
    with _ValidateMethodErrorsMixin, _$MembersAccessSoloMVO {
  MembersAccessSoloMVO._();

  static MembersAccessSoloMVO privateConstructor() => MembersAccessSoloMVO._();

  factory MembersAccessSoloMVO({
    @withGetter required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSoloMVO._create(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidValue: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidValue: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidValue: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidValue: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class MembersAccessSoloSE
    extends SimpleEntity<InvalidMembersAccessSoloSE, ValidMembersAccessSoloSE>
    with _ValidateMethodErrorsMixin, _$MembersAccessSoloSE {
  MembersAccessSoloSE._();

  static MembersAccessSoloSE privateConstructor() => MembersAccessSoloSE._();

  factory MembersAccessSoloSE({
    @withGetter required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSoloSE._create(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidMid: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidMid: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidMid: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidMid: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class MembersAccessSoloIE
    extends ListEntity<InvalidMembersAccessSoloIE, ValidMembersAccessSoloIE>
    with _ValidateMethodErrorsMixin, _$MembersAccessSoloIE {
  MembersAccessSoloIE._();

  static MembersAccessSoloIE privateConstructor() => MembersAccessSoloIE._();

  factory MembersAccessSoloIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSoloIE._create(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidMid: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidMid: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidMid: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidMid: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('length', FailureType<LengthEntityFailure>()),
  ])
])
class MembersAccessSoloI2E
    extends MapEntity<InvalidMembersAccessSoloI2E, ValidMembersAccessSoloI2E>
    with _ValidateMethodErrorsMixin, _$MembersAccessSoloI2E {
  MembersAccessSoloI2E._();

  static MembersAccessSoloI2E privateConstructor() => MembersAccessSoloI2E._();

  factory MembersAccessSoloI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSoloI2E._create(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidMid: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidMid: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidMid: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidMid: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
  }
}

/* --------------------------------- B1 & B2 -------------------------------- */

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('String', 'param'),
    SharedProp('MyService', 'dependency'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class MembersAccessSSealedSVO extends SingleValueObject<
        InvalidMembersAccessSSealedSVO, ValidMembersAccessSSealedSVO>
    with _ValidateMethodErrorsMixin, _$MembersAccessSSealedSVO {
  MembersAccessSSealedSVO._();

  static MembersAccessSSealedSVO privateConstructor() =>
      MembersAccessSSealedSVO._();

  factory MembersAccessSSealedSVO.namedMembersAccessSSealedSVO({
    @withGetter required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSSealedSVO._createNamedMembersAccessSSealedSVO(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidValue: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidValue: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidValue: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidValue: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    _collectInstanceError(() {
      mapMembersAccessSSealedSVO(namedMembersAccessSSealedSVO: (_) {});
    }, 'mapMembersAccessSSealedSVO');
    _collectInstanceError(() {
      maybeMapMembersAccessSSealedSVO(
          namedMembersAccessSSealedSVO: (_) {}, orElse: () {});
    }, 'maybeMapMembersAccessSSealedSVO');
    _collectInstanceError(() {
      mapOrNullMembersAccessSSealedSVO(namedMembersAccessSSealedSVO: (_) {});
    }, 'mapOrNullMembersAccessSSealedSVO');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    _collectSubholderError(() {
      subholder.mapMembersAccessSSealedSVO(
          namedMembersAccessSSealedSVO: (_) {});
    }, 'mapMembersAccessSSealedSVO');
    _collectSubholderError(() {
      subholder.maybeMapMembersAccessSSealedSVO(
          namedMembersAccessSSealedSVO: (_) {}, orElse: () {});
    }, 'maybeMapMembersAccessSSealedSVO');
    _collectSubholderError(() {
      subholder.mapOrNullMembersAccessSSealedSVO(
          namedMembersAccessSSealedSVO: (_) {});
    }, 'mapOrNullMembersAccessSSealedSVO');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
  }
}

@Modddel(
  validationSteps: [
    ValidationStep([Validation('length', FailureType<LengthValueFailure>())])
  ],
  sharedProps: [
    SharedProp('String', 'param'),
    SharedProp('MyService', 'dependency'),
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class MembersAccessSSealedMVO extends MultiValueObject<
        InvalidMembersAccessSSealedMVO, ValidMembersAccessSSealedMVO>
    with _ValidateMethodErrorsMixin, _$MembersAccessSSealedMVO {
  MembersAccessSSealedMVO._();

  static MembersAccessSSealedMVO privateConstructor() =>
      MembersAccessSSealedMVO._();

  factory MembersAccessSSealedMVO.namedMembersAccessSSealedMVO({
    @withGetter required String param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSSealedMVO._createNamedMembersAccessSSealedMVO(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthValueFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidValue: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidValue: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidValue: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidValue: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    _collectInstanceError(() {
      mapMembersAccessSSealedMVO(namedMembersAccessSSealedMVO: (_) {});
    }, 'mapModddels');
    _collectInstanceError(() {
      maybeMapMembersAccessSSealedMVO(
          namedMembersAccessSSealedMVO: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectInstanceError(() {
      mapOrNullMembersAccessSSealedMVO(namedMembersAccessSSealedMVO: (_) {});
    }, 'mapOrNullModddels');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    _collectSubholderError(() {
      subholder.mapMembersAccessSSealedMVO(
          namedMembersAccessSSealedMVO: (_) {});
    }, 'mapModddels');
    _collectSubholderError(() {
      subholder.maybeMapMembersAccessSSealedMVO(
          namedMembersAccessSSealedMVO: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectSubholderError(() {
      subholder.mapOrNullMembersAccessSSealedMVO(
          namedMembersAccessSSealedMVO: (_) {});
    }, 'mapOrNullModddels');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
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
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class MembersAccessSSealedSE extends SimpleEntity<InvalidMembersAccessSSealedSE,
        ValidMembersAccessSSealedSE>
    with _ValidateMethodErrorsMixin, _$MembersAccessSSealedSE {
  MembersAccessSSealedSE._();

  static MembersAccessSSealedSE privateConstructor() =>
      MembersAccessSSealedSE._();

  factory MembersAccessSSealedSE.namedMembersAccessSSealedSE({
    @withGetter required MyModddel param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSSealedSE._createNamedMembersAccessSSealedSE(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidMid: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidMid: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidMid: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidMid: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    _collectInstanceError(() {
      mapMembersAccessSSealedSE(namedMembersAccessSSealedSE: (_) {});
    }, 'mapModddels');
    _collectInstanceError(() {
      maybeMapMembersAccessSSealedSE(
          namedMembersAccessSSealedSE: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectInstanceError(() {
      mapOrNullMembersAccessSSealedSE(namedMembersAccessSSealedSE: (_) {});
    }, 'mapOrNullModddels');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    _collectSubholderError(() {
      subholder.mapMembersAccessSSealedSE(namedMembersAccessSSealedSE: (_) {});
    }, 'mapModddels');
    _collectSubholderError(() {
      subholder.maybeMapMembersAccessSSealedSE(
          namedMembersAccessSSealedSE: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectSubholderError(() {
      subholder.mapOrNullMembersAccessSSealedSE(
          namedMembersAccessSSealedSE: (_) {});
    }, 'mapOrNullModddels');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
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
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class MembersAccessSSealedIE extends ListEntity<InvalidMembersAccessSSealedIE,
        ValidMembersAccessSSealedIE>
    with _ValidateMethodErrorsMixin, _$MembersAccessSSealedIE {
  MembersAccessSSealedIE._();

  static MembersAccessSSealedIE privateConstructor() =>
      MembersAccessSSealedIE._();

  factory MembersAccessSSealedIE.namedMembersAccessSSealedIE({
    @withGetter required List<MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSSealedIE._createNamedMembersAccessSSealedIE(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidMid: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidMid: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidMid: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidMid: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    _collectInstanceError(() {
      mapMembersAccessSSealedIE(namedMembersAccessSSealedIE: (_) {});
    }, 'mapModddels');
    _collectInstanceError(() {
      maybeMapMembersAccessSSealedIE(
          namedMembersAccessSSealedIE: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectInstanceError(() {
      mapOrNullMembersAccessSSealedIE(namedMembersAccessSSealedIE: (_) {});
    }, 'mapOrNullModddels');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    _collectSubholderError(() {
      subholder.mapMembersAccessSSealedIE(namedMembersAccessSSealedIE: (_) {});
    }, 'mapModddels');
    _collectSubholderError(() {
      subholder.maybeMapMembersAccessSSealedIE(
          namedMembersAccessSSealedIE: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectSubholderError(() {
      subholder.mapOrNullMembersAccessSSealedIE(
          namedMembersAccessSSealedIE: (_) {});
    }, 'mapOrNullModddels');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
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
    SharedProp('bool', '\$validateMethodShouldThrowInfos'),
  ],
)
class MembersAccessSSealedI2E extends MapEntity<InvalidMembersAccessSSealedI2E,
        ValidMembersAccessSSealedI2E>
    with _ValidateMethodErrorsMixin, _$MembersAccessSSealedI2E {
  MembersAccessSSealedI2E._();

  static MembersAccessSSealedI2E privateConstructor() =>
      MembersAccessSSealedI2E._();

  factory MembersAccessSSealedI2E.namedMembersAccessSSealedI2E({
    @withGetter required Map<MyModddel, MyModddel> param,
    @dependencyParam required MyService dependency,
    @dependencyParam required bool $validateMethodShouldThrowInfos,
  }) {
    return _$MembersAccessSSealedI2E._createNamedMembersAccessSSealedI2E(
      param: param,
      dependency: dependency,
      $validateMethodShouldThrowInfos: $validateMethodShouldThrowInfos,
    );
  }

  @override
  Option<LengthEntityFailure> validateLength(subholder) {
    // Instance members
    _collectCommonInstanceErrors();

    _collectInstanceError(() => copyWith(), 'copyWith');
    _collectInstanceError(() {
      map(valid: (_) {}, invalidMid: (_) {});
    }, 'map');
    _collectInstanceError(() {
      maybeMap(valid: (_) {}, invalidMid: (_) {}, orElse: () {});
    }, 'maybeMap');
    _collectInstanceError(() {
      mapOrNull(valid: (_) {}, invalidMid: (_) {});
    }, 'mapOrNull');
    _collectInstanceError(() {
      maybeMapValidity(valid: (_) {}, invalidMid: (_) {}, orElse: (_) {});
    }, 'maybeMapValidity');

    _collectInstanceError(() {
      mapMembersAccessSSealedI2E(namedMembersAccessSSealedI2E: (_) {});
    }, 'mapModddels');
    _collectInstanceError(() {
      maybeMapMembersAccessSSealedI2E(
          namedMembersAccessSSealedI2E: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectInstanceError(() {
      mapOrNullMembersAccessSSealedI2E(namedMembersAccessSSealedI2E: (_) {});
    }, 'mapOrNullModddels');

    // Subholder members
    _collectSubholderError(() => subholder.param, 'param');
    _collectSubholderError(() => subholder.dependency, 'dependency');

    _collectSubholderError(() {
      subholder.mapMembersAccessSSealedI2E(
          namedMembersAccessSSealedI2E: (_) {});
    }, 'mapModddels');
    _collectSubholderError(() {
      subholder.maybeMapMembersAccessSSealedI2E(
          namedMembersAccessSSealedI2E: (_) {}, orElse: () {});
    }, 'maybeMapModddels');
    _collectSubholderError(() {
      subholder.mapOrNullMembersAccessSSealedI2E(
          namedMembersAccessSSealedI2E: (_) {});
    }, 'mapOrNullModddels');

    // Throw collected errors infos
    if (subholder.$validateMethodShouldThrowInfos) {
      _throwValidateMethodErrorsInformation();
    } else {
      return none();
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

mixin _ValidateMethodErrorsMixin<I extends InvalidModddel,
    V extends ValidModddel> on BaseModddel<I, V> {
  MyService get dependency;

  Object? get param;

  /// A Map where the keys are the names of the accessed instance members, and
  /// the values are whether the access threw an error.
  ///
  final _instanceErrors = <String, bool>{};

  /// A Map where the keys are the names of the accessed subholder members, and
  /// the values are whether the access threw an error.
  ///
  final _subholderErrors = <String, bool>{};

  /// Collects the potential errors due to accessing an instance member inside
  /// the validate method.
  ///
  /// The [callback] should contain the instance member access, and the
  /// [memberName] should be the name of that member.
  ///
  /// NB : The [memberName] should be unique.
  ///
  void _collectInstanceError(void Function() callback, String memberName) {
    if (_instanceErrors.containsKey(memberName)) {
      throw ArgumentError.value(
          memberName, 'memberName', 'The provided [memberName] must be unique');
    }

    bool isError = false;

    try {
      callback();
    } on Error catch (e) {
      if (e is UnsupportedError ||
          e.toString().contains('LateInitializationError')) {
        isError = true;
      }
    }

    _instanceErrors.putIfAbsent(memberName, () => isError);
  }

  /// Collects the potential errors due to accessing a member of the subholder
  /// inside the validate method.
  ///
  /// The [callback] should contain the subholder member access, and the
  /// [memberName] should be the name of that member.
  ///
  /// NB : The [memberName] should be unique.
  ///
  void _collectSubholderError(void Function() callback, String memberName) {
    if (_subholderErrors.containsKey(memberName)) {
      throw ArgumentError('The provided [memberName] must be unique.');
    }

    bool isError = false;

    try {
      callback();
    } on Error catch (e) {
      if (e is UnsupportedError ||
          e.toString().contains('LateInitializationError')) {
        isError = true;
      }
    }

    _subholderErrors.putIfAbsent(memberName, () => isError);
  }

  void _collectCommonInstanceErrors() {
    _collectInstanceError(() => isValid, 'isValid');
    _collectInstanceError(() => toEither, 'toEither');
    _collectInstanceError(() => toBroadEither, 'toBroadEither');
    _collectInstanceError(() {
      mapValidity(valid: (_) {}, invalid: (_) {});
    }, 'mapValidity');
    _collectInstanceError(() => props, 'props');

    _collectInstanceError(() => param, 'param');
    _collectInstanceError(() => dependency, 'dependency');
  }

  /// Throws a [ValidateMethodErrorsInformation] which should be caught inside
  /// the test function so as to access information about the validate method.
  ///
  Never _throwValidateMethodErrorsInformation() {
    throw ValidateMethodErrorsInformation(
      instanceErrors: _instanceErrors,
      subholderErrors: _subholderErrors,
    );
  }
}

/// Error thrown inside the validate method and that holds information about
/// about how the validate method is operating.
///
/// Its purpose is communicating such info to the test function, which
/// otherwise wouldn't be able to access it.
///
class ValidateMethodErrorsInformation extends Error {
  ValidateMethodErrorsInformation({
    required this.instanceErrors,
    required this.subholderErrors,
  });

  /// A Map where the keys are the names of the accessed instance members, and
  /// the values are whether the access threw an error.
  ///
  final Map<String, bool> instanceErrors;

  /// A Map where the keys are the names of the accessed subholder members, and
  /// the values are whether the access threw an error.
  ///
  final Map<String, bool> subholderErrors;
}
