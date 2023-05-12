import 'package:dartz/dartz.dart' show ISet, IMap, Order;
import 'package:modddels_annotation_dartz/src/modddels/base_modddel.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// Returns a list of [ModddelInvalidMember]s that represents the invalid member
/// parameters held inside [list].
///
/// The description of each [ModddelInvalidMember] is the result of calling the
/// [descriptionFor] callback with the index of the invalid modddel inside the
/// list. If the [descriptionDetailsFor] callback is provided, then it is called
/// too, and the result is appended to the description, in parenthesis.
///
List<ModddelInvalidMember> validateListContent<T extends BaseModddel>(
  List<T?> list, {
  required String Function(int index) descriptionFor,
  required String? Function(T modddel, int index) descriptionDetailsFor,
}) {
  final invalidMembers = <ModddelInvalidMember>[];

  for (var i = 0; i < list.length; i++) {
    final modddel = list[i];
    // A null modddel is considered valid during the contentValidation
    if (modddel == null) {
      continue;
    }
    modddel.mapValidity(
      valid: (validModddel) {},
      invalid: (invalidModddel) {
        var description = descriptionFor(i);
        final descriptionDetails = descriptionDetailsFor(modddel, i);
        if (descriptionDetails != null) {
          description += ' ($descriptionDetails)';
        }
        invalidMembers.add(ModddelInvalidMember(
            member: invalidModddel, description: description));
      },
    );
  }
  return invalidMembers;
}

mixin DartzIterables {
  /// The [Order] that is used for creating the [ISet] or [IMap]. It is
  /// applied as soon as the modddel is created.
  ///
  /// See [ISet.fromIterable] / [IMap.from]
  ///
  Order<R> $getOrder<R>();
}
