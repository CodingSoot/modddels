import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';

/* -------------------------------------------------------------------------- */
/*                         Shared parameter is unique                         */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'UnresolvedParametersException: There is more than one shared prop with the '
  'name "param".\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsLength,
  sharedProps: [SharedProp('AClass', 'param'), SharedProp('AClass', 'param')],
)
class DuplicateSharedParams1 extends SingleValueObject {
  DuplicateSharedParams1._();

  factory DuplicateSharedParams1(AClass param) => DuplicateSharedParams1._();

  factory DuplicateSharedParams1.named(AClass param) =>
      DuplicateSharedParams1._();
}

@ShouldThrow(
  'UnresolvedParametersException: There is more than one shared prop with the '
  'name "param".\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsLength,
  sharedProps: [
    SharedProp('AClass?', 'param'),
    SharedProp('AService', 'aService'),
    SharedProp('Object?', 'param'),
  ],
)
class DuplicateSharedParams2 extends MultiValueObject {
  DuplicateSharedParams2._();

  factory DuplicateSharedParams2.named1({
    @withGetter AClass? param,
    @dependencyParam AService? aService,
  }) =>
      DuplicateSharedParams2._();

  factory DuplicateSharedParams2.named2({
    required AClass param,
    @dependencyParam required AService aService,
  }) =>
      DuplicateSharedParams2._();
}

@ShouldThrow(
  'UnresolvedParametersException: There is more than one shared prop with the '
  'name "aService".\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [
    SharedProp(
      'AGeneric<String?>',
      'param',
      ignoreNonNullTransformation: true,
      ignoreValidTransformation: true,
    ),
    SharedProp('AService', 'aService', ignoreValidTransformation: true),
    SharedProp('AService', 'aService'),
  ],
)
class DuplicateSharedParams3 extends SimpleEntity {
  DuplicateSharedParams3._();

  factory DuplicateSharedParams3.named1(
    AGeneric<String> param, {
    @dependencyParam required AService aService,
  }) =>
      DuplicateSharedParams3._();

  factory DuplicateSharedParams3.named2({
    @dependencyParam required AService aService,
    required AGeneric<String?> param,
  }) =>
      DuplicateSharedParams3._();
}

@ShouldThrow(
  'UnresolvedParametersException: There is more than one shared prop with the '
  'name "param".\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [
    SharedProp('List<AClass>', 'param', ignoreNonNullTransformation: true),
    SharedProp('List', 'param', ignoreNullTransformation: true)
  ],
)
class DuplicateSharedParams4 extends ListEntity {
  DuplicateSharedParams4._();

  factory DuplicateSharedParams4.named(List<AClass> param) =>
      DuplicateSharedParams4._();
}

@ShouldThrow(
  'UnresolvedParametersException: There is more than one shared prop with the '
  'name "aService".\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [
    SharedProp('AService', 'aService'),
    SharedProp('Map<AClass, AClass>', 'param'),
    SharedProp('AService', 'aService'),
  ],
)
class DuplicateSharedParams5 extends MapEntity {
  DuplicateSharedParams5._();

  factory DuplicateSharedParams5.named1(
    Map<AClass, AClass> param,
    @dependencyParam AService aService,
  ) =>
      DuplicateSharedParams5._();

  factory DuplicateSharedParams5.named2(
    Map<AClass, AClass> param,
    @dependencyParam AService aService,
  ) =>
      DuplicateSharedParams5._();
}

/* -------------------------------------------------------------------------- */
/*              Shared parameter is present in all case-modddels              */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "param" should be present in '
  'all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsLength,
  sharedProps: [SharedProp('AClass', 'param')],
)
class PartialSharedParams1 extends SingleValueObject {
  PartialSharedParams1._();

  factory PartialSharedParams1(AClass param) => PartialSharedParams1._();

  factory PartialSharedParams1.named(AClass other) => PartialSharedParams1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "anotherService" should be '
  'present in all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsLength,
  sharedProps: [
    SharedProp('AClass?', 'param'),
    SharedProp('AService', 'anotherService'),
  ],
)
class PartialSharedParams2 extends MultiValueObject {
  PartialSharedParams2._();

  factory PartialSharedParams2.named1({
    @withGetter AClass? param,
    @dependencyParam AService? aService,
  }) =>
      PartialSharedParams2._();

  factory PartialSharedParams2.named2({
    required AClass param,
    @dependencyParam required AService anotherService,
  }) =>
      PartialSharedParams2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "param2" should be present in '
  'all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [
    SharedProp('AGeneric<num?>', 'param1', ignoreValidTransformation: true),
    SharedProp(
      'AGeneric<String?>',
      'param2',
      ignoreNonNullTransformation: true,
      ignoreValidTransformation: true,
    ),
  ],
)
class PartialSharedParams3 extends SimpleEntity {
  PartialSharedParams3._();

  factory PartialSharedParams3(
    AGeneric<int> param1,
  ) =>
      PartialSharedParams3._();

  factory PartialSharedParams3.named1(
    AGeneric<String> param2, {
    required AGeneric<double?> param1,
  }) =>
      PartialSharedParams3._();

  factory PartialSharedParams3.named2({
    required AGeneric<num> param1,
    required AGeneric<String?> param2,
  }) =>
      PartialSharedParams3._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "inexistant" should be present '
  'in all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [SharedProp('Inexistant', 'inexistant')],
)
class PartialSharedParams4 extends ListEntity {
  PartialSharedParams4._();

  factory PartialSharedParams4.named(List<AClass> param) =>
      PartialSharedParams4._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "inexistant" should be present '
  'in all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [SharedProp('Map<AClass, AClass>', 'inexistant')],
)
class PartialSharedParams5 extends MapEntity {
  PartialSharedParams5._();

  factory PartialSharedParams5.named1(Map<AClass, AClass> param) =>
      PartialSharedParams5._();

  factory PartialSharedParams5.named2(Map<AClass, AClass> param) =>
      PartialSharedParams5._();
}

/* -------------------------------------------------------------------------- */
/*          Shared parameter is of the same kind in all case-modddels         */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "param" should be of the same '
  'kind across all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsLength,
  sharedProps: [SharedProp('AClass', 'param')],
)
class DifferentKindSharedParam1 extends SingleValueObject {
  DifferentKindSharedParam1._();

  factory DifferentKindSharedParam1(AClass param) =>
      DifferentKindSharedParam1._();

  factory DifferentKindSharedParam1.named(
    @dependencyParam AClass param,
    AClass otherParam,
  ) =>
      DifferentKindSharedParam1._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "param2" should be of the same '
  'kind across all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsLength,
  sharedProps: [
    SharedProp('String?', 'param1'),
    SharedProp('AClass?', 'param2'),
  ],
)
class DifferentKindSharedParam2 extends MultiValueObject {
  DifferentKindSharedParam2._();

  factory DifferentKindSharedParam2.named1({
    @withGetter required String param1,
    @withGetter @NullFailure('length', LengthFailure()) required AClass? param2,
  }) =>
      DifferentKindSharedParam2._();

  factory DifferentKindSharedParam2.named2({
    @NullFailure('length', LengthFailure()) required String? param1,
    @dependencyParam AClass? param2,
  }) =>
      DifferentKindSharedParam2._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "aService" should be of the '
  'same kind across all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [
    SharedProp('AGeneric<num>?', 'param1'),
    SharedProp('AService?', 'aService'),
  ],
)
class DifferentKindSharedParam3 extends SimpleEntity {
  DifferentKindSharedParam3._();

  factory DifferentKindSharedParam3.named1({
    @withGetter required AGeneric<int> param1,
    @dependencyParam AService? aService,
  }) =>
      DifferentKindSharedParam3._();

  factory DifferentKindSharedParam3.named2(
    @validParam AGeneric<int> param1, {
    required AClass param2,
    @dependencyParam AService? aService,
  }) =>
      DifferentKindSharedParam3._();

  factory DifferentKindSharedParam3.named3({
    @invalidParam AGeneric<double>? param1,
    required AClass param2,
    AService? aService,
  }) =>
      DifferentKindSharedParam3._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "param1" should be of the '
  'same kind across all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: [
    ValidationStep([contentValidation, lengthValidation])
  ],
  sharedProps: [SharedProp(' List<AClass?>', 'param1')],
)
class DifferentKindSharedParam4 extends ListEntity {
  DifferentKindSharedParam4._();

  factory DifferentKindSharedParam4.named({
    @NullFailure('length', LengthFailure()) required List<AClass?> param1,
  }) =>
      DifferentKindSharedParam4._();

  factory DifferentKindSharedParam4(
    @dependencyParam List<AClass?> param1,
    List<AClass?> param2,
  ) =>
      DifferentKindSharedParam4._();
}

@ShouldThrow(
  'UnresolvedParametersException: The shared prop "param1" should be of the '
  'same kind across all case-modddels.\n',
  element: null,
)
@Modddel(
  validationSteps: vStepsContent,
  sharedProps: [SharedProp('Map<AClass?, AClass?>', 'param1')],
)
class DifferentKindSharedParam5 extends MapEntity {
  DifferentKindSharedParam5._();

  factory DifferentKindSharedParam5.named1(Map<AClass?, AClass> param1) =>
      DifferentKindSharedParam5._();

  factory DifferentKindSharedParam5.named2(
    @dependencyParam Map<AClass, AClass?> param1,
    Map<AClass, AClass> param2,
  ) =>
      DifferentKindSharedParam5._();
}
