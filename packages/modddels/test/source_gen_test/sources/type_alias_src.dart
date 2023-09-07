import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';
import 'type_alias_imports.dart' as prefix;

/* -------------------------------------------------------------------------- */
/*            The expanded type alias can't contain an invalid type           */
/* -------------------------------------------------------------------------- */
//ignore: undefined_class
typedef InvalidType = Incorrect;

typedef GenericType1<T> = Map<T, String>;

typedef GenericType2<T1, T2> = Map<GenericType1<T1?>, T2>;

//ignore: non_type_as_type_argument
typedef InvalidTypeArg1 = List<Incorrect>;

typedef InvalidTypeArg2 = List<prefix.InvalidType2>;

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are valid '
  'types that are available generation-time, or don\'t use a type alias.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidTypeAlias1 extends SingleValueObject {
  InvalidTypeAlias1._();

  factory InvalidTypeAlias1.f({
    required Map<String, List<prefix.InvalidType2>> param,
  }) =>
      InvalidTypeAlias1._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are valid '
  'types that are available generation-time, or don\'t use a type alias.',
  element: 'param2',
)
@Modddel(validationSteps: noVSteps)
class InvalidTypeAlias2 extends MultiValueObject {
  InvalidTypeAlias2._();

  factory InvalidTypeAlias2(
    GenericType1<AClass> param1,
    InvalidTypeArg1 param2,
  ) =>
      InvalidTypeAlias2._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are valid '
  'types that are available generation-time, or don\'t use a type alias.',
  element: 'param2',
)
@Modddel(validationSteps: noVSteps)
class InvalidTypeAlias3 extends SimpleEntity {
  InvalidTypeAlias3._();

  factory InvalidTypeAlias3(
    GenericType2<AClass, String> param1,
    InvalidTypeArg2 param2,
  ) =>
      InvalidTypeAlias3._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are valid '
  'types that are available generation-time, or don\'t use a type alias.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidTypeAlias4 extends ListEntity {
  InvalidTypeAlias4._();

  factory InvalidTypeAlias4(
    GenericType2<InvalidTypeArg2, AClass> param,
  ) =>
      InvalidTypeAlias4._();
}

@ShouldThrow(
  'Could not expand the type alias. Make sure all type arguments are valid '
  'types that are available generation-time, or don\'t use a type alias.',
  element: 'param',
)
@Modddel(validationSteps: noVSteps)
class InvalidTypeAlias5 extends MapEntity {
  InvalidTypeAlias5._();

  factory InvalidTypeAlias5(
    Map<AClass, InvalidType> param,
  ) =>
      InvalidTypeAlias5._();
}
