import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';

/* -------------------------------------------------------------------------- */
/*              Modddel Annotation an only be applied on classes              */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  '@Modddel can only be applied on classes.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
Object? obj;

@ShouldThrow(
  '@Modddel can only be applied on classes.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
typedef MyType = Object?;

@ShouldThrow(
  '@Modddel can only be applied on classes.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
aFunction() {}

/* -------------------------------------------------------------------------- */
/*                   Modddel Annotation's maxTestInfoLength                   */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'The [maxTestInfoLength] should be > 0 or should equal Modddel.noMaxLength',
  element: null,
)
@Modddel(validationSteps: noVSteps, maxTestInfoLength: 0)
class BadMaxTestInfoLength1 {}

@ShouldThrow(
  'The [maxTestInfoLength] should be > 0 or should equal Modddel.noMaxLength',
  element: null,
)
@Modddel(validationSteps: noVSteps, maxTestInfoLength: -20)
class BadMaxTestInfoLength2 {}

/* -------------------------------------------------------------------------- */
/*                       Class extends a single modddel                       */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'Should extend a single Modddel superclass.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NotModddel1 {}

@ShouldThrow(
  'Should extend a single Modddel superclass.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NotModddel2 extends AClass {}

@ShouldThrow(
  'Should extend a single Modddel superclass.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class MultipleModddels1 with SingleValueObject, SimpleEntity {}

@ShouldThrow(
  'Should extend a single Modddel superclass.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class MultipleModddels2 extends ListEntity
    with MultiValueObject, AGeneric<AClass> {}

/* -------------------------------------------------------------------------- */
/*              Shared props are reserved for unions of modddels              */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'Shared props can only be provided for a union of modddels.',
  element: null,
)
@Modddel(
  validationSteps: noVSteps,
  sharedProps: [SharedProp('AClass', 'param')],
)
class SharedPropsInSolo1 extends SingleValueObject {
  SharedPropsInSolo1._();

  factory SharedPropsInSolo1(AClass param) => SharedPropsInSolo1._();
}

@ShouldThrow(
  'Shared props can only be provided for a union of modddels.',
  element: null,
)
@Modddel(
  validationSteps: noVSteps,
  sharedProps: [SharedProp('AService?', 'param2')],
)
class SharedPropsInSolo2 extends MultiValueObject {
  SharedPropsInSolo2._();

  factory SharedPropsInSolo2({
    required AClass param1,
    @dependencyParam AService? param2,
  }) =>
      SharedPropsInSolo2._();
}

@ShouldThrow(
  'Shared props can only be provided for a union of modddels.',
  element: null,
)
@Modddel(
  validationSteps: noVSteps,
  sharedProps: [SharedProp('Object?', 'param1')],
)
class SharedPropsInSolo3 extends SimpleEntity {
  SharedPropsInSolo3._();

  factory SharedPropsInSolo3({
    @withGetter AGeneric<AClass>? param1,
    required AClass param2,
  }) =>
      SharedPropsInSolo3._();
}

@ShouldThrow(
  'Shared props can only be provided for a union of modddels.',
  element: null,
)
@Modddel(
  validationSteps: noVSteps,
  sharedProps: [
    SharedProp(
      'Inexistant',
      'inexistant',
      ignoreValidTransformation: true,
      ignoreNonNullTransformation: true,
      ignoreNullTransformation: true,
    ),
  ],
)
class SharedPropsInSolo4 extends ListEntity {
  SharedPropsInSolo4._();

  factory SharedPropsInSolo4(List<AClass?> param) => SharedPropsInSolo4._();
}

@ShouldThrow(
  'Shared props can only be provided for a union of modddels.',
  element: null,
)
@Modddel(
  validationSteps: noVSteps,
  sharedProps: [
    SharedProp('AService', 'aService'),
    SharedProp('Map<AClass, AClass>', 'param'),
  ],
)
class SharedPropsInSolo5 extends MapEntity {
  SharedPropsInSolo5._();

  factory SharedPropsInSolo5(
    Map<AClass, AClass> param,
    @dependencyParam AService aService,
  ) =>
      SharedPropsInSolo5._();
}
