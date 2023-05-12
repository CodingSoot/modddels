import 'package:modddels_annotation_dartz/src/modddels/base_modddel.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// A [ValueObject] is a modddel that holds a "value", which can be made up by
/// one or multiple member parameters.
///
/// The "value" is validated by one or multiple validations, grouped in one or
/// multiple validation steps. Each validation either passes successfully, or
/// fails with a [ValueFailure] (subclass of [Failure]).
///
/// There are two kinds of [ValueObject]s : [SingleValueObject] and
/// [MultiValueObject].
///
abstract class ValueObject<I extends InvalidValueObject,
    V extends ValidValueObject> extends BaseModddel<I, V> {
  const ValueObject();
}

/* -------------------------------------------------------------------------- */
/*                             ValueObjects Kinds                             */
/* -------------------------------------------------------------------------- */

/// A [SingleValueObject] is a [ValueObject] that holds only one member
/// parameter.
///
/// Generally, you'll want your [ValueObject]s to contain one field only, so
/// you'll mostly be using [SingleValueObject]s. For example, if you want to
/// create a `Person` model that has a `firstName`, `lastName` and `age`, you'll
/// usually want to create a separate [SingleValueObject] for each field, and
/// then create a `Person` entity that groups the three ValueObjects.
///
abstract class SingleValueObject<I extends InvalidValueObject,
    V extends ValidValueObject> extends ValueObject<I, V> {
  const SingleValueObject();
}

/// A [MultiValueObject] is a [ValueObject] that can hold multiple member
/// parameters.
///
/// [MultiValueObject]s are useful when the "value" is not represented by a
/// single field, but rather a combination of multiple fields. Each field is
/// valid separately, but when put together, they form a "value" that needs to
/// be validated.
///
abstract class MultiValueObject<I extends InvalidValueObject,
    V extends ValidValueObject> extends ValueObject<I, V> {
  const MultiValueObject();
}
