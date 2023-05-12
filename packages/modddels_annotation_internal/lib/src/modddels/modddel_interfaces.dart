import 'package:modddels_annotation_internal/src/modddels/failures.dart';

/* -------------------------------------------------------------------------- */
/*                          ValidModddel interfaces                           */
/* -------------------------------------------------------------------------- */

/// This is the base interface for the "valid" union-case of a modddel.
///
/// It has two sub-interfaces : [ValidValueObject] for ValueObjects, and
/// [ValidEntity] for Entities.
///
abstract class ValidModddel {
  const ValidModddel();
}

/// A [ValidValueObject] is an interface implemented by the "valid" union-case
/// of ValueObjects.
///
abstract class ValidValueObject implements ValidModddel {
  const ValidValueObject();
}

/// A [ValidEntity] is an interface implemented by the "valid" union-case
/// of Entities.
///
abstract class ValidEntity implements ValidModddel {
  const ValidEntity();
}

/* -------------------------------------------------------------------------- */
/*                         InvalidModddel interfaces                          */
/* -------------------------------------------------------------------------- */

/// This is the base interface for the "invalid" union-case of a modddel.
///
/// It has two sub-interfaces : [InvalidValueObject] for ValueObjects, and
/// [InvalidEntity] for Entities.
///
abstract class InvalidModddel {
  const InvalidModddel();

  /// The list of failures of this [InvalidModddel].
  ///
  List<Failure> get failures;
}

/// An [InvalidValueObject] is an interface implemented by the "invalid"
/// union-case of ValueObjects.
///
abstract class InvalidValueObject implements InvalidModddel {
  const InvalidValueObject();

  @override
  List<ValueFailure> get failures;
}

/// An [InvalidEntity] is an interface implemented by the "invalid" union-case
/// of Entities.
///
abstract class InvalidEntity implements InvalidModddel {
  const InvalidEntity();

  @override
  List<EntityFailure> get failures;
}
