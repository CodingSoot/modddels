import 'package:collection/collection.dart';
import 'package:modddels_annotation_internal/src/modddels/modddel_interfaces.dart';

/// A [Failure] represents a validation that failed for a specific reason,
/// making the modddel invalid. A valid modddel has no failures, while an
/// invalid Modddel has at least one failure.
///
/// There are two kinds of failures : [ValueFailure] for ValueObjects, and
/// [EntityFailure] for Entities.
///
abstract class Failure {
  const Failure();
}

/// A [ValueFailure] is a [Failure] specific to ValueObjects.
///
abstract class ValueFailure extends Failure {
  const ValueFailure();
}

/// An [EntityFailure] is a [Failure] specific to Entities.
///
abstract class EntityFailure extends Failure {
  const EntityFailure();
}

/// A [ContentFailure] is the failure of a contentValidation.
///
/// It holds a list of all the invalid modddels of the Entity, which you can
/// access using the [invalidMembers] getter.
///
class ContentFailure extends EntityFailure {
  const ContentFailure(this.invalidMembers);

  /// A list of all the invalid modddels of the Entity.
  ///
  final List<ModddelInvalidMember> invalidMembers;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ContentFailure &&
        listEquals(other.invalidMembers, invalidMembers);
  }

  @override
  int get hashCode => invalidMembers.hashCode;

  @override
  String toString() => 'ContentFailure(invalidMembers: $_toStringMap)';

  Map<String, List<Failure>> get _toStringMap {
    final descriptions = invalidMembers.map((e) => e.description).toList();

    final keys = _formatDescriptions(descriptions);
    final values = invalidMembers.map((e) => e.failures).toList();

    return Map.fromIterables(keys, values);
  }

  /// Formats the [descriptions] like this :
  ///
  /// - Adds double quotes around the description
  /// - If a description is duplicated one or multiple times, '(x2)', '(x3)'...
  ///   is appended to the duplicated description(s).
  ///
  /// Example :
  ///
  /// ```dart
  /// final list = ['apple', 'banana', 'apple', 'apple'];
  ///
  /// final formatted = _formatDescriptions(list);
  ///
  /// print(formatted);
  /// // ["apple", "banana", "apple" (x2), "apple" (x3)]
  /// ```
  ///
  /// NB : The double quotes are important as they ensure that once the
  /// descriptions are formatted, they are all unique. Without double quotes, we
  /// could have for example `['apple', 'apple', 'apple (x2)']`, which once
  /// formatted would give `['apple', 'apple (x2)', 'apple (x2)']`, which
  /// contains two duplicate descriptions.
  ///
  List<String> _formatDescriptions(List<String> descriptions) {
    final processed = <String>[];
    final result = <String>[];

    for (final description in descriptions) {
      if (processed.contains(description)) {
        final duplicateNb = processed.where((e) => e == description).length + 1;
        final newDescription = '"$description" (x$duplicateNb)';
        result.add(newDescription);
        processed.add(description);
        continue;
      }
      result.add('"$description"');
      processed.add(description);
    }
    return result;
  }
}

/// A [ModddelInvalidMember] is a wrapper class that holds an invalid [member]
/// of an Entity, and its [description] in that Entity.
///
/// The [description] is used in the [ContentFailure.toString] method. For a
/// SimpleEntity, the description is simply the name of the parameter (Ex :
/// "age", "name"...). For an IterableEntity/Iterable2Entity, it's usually the
/// index of the invalid modddel (Ex : "item 0", "entry 0"...).
///
class ModddelInvalidMember {
  ModddelInvalidMember({required this.member, required this.description});

  final InvalidModddel member;

  final String description;

  /// Returns the list of failures of the invalid [member].
  List<Failure> get failures => member.failures;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModddelInvalidMember &&
        other.member == member &&
        other.description == description;
  }

  @override
  int get hashCode => member.hashCode ^ description.hashCode;

  @override
  String toString() =>
      'InvalidMember(description: $description, member: $member)';
}
