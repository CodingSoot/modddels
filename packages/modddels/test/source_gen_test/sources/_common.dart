import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/* -------------------------------------------------------------------------- */
/*                                Mock Modddels                               */
/* -------------------------------------------------------------------------- */

mixin class SingleValueObject {}

mixin class MultiValueObject {}

mixin class SimpleEntity {}

@TypeTemplate('List<#1>')
mixin class ListEntity implements IterableEntity {}

@TypeTemplate('List<#1,*>')
mixin class MappedKeysEntity implements IterableEntity {}

@TypeTemplate('Map<#1,#2>')
mixin class MapEntity implements Iterable2Entity {}

mixin class IterableEntity {}

mixin class Iterable2Entity {}

/* -------------------------------------------------------------------------- */
/*                                  Examples                                  */
/* -------------------------------------------------------------------------- */

/* ---------------------- ValidationSteps & Validations --------------------- */

const vStepsContent = [
  ValidationStep([contentValidation])
];

const vStepsLength = [
  ValidationStep([lengthValidation])
];

const noVSteps = <ValidationStep>[];

const lengthValidation = Validation('length', FailureType<LengthFailure>());

const sizeValidation = Validation('size', FailureType<SizeFailure>());

/* -------------------------------- Failures -------------------------------- */

// NB : These are just mocks. They should normally extend ValueFailure or
// EntityFailure.
class LengthFailure extends Failure {
  const LengthFailure();
}

class SizeFailure extends Failure {
  const SizeFailure();
}

class AFailure extends Failure {
  const AFailure();
}

class AnotherFailure extends Failure {
  const AnotherFailure();
}

/* --------------------------------- Classes -------------------------------- */

mixin class AService {}

mixin class AClass {}

mixin class AGeneric<T> {}

mixin class AGeneric2<T1, T2> {}

mixin class AGeneric3<T1, T2, T3> {}
