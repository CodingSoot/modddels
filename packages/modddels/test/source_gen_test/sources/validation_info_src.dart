import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';

/* -------------------------------------------------------------------------- */
/*           The number of validationSteps / validations is correct           */
/* -------------------------------------------------------------------------- */

/* --------------- There should be at least one validationStep -------------- */

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps list can not be empty.\n',
  element: null,
)
@Modddel(validationSteps: [])
class NoVStepValueObject1 extends SingleValueObject {
  NoVStepValueObject1._();

  factory NoVStepValueObject1(AClass param) => NoVStepValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps list can not be empty.\n',
  element: null,
)
@Modddel(validationSteps: [])
class NoVStepValueObject2 extends MultiValueObject {
  NoVStepValueObject2._();

  factory NoVStepValueObject2.named(AClass param) => NoVStepValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps list can not be empty.\n',
  element: null,
)
@Modddel(validationSteps: [])
class NoVStepEntity1 extends SimpleEntity {
  NoVStepEntity1._();

  factory NoVStepEntity1(AClass param) => NoVStepEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps list can not be empty.\n',
  element: null,
)
@Modddel(validationSteps: [])
class NoVStepEntity2 extends ListEntity {
  NoVStepEntity2._();

  factory NoVStepEntity2.named(List<AClass> param) => NoVStepEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps list can not be empty.\n',
  element: null,
)
@Modddel(validationSteps: [])
class NoVStepEntity3 extends MapEntity {
  NoVStepEntity3._();

  factory NoVStepEntity3(Map<AClass, AClass> param) => NoVStepEntity3._();
}

/* --------- There should be at least one validation in every vStep --------- */

@ShouldThrow(
  'UnresolvedValidationException: The validations list can not be empty.\n'
  'Failed ValidationStep : "Unnamed"\n',
  element: null,
)
@Modddel(validationSteps: [ValidationStep([])])
class NoValidationValueObject1 extends SingleValueObject {
  NoValidationValueObject1._();

  factory NoValidationValueObject1(AClass param) =>
      NoValidationValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validations list can not be empty.\n'
  'Failed ValidationStep : "VStep2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation], name: 'VStep1'),
  ValidationStep([], name: 'VStep2'),
])
class NoValidationValueObject2 extends MultiValueObject {
  NoValidationValueObject2._();

  factory NoValidationValueObject2.named(AClass param) =>
      NoValidationValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validations list can not be empty.\n'
  'Failed ValidationStep : "VStep1"\n',
  element: null,
)
@Modddel(validationSteps: [ValidationStep([], name: 'VStep1')])
class NoValidationEntity1 extends SimpleEntity {
  NoValidationEntity1._();

  factory NoValidationEntity1(AClass param) => NoValidationEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validations list can not be empty.\n'
  'Failed ValidationStep : "Unnamed"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([]),
  ValidationStep([lengthValidation, contentValidation]),
])
class NoValidationEntity2 extends ListEntity {
  NoValidationEntity2._();

  factory NoValidationEntity2(List<AClass> param) => NoValidationEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validations list can not be empty.\n'
  'Failed ValidationStep : "Unnamed"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation], name: 'VStep1'),
  ValidationStep([]),
])
class NoValidationEntity3 extends MapEntity {
  NoValidationEntity3._();

  factory NoValidationEntity3.named(Map<AClass, AClass> param) =>
      NoValidationEntity3._();
}

/* -------------------------------------------------------------------------- */
/*                    The provided validations are correct                    */
/* -------------------------------------------------------------------------- */

/* ------ The failure type must be provided (must not equal 'Failure') ------ */

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('validation1', FailureType())]),
])
class NoProvidedFailureValueObject1 extends SingleValueObject {
  NoProvidedFailureValueObject1._();

  factory NoProvidedFailureValueObject1.named(AClass param) =>
      NoProvidedFailureValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
  ValidationStep([Validation('validation2', FailureType<Failure>())]),
])
class NoProvidedFailureValueObject2 extends MultiValueObject {
  NoProvidedFailureValueObject2._();

  factory NoProvidedFailureValueObject2(AClass param) =>
      NoProvidedFailureValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('validation2', FailureType())]),
])
class NoProvidedFailureTypeEntity1 extends SimpleEntity {
  NoProvidedFailureTypeEntity1._();

  factory NoProvidedFailureTypeEntity1.named(AClass param) =>
      NoProvidedFailureTypeEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('validation2', FailureType('Failure')),
  ]),
])
class NoProvidedFailureTypeEntity2 extends ListEntity {
  NoProvidedFailureTypeEntity2._();

  factory NoProvidedFailureTypeEntity2(List<AClass> param) =>
      NoProvidedFailureTypeEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep(
      [Validation('validation2', FailureType<LengthFailure>('Failure'))]),
])
class NoProvidedFailureTypeEntity3 extends MapEntity {
  NoProvidedFailureTypeEntity3._();

  factory NoProvidedFailureTypeEntity3(Map<AClass, AClass> param) =>
      NoProvidedFailureTypeEntity3._();
}

/* --------------- The failure type can't be dynamic or empty --------------- */

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('validation1', FailureType('dynamic'))]),
])
class DynamicFailureTypeValueObject extends SingleValueObject {
  DynamicFailureTypeValueObject._();

  factory DynamicFailureTypeValueObject(AClass param) =>
      DynamicFailureTypeValueObject._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('validation1', FailureType(''))]),
])
class EmptyFailureTypeValueObject extends MultiValueObject {
  EmptyFailureTypeValueObject._();

  factory EmptyFailureTypeValueObject.named(AClass param) =>
      EmptyFailureTypeValueObject._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep(
      [Validation('validation1', FailureType<LengthFailure>('dynamic'))]),
])
class DynamicFailureTypeEntity extends SimpleEntity {
  DynamicFailureTypeEntity._();

  factory DynamicFailureTypeEntity(AClass param) =>
      DynamicFailureTypeEntity._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('validation2', FailureType('')),
  ]),
])
class EmptyFailureTypeEntity1 extends ListEntity {
  EmptyFailureTypeEntity1._();

  factory EmptyFailureTypeEntity1.named(List<AClass> param) =>
      EmptyFailureTypeEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must be provided and must '
  'not be dynamic. Consider providing it as a type argument : FailureType<_yourtype_>, '
  'or providing the type as a string : FailureType(\'_yourtype_\').\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('validation1', FailureType<LengthFailure>('')),
    contentValidation,
  ]),
])
class EmptyFailureTypeEntity2 extends MapEntity {
  EmptyFailureTypeEntity2._();

  factory EmptyFailureTypeEntity2(Map<AClass, AClass> param) =>
      EmptyFailureTypeEntity2._();
}

/* ----- The failure type can't equal 'ValueFailure' or 'EntityFailure' ----- */

@ShouldThrow(
  'UnresolvedValidationException: The failure type can\'t be equal to the base '
  'class "ValueFailure". Create your own failure class that extends the '
  'appropriate base class.\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
  ValidationStep([Validation('validation2', FailureType<ValueFailure>())]),
])
class ValueFailureAsFailureTypeValueObject extends SingleValueObject {
  ValueFailureAsFailureTypeValueObject._();

  factory ValueFailureAsFailureTypeValueObject(AClass param) =>
      ValueFailureAsFailureTypeValueObject._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type can\'t be equal to the base '
  'class "EntityFailure". Create your own failure class that extends the '
  'appropriate base class.\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('validation1', FailureType('EntityFailure'))]),
])
class EntityFailureAsFailureTypeValueObject extends MultiValueObject {
  EntityFailureAsFailureTypeValueObject._();

  factory EntityFailureAsFailureTypeValueObject.named(AClass param) =>
      EntityFailureAsFailureTypeValueObject._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type can\'t be equal to the base '
  'class "ValueFailure". Create your own failure class that extends the '
  'appropriate base class.\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep(
      [Validation('validation2', FailureType<LengthFailure>('ValueFailure'))]),
])
class ValueFailureAsFailureTypeEntity extends SimpleEntity {
  ValueFailureAsFailureTypeEntity._();

  factory ValueFailureAsFailureTypeEntity(AClass param) =>
      ValueFailureAsFailureTypeEntity._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type can\'t be equal to the base '
  'class "EntityFailure". Create your own failure class that extends the '
  'appropriate base class.\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('validation1', FailureType<EntityFailure>()),
    contentValidation,
  ]),
])
class EntityFailureAsFailureTypeEntity1 extends ListEntity {
  EntityFailureAsFailureTypeEntity1._();

  factory EntityFailureAsFailureTypeEntity1(List<AClass> param) =>
      EntityFailureAsFailureTypeEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type can\'t be equal to the base '
  'class "EntityFailure". Create your own failure class that extends the '
  'appropriate base class.\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('validation2', FailureType('EntityFailure')),
  ]),
])
class EntityFailureAsFailureTypeEntity2 extends MapEntity {
  EntityFailureAsFailureTypeEntity2._();

  factory EntityFailureAsFailureTypeEntity2.named(Map<AClass, AClass> param) =>
      EntityFailureAsFailureTypeEntity2._();
}

/* ------------------- The failure type can't be nullable ------------------- */

@ShouldThrow(
  'UnresolvedValidationException: The failure type must not be nullable.\n'
  'Failed Validation : "validation1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('validation1', FailureType('LengthFailure?'))]),
])
class NullableFailureTypeValueObject1 extends SingleValueObject {
  NullableFailureTypeValueObject1._();

  factory NullableFailureTypeValueObject1.named(AClass param) =>
      NullableFailureTypeValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must not be nullable.\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    lengthValidation,
    Validation('validation2', FailureType('Null')),
  ]),
])
class NullableFailureTypeValueObject2 extends MultiValueObject {
  NullableFailureTypeValueObject2._();

  factory NullableFailureTypeValueObject2(AClass param) =>
      NullableFailureTypeValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must not be nullable.\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('validation2', FailureType('LengthFailure?')),
  ]),
])
class NullableFailureTypeEntity1 extends SimpleEntity {
  NullableFailureTypeEntity1._();

  factory NullableFailureTypeEntity1.named(AClass param) =>
      NullableFailureTypeEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must not be nullable.\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('validation2', FailureType<LengthFailure>('Null')),
  ]),
])
class NullableFailureTypeEntity2 extends ListEntity {
  NullableFailureTypeEntity2._();

  factory NullableFailureTypeEntity2(List<AClass> param) =>
      NullableFailureTypeEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The failure type must not be nullable.\n'
  'Failed Validation : "validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('validation2', FailureType('ContentFailure?')),
  ]),
])
class NullableFailureTypeEntity3 extends MapEntity {
  NullableFailureTypeEntity3._();

  factory NullableFailureTypeEntity3(Map<AClass, AClass> param) =>
      NullableFailureTypeEntity3._();
}

/* ----------- The contentValidation is only provided for Entities ---------- */

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should not contain any '
  'contentValidation.\n'
  'Failed ValidationStep : "Unnamed"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
])
class ContentValidationInValueObject1 extends SingleValueObject {
  ContentValidationInValueObject1._();

  factory ContentValidationInValueObject1(AClass param) =>
      ContentValidationInValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should not contain any '
  'contentValidation.\n'
  'Failed ValidationStep : "VStep1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation, contentValidation], name: 'VStep1'),
])
class ContentValidationInValueObject2 extends MultiValueObject {
  ContentValidationInValueObject2._();

  factory ContentValidationInValueObject2.named(AClass param) =>
      ContentValidationInValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should not contain any '
  'contentValidation.\n'
  'Failed ValidationStep : "VStep1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('validation1', FailureType<ContentFailure>())],
      name: 'VStep1'),
  ValidationStep([lengthValidation], name: 'VStep2'),
])
class ContentValidationInValueObject3 extends MultiValueObject {
  ContentValidationInValueObject3._();

  factory ContentValidationInValueObject3(AClass param) =>
      ContentValidationInValueObject3._();
}

/* -------- There must be exactly one contentValidation for Entities -------- */

// NB : We're also testing that the contentvalidation can either be provided
// using the `contentValidation` constant or with a custom name.

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should contain exactly '
  'one contentValidation.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
])
class NoContentValidationInEntity1 extends SimpleEntity {
  NoContentValidationInEntity1._();

  factory NoContentValidationInEntity1(AClass param) =>
      NoContentValidationInEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should contain exactly '
  'one contentValidation.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
  ValidationStep([Validation('validation1', FailureType<AnotherFailure>())]),
])
class NoContentValidationInEntity2 extends ListEntity {
  NoContentValidationInEntity2._();

  factory NoContentValidationInEntity2(List<AClass> param) =>
      NoContentValidationInEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should contain exactly '
  'one contentValidation.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('content', FailureType<LengthFailure>())]),
  ValidationStep([lengthValidation]),
])
class NoContentValidationInEntity3 extends MapEntity {
  NoContentValidationInEntity3._();

  factory NoContentValidationInEntity3.named(Map<AClass, AClass> param) =>
      NoContentValidationInEntity3._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should contain exactly '
  'one contentValidation.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation, contentValidation]),
])
class MultipleContentValidationsInEntity1 extends SimpleEntity {
  MultipleContentValidationsInEntity1._();

  factory MultipleContentValidationsInEntity1(AClass param) =>
      MultipleContentValidationsInEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should contain exactly '
  'one contentValidation.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    lengthValidation,
    Validation('validation1', FailureType<ContentFailure>()),
  ]),
  ValidationStep([contentValidation]),
])
class MultipleContentValidationsInEntity2 extends ListEntity {
  MultipleContentValidationsInEntity2._();

  factory MultipleContentValidationsInEntity2.named(List<AClass> param) =>
      MultipleContentValidationsInEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationSteps should contain exactly '
  'one contentValidation.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([lengthValidation]),
  ValidationStep([contentValidation]),
])
class MultipleContentValidationsInEntity3 extends MapEntity {
  MultipleContentValidationsInEntity3._();

  factory MultipleContentValidationsInEntity3(Map<AClass, AClass> param) =>
      MultipleContentValidationsInEntity3._();
}

/* -------------------------------------------------------------------------- */
/*          The name of the validationSteps / validations are correct         */
/* -------------------------------------------------------------------------- */

/* -------------------- The vStep name must be correct ---------------------- */

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must start with an '
  'uppercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed ValidationStep : "vStep1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation], name: 'vStep1'),
])
class IncorrectVStepNameValueObject1 extends SingleValueObject {
  IncorrectVStepNameValueObject1._();

  factory IncorrectVStepNameValueObject1(AClass param) =>
      IncorrectVStepNameValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must start with an '
  'uppercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed ValidationStep : "VStep.2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation], name: 'VStep1'),
  ValidationStep([sizeValidation], name: 'VStep.2'),
])
class IncorrectVStepNameValueObject2 extends MultiValueObject {
  IncorrectVStepNameValueObject2._();

  factory IncorrectVStepNameValueObject2.named(AClass param) =>
      IncorrectVStepNameValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must start with an '
  'uppercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed ValidationStep : "_VStep1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation], name: '_VStep1'),
  ValidationStep([contentValidation], name: 'VStep2'),
])
class IncorrectVStepNameEntity1 extends SimpleEntity {
  IncorrectVStepNameEntity1._();

  factory IncorrectVStepNameEntity1.named(AClass param) =>
      IncorrectVStepNameEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must start with an '
  'uppercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed ValidationStep : "vStep2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation], name: r'VStep1$_True'),
  ValidationStep([lengthValidation, sizeValidation], name: 'vStep2'),
])
class IncorrectVStepNameEntity2 extends ListEntity {
  IncorrectVStepNameEntity2._();

  factory IncorrectVStepNameEntity2(List<AClass> param) =>
      IncorrectVStepNameEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must start with an '
  'uppercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed ValidationStep : "VStep2 is great"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation], name: 'VStep1'),
  ValidationStep([contentValidation], name: 'VStep2 is great'),
])
class IncorrectVStepNameEntity3 extends MapEntity {
  IncorrectVStepNameEntity3._();

  factory IncorrectVStepNameEntity3(Map<AClass, AClass> param) =>
      IncorrectVStepNameEntity3._();
}

/* --------------------- The vSteps names must be unique -------------------- */

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must be unique.\n'
  'Failed ValidationStep : "VStep1"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation], name: 'VStep1'),
  ValidationStep([lengthValidation], name: 'VStep1'),
])
class DuplicateVStepNameValueObject1 extends SingleValueObject {
  DuplicateVStepNameValueObject1._();

  factory DuplicateVStepNameValueObject1(AClass param) =>
      DuplicateVStepNameValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must be unique.\n'
  'Failed ValidationStep : "Value2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation], name: 'Value2'),
  ValidationStep([sizeValidation]),
])
class DuplicateVStepNameValueObject2 extends MultiValueObject {
  DuplicateVStepNameValueObject2._();

  factory DuplicateVStepNameValueObject2.named(AClass param) =>
      DuplicateVStepNameValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must be unique.\n'
  'Failed ValidationStep : "VStep2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation], name: 'VStep1'),
  ValidationStep([contentValidation], name: 'VStep2'),
  ValidationStep([lengthValidation], name: 'VStep2'),
])
class DuplicateVStepNameEntity1 extends SimpleEntity {
  DuplicateVStepNameEntity1._();

  factory DuplicateVStepNameEntity1(AClass param) =>
      DuplicateVStepNameEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must be unique.\n'
  'Failed ValidationStep : "Mid"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([sizeValidation], name: 'Mid'),
])
class DuplicateVStepNameEntity2 extends ListEntity {
  DuplicateVStepNameEntity2._();

  factory DuplicateVStepNameEntity2.named(List<AClass> param) =>
      DuplicateVStepNameEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must be unique.\n'
  'Failed ValidationStep : "Early"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation]),
  ValidationStep([contentValidation]),
  ValidationStep([lengthValidation], name: 'Early'),
])
class DuplicateVStepNameEntity3 extends MapEntity {
  DuplicateVStepNameEntity3._();

  factory DuplicateVStepNameEntity3(Map<AClass, AClass> param) =>
      DuplicateVStepNameEntity3._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validationStep name must be unique.\n'
  'Failed ValidationStep : "Late"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation], name: 'Late'),
  ValidationStep([contentValidation]),
  ValidationStep([sizeValidation]),
])
class DuplicateVStepNameEntity4 extends MapEntity {
  DuplicateVStepNameEntity4._();

  factory DuplicateVStepNameEntity4(Map<AClass, AClass> param) =>
      DuplicateVStepNameEntity4._();
}

/* ------------------ The validation name must be correct ------------------- */

@ShouldThrow(
  'UnresolvedValidationException: The validation name must start with a '
  'lowercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed Validation : "Validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('validation1', FailureType<AnotherFailure>())]),
  ValidationStep([Validation('Validation2', FailureType<LengthFailure>())]),
])
class IncorrectValidationNameValueObject1 extends SingleValueObject {
  IncorrectValidationNameValueObject1._();

  factory IncorrectValidationNameValueObject1.named(AClass param) =>
      IncorrectValidationNameValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must start with a '
  'lowercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed Validation : "val.2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('size', FailureType<SizeFailure>()),
    Validation('val.2', FailureType<AFailure>()),
  ]),
])
class IncorrectValidationNameValueObject2 extends MultiValueObject {
  IncorrectValidationNameValueObject2._();

  factory IncorrectValidationNameValueObject2(AClass param) =>
      IncorrectValidationNameValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must start with a '
  'lowercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed Validation : "_validation2"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('val1', FailureType<AFailure>()),
    contentValidation,
  ]),
  ValidationStep([Validation('_validation2', FailureType<AnotherFailure>())]),
])
class IncorrectValidationNameEntity1 extends SimpleEntity {
  IncorrectValidationNameEntity1._();

  factory IncorrectValidationNameEntity1(AClass param) =>
      IncorrectValidationNameEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must start with a '
  'lowercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed Validation : "Length"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation(r'first$Validation_1', FailureType<AFailure>()),
    Validation('Length', FailureType<AnotherFailure>())
  ]),
])
class IncorrectValidationNameEntity2 extends ListEntity {
  IncorrectValidationNameEntity2._();

  factory IncorrectValidationNameEntity2.named(List<AClass> param) =>
      IncorrectValidationNameEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must start with a '
  'lowercase letter and can only contain valid dart identifier characters '
  '(alphanumeric, underscore and dollar sign).\n'
  'Failed Validation : "Size Validation"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('size', FailureType<AFailure>()),
    Validation('anotherSize', FailureType<AFailure>())
  ]),
  ValidationStep([
    contentValidation,
    Validation('Size Validation', FailureType<AnotherFailure>()),
  ]),
])
class IncorrectValidationNameEntity3 extends MapEntity {
  IncorrectValidationNameEntity3._();

  factory IncorrectValidationNameEntity3(Map<AClass, AClass> param) =>
      IncorrectValidationNameEntity3._();
}

/* ------------------- The validation name must be unique ------------------- */

@ShouldThrow(
  'UnresolvedValidationException: The validation name must be unique.\n'
  'Failed Validation : "size"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('size', FailureType<SizeFailure>()),
    Validation('size', FailureType<LengthFailure>())
  ]),
])
class DuplicateValidationNameValueObject1 extends SingleValueObject {
  DuplicateValidationNameValueObject1._();

  factory DuplicateValidationNameValueObject1(AClass param) =>
      DuplicateValidationNameValueObject1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must be unique.\n'
  'Failed Validation : "size"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('size', FailureType<SizeFailure>()),
  ]),
  ValidationStep([
    Validation('length', FailureType<LengthFailure>()),
    Validation('size', FailureType<AnotherFailure>()),
  ])
])
class DuplicateValidationNameValueObject2 extends MultiValueObject {
  DuplicateValidationNameValueObject2._();

  factory DuplicateValidationNameValueObject2.named(AClass param) =>
      DuplicateValidationNameValueObject2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must be unique.\n'
  'Failed Validation : "size"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([Validation('size', FailureType<SizeFailure>())]),
  ValidationStep([contentValidation]),
  ValidationStep([Validation('size', FailureType<AFailure>())]),
])
class DuplicateValidationNameEntity1 extends SimpleEntity {
  DuplicateValidationNameEntity1._();

  factory DuplicateValidationNameEntity1(AClass param) =>
      DuplicateValidationNameEntity1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must be unique.\n'
  'Failed Validation : "content"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    Validation('content', FailureType<AFailure>()),
  ]),
])
class DuplicateValidationNameEntity2 extends ListEntity {
  DuplicateValidationNameEntity2._();

  factory DuplicateValidationNameEntity2.named(List<AClass> param) =>
      DuplicateValidationNameEntity2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The validation name must be unique.\n'
  'Failed Validation : "length"\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([Validation('length', FailureType<LengthFailure>())]),
  ValidationStep([Validation('validation3', FailureType<AFailure>())]),
  ValidationStep([Validation('length', FailureType<AnotherFailure>())]),
])
class DuplicateValidationNameEntity3 extends MapEntity {
  DuplicateValidationNameEntity3._();

  factory DuplicateValidationNameEntity3(Map<AClass, AClass> param) =>
      DuplicateValidationNameEntity3._();
}

/* -------------------------------------------------------------------------- */
/*     The references related to @NullFailure annotations must be correct     */
/* -------------------------------------------------------------------------- */

/* ---- '@NullFailure' annotations should reference existing validations. --- */

@ShouldThrow(
  'The NullFailure annotation should refer to an existing validation.',
  element: 'param',
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
  ValidationStep([sizeValidation]),
])
class InexistantValidationReferenceValueObject1 extends SingleValueObject {
  InexistantValidationReferenceValueObject1._();

  factory InexistantValidationReferenceValueObject1.named(
    @NullFailure('validation3', AFailure()) AClass? param,
  ) =>
      InexistantValidationReferenceValueObject1._();
}

@ShouldThrow(
  'The NullFailure annotation should refer to an existing validation.',
  element: 'param3',
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation, sizeValidation]),
])
class InexistantValidationReferenceValueObject2 extends MultiValueObject {
  InexistantValidationReferenceValueObject2._();

  factory InexistantValidationReferenceValueObject2(
    @NullFailure('size', SizeFailure()) AClass? param1,
    @NullFailure('length', LengthFailure()) AClass? param2,
    @NullFailure('validation3', AnotherFailure()) AClass? param3,
  ) =>
      InexistantValidationReferenceValueObject2._();
}

@ShouldThrow(
  'The NullFailure annotation should refer to an existing validation.',
  element: 'param3',
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([sizeValidation]),
])
class InexistantValidationReferenceEntity1 extends SimpleEntity {
  InexistantValidationReferenceEntity1._();

  factory InexistantValidationReferenceEntity1.named(
    AClass param1, {
    @NullFailure('size', SizeFailure()) required AClass? param2,
    @NullFailure('length', LengthFailure()) AClass? param3,
  }) =>
      InexistantValidationReferenceEntity1._();
}

@ShouldThrow(
  'The NullFailure annotation should refer to an existing validation.',
  element: 'param',
)
@Modddel(validationSteps: [
  ValidationStep([
    sizeValidation,
    Validation('validation2', FailureType<AFailure>()),
  ]),
  ValidationStep([contentValidation]),
])
class InexistantValidationReferenceEntity2 extends ListEntity {
  InexistantValidationReferenceEntity2._();

  factory InexistantValidationReferenceEntity2(
    @NullFailure('validation1', AFailure()) List<AClass?> param,
  ) =>
      InexistantValidationReferenceEntity2._();
}

@ShouldThrow(
  'The NullFailure annotation should refer to an existing validation.',
  element: 'param',
)
@Modddel(validationSteps: [
  ValidationStep([
    contentValidation,
    lengthValidation,
  ]),
])
class InexistantValidationReferenceEntity3 extends MapEntity {
  InexistantValidationReferenceEntity3._();

  factory InexistantValidationReferenceEntity3(
    @NullFailure('', SizeFailure(), maskNb: 1) Map<AClass?, AClass> param,
  ) =>
      InexistantValidationReferenceEntity3._();
}

@ShouldThrow(
  'The NullFailure annotation should refer to an existing validation.',
  element: 'param',
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
  ValidationStep([contentValidation]),
  ValidationStep([sizeValidation])
])
class InexistantValidationReferenceEntity4 extends MapEntity {
  InexistantValidationReferenceEntity4._();

  factory InexistantValidationReferenceEntity4.named(
    @NullFailure('size', SizeFailure(), maskNb: 1)
    @NullFailure('validation3', SizeFailure(), maskNb: 2)
    Map<AClass?, AClass?> param,
  ) =>
      InexistantValidationReferenceEntity4._();
}

/* -- '@NullFailure' annotations shouldn't reference existing validations. -- */

@ShouldThrow(
  'The NullFailure annotation can\'t refer to the content validation.',
  element: 'param3',
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation]),
  ValidationStep([contentValidation]),
])
class ContentValidationReferenceEntity1 extends SimpleEntity {
  ContentValidationReferenceEntity1._();

  factory ContentValidationReferenceEntity1(
    AClass param1, {
    @NullFailure('size', SizeFailure()) required AClass? param2,
    @NullFailure('content', AFailure()) AClass? param3,
  }) =>
      ContentValidationReferenceEntity1._();
}

@ShouldThrow(
  'The NullFailure annotation can\'t refer to the content validation.',
  element: 'param',
)
@Modddel(validationSteps: [
  ValidationStep([
    Validation('contentVal', FailureType<ContentFailure>()),
  ]),
])
class ContentValidationReferenceEntity2 extends ListEntity {
  ContentValidationReferenceEntity2._();

  factory ContentValidationReferenceEntity2.named(
    @NullFailure('contentVal', AnotherFailure()) List<AClass?> param,
  ) =>
      ContentValidationReferenceEntity2._();
}

@ShouldThrow(
  'The NullFailure annotation can\'t refer to the content validation.',
  element: 'param',
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation, sizeValidation]),
])
class ContentValidationReferenceEntity3 extends MapEntity {
  ContentValidationReferenceEntity3._();

  factory ContentValidationReferenceEntity3(
    @NullFailure('size', SizeFailure(), maskNb: 1)
    @NullFailure('content', AFailure(), maskNb: 2)
    Map<AClass?, AClass?> param,
  ) =>
      ContentValidationReferenceEntity3._();
}

/* -------------------------------------------------------------------------- */
/*    Names of vSteps/validations don't conflict with reserved identifiers    */
/* -------------------------------------------------------------------------- */

/* -------- The vSteps names don't conflict with reserved identifiers ------- */

// NB : Just testing a few reserved identifiers names.

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "isInvalidDash" conflicts '
  'with the validationStep name "Dash". Try to either change the parameter name '
  'or the validationStep name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation], name: 'Dash'),
])
class ConflictingVStep1 extends SingleValueObject {
  ConflictingVStep1._();

  factory ConflictingVStep1(
    AClass param1,
    // `generalIdentifiers.testerIdentifiers.getIsInvalidGetterName`
    @dependencyParam AClass isInvalidDash,
  ) =>
      ConflictingVStep1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "invalidValue2" conflicts '
  'with the validationStep name "Value2". Try to either change the parameter name '
  'or the validationStep name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
  ValidationStep([sizeValidation]),
])
class ConflictingVStep2 extends MultiValueObject {
  ConflictingVStep2._();

  factory ConflictingVStep2.named({
    required AClass param1,
    // `generalIdentifiers.getInvalidStepCallbackParamName`
    @withGetter AClass? invalidValue2,
  }) =>
      ConflictingVStep2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "lateFailures" conflicts '
  'with the validationStep name "Late". Try to either change the parameter '
  'name or the validationStep name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([sizeValidation]),
])
class ConflictingVStep3 extends SimpleEntity {
  ConflictingVStep3._();

  factory ConflictingVStep3.named(
    AClass param1, {
    // `generalIdentifiers.getFailuresCallbackParamName`
    required List<AClass> lateFailures,
  }) =>
      ConflictingVStep3._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "invalidNamedMid" conflicts '
  'with the validationStep name "Mid". Try to either change the parameter '
  'name or the validationStep name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
])
class ConflictingVStep4 extends ListEntity {
  ConflictingVStep4._();

  factory ConflictingVStep4.named({
    // `modddelClassIdentifiers.getInvalidStepVariableName`
    required List<AClass> invalidNamedMid,
  }) =>
      ConflictingVStep4._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "invalidConflictingVStep5Early1" '
  'conflicts with the validationStep name "Early1". Try to either change the '
  'parameter name or the validationStep name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation]),
  ValidationStep([lengthValidation], name: 'Dash'),
  ValidationStep([contentValidation]),
])
class ConflictingVStep5 extends MapEntity {
  ConflictingVStep5._();

  factory ConflictingVStep5.named(
    // `sSealedClassIdentifiers.getInvalidStepVariableName`
    Map<AClass, AClass> invalidConflictingVStep5Early1,
  ) =>
      ConflictingVStep5._();
}

/* ----- The validations names don't conflict with reserved identifiers ----- */

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "validateSize" conflicts '
  'with the validation name "size". Try to either change the parameter name '
  'or the validation name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation]),
])
class ConflictingValidation1 extends SingleValueObject {
  ConflictingValidation1._();

  factory ConflictingValidation1(
    AClass param1,
    // `generalIdentifiers.topLevelMixinIdentifiers.getValidateMethodName`
    @dependencyParam AClass validateSize,
  ) =>
      ConflictingValidation1._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "toLengthSubholder" conflicts '
  'with the validation name "length". Try to either change the parameter name '
  'or the validation name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([sizeValidation, lengthValidation]),
])
class ConflictingValidation2 extends MultiValueObject {
  ConflictingValidation2._();

  factory ConflictingValidation2.named(
    // `generalIdentifiers.holderIdentifiers.getToSubHolderMethodName`
    @withGetter AClass toLengthSubholder,
  ) =>
      ConflictingValidation2._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "contentFailure" conflicts '
  'with the validation name "content". Try to either change the parameter name '
  'or the validation name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
])
class ConflictingValidation3 extends SimpleEntity {
  ConflictingValidation3._();

  factory ConflictingValidation3(
    AClass param1, {
    // `generalIdentifiers.getFailureVariableName`
    AClass? contentFailure,
  }) =>
      ConflictingValidation3._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "hasSizeFailure" conflicts '
  'with the validation name "size". Try to either change the parameter name '
  'or the validation name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([contentValidation]),
  ValidationStep([sizeValidation]),
])
class ConflictingValidation4 extends ListEntity {
  ConflictingValidation4._();

  factory ConflictingValidation4.named({
    // `generalIdentifiers.getHasFailureGetterName`
    required List<AClass> hasSizeFailure,
  }) =>
      ConflictingValidation4._();
}

@ShouldThrow(
  'UnresolvedValidationException: The parameter name "validateMyContent" conflicts '
  'with the validation name "myContent". Try to either change the parameter name '
  'or the validation name.\n',
  element: null,
)
@Modddel(validationSteps: [
  ValidationStep([lengthValidation]),
  ValidationStep([Validation('myContent', FailureType<ContentFailure>())]),
])
class ConflictingValidation5 extends MapEntity {
  ConflictingValidation5._();

  factory ConflictingValidation5(
    // `modddelClassIdentifiers.getValidateContentMethodName`
    Map<AClass, AClass> validateMyContent,
  ) =>
      ConflictingValidation5._();
}
