import 'package:analyzer/dart/constant/value.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// Represents a [SharedProp] that has been parsed from the [Modddel]
/// annotation.
///
class ParsedSharedProp {
  const ParsedSharedProp._({
    required this.type,
    required this.name,
    required this.ignoreValidTransformation,
    required this.ignoreNonNullTransformation,
    required this.ignoreNullTransformation,
  });

  factory ParsedSharedProp.fromSharedPropObject({
    required DartObject sharedPropObject,
  }) {
    // 1. The `name` field
    final name = sharedPropObject.getField('name')!.toStringValue()!;

    // 2. The `type` field
    final type = sharedPropObject.getField('type')!.toStringValue()!;

    // 3. The `ignoreValidTransformation` field
    final ignoreValidTransformation =
        sharedPropObject.getField('ignoreValidTransformation')!.toBoolValue()!;

    // 4. The `ignoreNonNullTransformation` field
    final ignoreNonNullTransformation = sharedPropObject
        .getField('ignoreNonNullTransformation')!
        .toBoolValue()!;

    // 5. The `ignoreNullTransformation` field
    final ignoreNullTransformation =
        sharedPropObject.getField('ignoreNullTransformation')!.toBoolValue()!;

    return ParsedSharedProp._(
      type: type,
      name: name,
      ignoreValidTransformation: ignoreValidTransformation,
      ignoreNonNullTransformation: ignoreNonNullTransformation,
      ignoreNullTransformation: ignoreNullTransformation,
    );
  }

  /// The parsed [SharedProp.name].
  ///
  final String name;

  /// The parsed [SharedProp.type].
  ///
  final String type;

  /// The parsed [SharedProp.ignoreValidTransformation].
  ///
  final bool ignoreValidTransformation;

  /// The parsed [SharedProp.ignoreNonNullTransformation].
  ///
  final bool ignoreNonNullTransformation;

  /// The parsed [SharedProp.ignoreNullTransformation].
  ///
  final bool ignoreNullTransformation;
}
