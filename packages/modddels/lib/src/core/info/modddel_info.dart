import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/modddel/modddel_parameters_info.dart';
import 'package:modddels/src/core/info/validation_info/modddel/modddel_validation_info.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

typedef ModddelInfoConstructor<
        MI extends ModddelInfo,
        MPI extends ModddelParametersInfo,
        MVI extends ModddelValidationInfo,
        PTIM extends ParameterTypeInfoMaker>
    = MI Function(
        {required ModddelClassInfo modddelClassInfo,
        required MPI modddelParametersInfo,
        required MVI modddelValidationInfo,
        required PTIM parameterTypeInfoMaker});

/// Holds all information related to a modddel.
///
/// NB : All subclasses should have a default constructor and which
/// tear-off should have the same type as [ModddelInfoConstructor].
///
abstract class ModddelInfo<MPI extends ModddelParametersInfo,
    MVI extends ModddelValidationInfo, PTIM extends ParameterTypeInfoMaker> {
  ModddelInfo({
    required this.modddelClassInfo,
    required this.modddelParametersInfo,
    required this.modddelValidationInfo,
    required this.parameterTypeInfoMaker,
  });

  /// The [ModddelClassInfo] of the modddel.
  final ModddelClassInfo modddelClassInfo;

  /// The [ModddelParametersInfo] of the modddel.
  final MPI modddelParametersInfo;

  /// The [ModddelValidationInfo] of the modddel.
  final MVI modddelValidationInfo;

  /// The [ParameterTypeInfoMaker] of the modddel.
  final PTIM parameterTypeInfoMaker;

  ModddelKind get modddelKind;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

abstract class ValueObjectModddelInfo<MPI extends ModddelParametersInfo>
    extends ModddelInfo<MPI, ValueObjectValidationInfo,
        NormalParameterTypeInfoMaker> {
  ValueObjectModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });

  @override
  ValueObjectValidationInfo get modddelValidationInfo;

  @override
  ValueObjectMK get modddelKind;
}

class SingleValueObjectModddelInfo
    extends ValueObjectModddelInfo<SingleValueObjectParametersInfo> {
  SingleValueObjectModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });

  @override
  final modddelKind =
      ValueObjectMK(valueObjectKind: ValueObjectKind.singleValueObject());
}

class MultiValueObjectModddelInfo
    extends ValueObjectModddelInfo<MultiValueObjectParametersInfo> {
  MultiValueObjectModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });

  @override
  final modddelKind =
      ValueObjectMK(valueObjectKind: ValueObjectKind.multiValueObject());
}

/* -------------------------------- Entities -------------------------------- */

abstract class EntityModddelInfo<MPI extends ModddelParametersInfo,
        PTIM extends ParameterTypeInfoMaker>
    extends ModddelInfo<MPI, EntityValidationInfo, PTIM> {
  EntityModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });

  @override
  EntityMK get modddelKind;
}

class SimpleEntityModddelInfo extends EntityModddelInfo<
    SimpleEntityParametersInfo, NormalParameterTypeInfoMaker> {
  SimpleEntityModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });

  @override
  final modddelKind = EntityMK(entityKind: EntityKind.simpleEntity());
}

abstract class IterablesEntityModddelInfo<PTIM extends ParameterTypeInfoMaker>
    extends EntityModddelInfo<IterablesEntityParametersInfo, PTIM> {
  IterablesEntityModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });
}

class IterableEntityModddelInfo
    extends IterablesEntityModddelInfo<IterableParameterTypeInfoMaker> {
  IterableEntityModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });

  @override
  final modddelKind = EntityMK(entityKind: EntityKind.iterableEntity());
}

class Iterable2EntityModddelInfo
    extends IterablesEntityModddelInfo<Iterable2ParameterTypeInfoMaker> {
  Iterable2EntityModddelInfo({
    required super.modddelClassInfo,
    required super.modddelParametersInfo,
    required super.modddelValidationInfo,
    required super.parameterTypeInfoMaker,
  });

  @override
  final modddelKind = EntityMK(entityKind: EntityKind.iterable2Entity());
}
