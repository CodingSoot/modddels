import 'package:modddels/src/core/info/class_info/ssealed/ssealed_class_info.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/ssealed_parameters_info.dart';
import 'package:modddels/src/core/info/validation_info/ssealed/ssealed_validation_info.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

typedef SSealedInfoConstructor<SI extends SSealedInfo<MI>,
        MI extends ModddelInfo>
    = SI Function({
  required SSealedClassInfo sSealedClassInfo,
  required SSealedParametersInfo sSealedParametersInfo,
  required SSealedValidationInfo sSealedValidationInfo,
  required List<MI> caseModddelsInfos,
});

/// Holds all information related to the annotated super-sealed class.
///
/// NB : All subclasses should have a default constructor and which
/// tear-off should have the same type as [SSealedInfoConstructor].
///
abstract class SSealedInfo<MI extends ModddelInfo> {
  SSealedInfo({
    required this.sSealedClassInfo,
    required this.sSealedParametersInfo,
    required this.sSealedValidationInfo,
    required this.caseModddelsInfos,
  }) {
    assert(caseModddelsInfos
        .every((modddelInfo) => modddelInfo.modddelKind == modddelKind));
  }

  /// The [SSealedClassInfo] of the annotated super-sealed class.
  final SSealedClassInfo sSealedClassInfo;

  /// The [SSealedParametersInfo] of the annotated super-sealed class.
  final SSealedParametersInfo sSealedParametersInfo;

  /// The [SSealedParametersInfo] of the annotated super-sealed class.
  final SSealedValidationInfo sSealedValidationInfo;

  /// The list that contains the [ModddelInfo] of each case-modddel.
  final List<MI> caseModddelsInfos;

  ModddelKind get modddelKind;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

abstract class ValueObjectSSealedInfo<MI extends ValueObjectModddelInfo>
    extends SSealedInfo<MI> {
  ValueObjectSSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });

  @override
  ValueObjectMK get modddelKind;
}

class SingleValueObjectSSealedInfo
    extends ValueObjectSSealedInfo<SingleValueObjectModddelInfo> {
  SingleValueObjectSSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });

  @override
  final modddelKind =
      ValueObjectMK(valueObjectKind: ValueObjectKind.singleValueObject());
}

class MultiValueObjectSSealedInfo
    extends ValueObjectSSealedInfo<MultiValueObjectModddelInfo> {
  MultiValueObjectSSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });

  @override
  final modddelKind =
      ValueObjectMK(valueObjectKind: ValueObjectKind.multiValueObject());
}

/* -------------------------------- Entities -------------------------------- */

abstract class EntitySSealedInfo<MI extends EntityModddelInfo>
    extends SSealedInfo<MI> {
  EntitySSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });

  @override
  EntityMK get modddelKind;
}

class SimpleEntitySSealedInfo
    extends EntitySSealedInfo<SimpleEntityModddelInfo> {
  SimpleEntitySSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });
  @override
  final modddelKind = EntityMK(entityKind: EntityKind.simpleEntity());
}

abstract class IterablesEntitySSealedInfo<MI extends IterablesEntityModddelInfo>
    extends EntitySSealedInfo<MI> {
  IterablesEntitySSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });
}

class IterableEntitySSealedInfo
    extends IterablesEntitySSealedInfo<IterableEntityModddelInfo> {
  IterableEntitySSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });
  @override
  final modddelKind = EntityMK(entityKind: EntityKind.iterableEntity());
}

class Iterable2EntitySSealedInfo
    extends IterablesEntitySSealedInfo<Iterable2EntityModddelInfo> {
  Iterable2EntitySSealedInfo({
    required super.sSealedClassInfo,
    required super.sSealedParametersInfo,
    required super.sSealedValidationInfo,
    required super.caseModddelsInfos,
  });
  @override
  final modddelKind = EntityMK(entityKind: EntityKind.iterable2Entity());
}
