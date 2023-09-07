import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/tools/type_visitors/invalid_type_exception.dart';
import 'package:modddels/src/core/tools/type_visitors/type_visitor.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen/source_gen.dart';

/// Represents a [Validation] that has been parsed from the [Modddel]
/// annotation.
///
class ParsedValidation {
  const ParsedValidation._({
    required this.validationName,
    required this.failureType,
  });

  factory ParsedValidation.fromValidationObject({
    required LibraryElement library,
    required DartObject validationObject,
    required ClassElement annotatedClass,
  }) {
    // 1. The `name` field
    final validationName = validationObject.getField('name')!.toStringValue()!;

    // 2. The `failureType` field
    final failureTypeField = validationObject.getField('failureType')!;

    // We first access the [FailureType.typeName] field.
    final typeName = failureTypeField.getField('typeName')?.toStringValue();

    if (typeName != null) {
      return ParsedValidation._(
          validationName: validationName, failureType: typeName);
    }

    // If the `typeName` wasn't provided, we access the type argument of
    // FailureType instead.
    final failureType =
        (failureTypeField.type! as InterfaceType).typeArguments.single;

    try {
      final failureTypeString = failureType.accept(StringTypeVisitor(
        library,
        expandTypeAliases: false,
        invalidTypeThrows: true,
      ));

      return ParsedValidation._(
          validationName: validationName, failureType: failureTypeString);
    } on InvalidTypeException {
      throw InvalidGenerationSourceError(
        'Failed to extract the failure type of the validation named "$validationName". '
        'Make sure it is a valid type that is available generation-time, or try '
        'providing it as a string instead : FailureType(\'_yourtype_\').',
        element: annotatedClass,
      );
    }
  }

  /// The parsed [Validation.failureType].
  ///
  final String failureType;

  /// The parsed [Validation.name].
  ///
  final String validationName;

  /// Whether this validation is the contentValidation.
  ///
  bool get isContentValidation =>
      failureType ==
      GlobalIdentifiers.failuresBaseIdentifiers.contentFailureClassName;
}
