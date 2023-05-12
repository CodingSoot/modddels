import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/* -------------------------------------------------------------------------- */
/*                                Mock Modddels                               */
/* -------------------------------------------------------------------------- */

class SingleValueObject {}

class MultiValueObject {}

class SimpleEntity {}

@TypeTemplate('List<#1>')
class ListEntity extends IterableEntity {}

@TypeTemplate('List<#1,*>')
class MappedKeysEntity extends IterableEntity {}

@TypeTemplate('Map<#1,#2>')
class MapEntity extends Iterable2Entity {}

class IterableEntity {}

class Iterable2Entity {}

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

class AService {}

class AClass {}

class AGeneric<T> {}

class AGeneric2<T1, T2> {}

class AGeneric3<T1, T2, T3> {}
