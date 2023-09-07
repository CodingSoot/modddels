import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// Represents a [ValidationStep] that has been parsed from the [Modddel]
/// annotation.
///
class ParsedValidationStep {
  const ParsedValidationStep._({
    required this.name,
    required this.parsedValidations,
  });

  factory ParsedValidationStep.fromValidationStepObject({
    required LibraryElement library,
    required DartObject validationStepObject,
    required ClassElement annotatedClass,
  }) {
    // 1. The `name` field
    final name = validationStepObject.getField('name')!.toStringValue();

    // 2. The `validations` field
    final validations = validationStepObject
        .getField('validations')!
        .toListValue()!
        .map((validationObject) => ParsedValidation.fromValidationObject(
              library: library,
              validationObject: validationObject,
              annotatedClass: annotatedClass,
            ))
        .toList();

    return ParsedValidationStep._(name: name, parsedValidations: validations);
  }

  /// The parsed [ValidationStep.name]. Null if the name was not provided.
  ///
  final String? name;

  /// The parsed [ValidationStep.validations].
  ///
  final List<ParsedValidation> parsedValidations;

  /// Whether this parsed validationStep contains a contentValidation.
  ///
  bool get containsContentValidation =>
      parsedValidations.any((validation) => validation.isContentValidation);

  /// If this [ParsedValidationStep] doesn't have a name, returns a copy
  /// with the provided [name].
  ///
  /// Otherwise, returns an exact copy of this [ParsedValidationStep].
  ///
  ParsedValidationStep withNameIfNonExistant({
    required String name,
  }) {
    return this.name == null ? copyWith(name: name) : copyWith();
  }

  /// **NB :** Copying with null values is not implemented.
  ///
  ParsedValidationStep copyWith({
    String? name,
    List<ParsedValidation>? parsedValidations,
  }) {
    return ParsedValidationStep._(
      name: name ?? this.name,
      parsedValidations: parsedValidations ?? this.parsedValidations,
    );
  }
}
