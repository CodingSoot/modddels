import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';
import 'type_alias_imports.dart' as prefix;

/* -------------------------------------------------------------------------- */
/*               The expanded type alias can't contain 'dynamic'              */
/* -------------------------------------------------------------------------- */

typedef DynamicType = dynamic;

typedef GenericType1<T> = Map<T, String>;

typedef GenericType2<T1, T2> = Map<GenericType1<T1?>, T2>;

typedef DynamicTypeArg1 = List<dynamic>;

typedef DynamicTypeArg2 = List<prefix.DynamicType2>;

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are not '
  'dynamic and are available generation-time, or don\'t use a type alias.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeAlias1 extends SingleValueObject {
  DynamicTypeAlias1._();

  factory DynamicTypeAlias1.f({
    required Map<String, List<prefix.DynamicType2>> param,
  }) =>
      DynamicTypeAlias1._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are not '
  'dynamic and are available generation-time, or don\'t use a type alias.',
  element: 'param2',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeAlias2 extends MultiValueObject {
  DynamicTypeAlias2._();

  factory DynamicTypeAlias2(
    GenericType1<AClass> param1,
    DynamicTypeArg1 param2,
  ) =>
      DynamicTypeAlias2._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are not '
  'dynamic and are available generation-time, or don\'t use a type alias.',
  element: 'param2',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeAlias3 extends SimpleEntity {
  DynamicTypeAlias3._();

  factory DynamicTypeAlias3(
    GenericType2<AClass, String> param1,
    DynamicTypeArg2 param2,
  ) =>
      DynamicTypeAlias3._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are not '
  'dynamic and are available generation-time, or don\'t use a type alias.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeAlias4 extends ListEntity {
  DynamicTypeAlias4._();

  factory DynamicTypeAlias4(
    GenericType2<DynamicTypeArg2, AClass> param,
  ) =>
      DynamicTypeAlias4._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are not '
  'dynamic and are available generation-time, or don\'t use a type alias.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class DynamicTypeAlias5 extends MapEntity {
  DynamicTypeAlias5._();

  factory DynamicTypeAlias5(
    Map<AClass, DynamicType> param,
  ) =>
      DynamicTypeAlias5._();
}
