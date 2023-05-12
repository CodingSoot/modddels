import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/modddel/base_class_modddel_template.dart';
import 'package:modddels/src/generation_templates/dependencies_template/modddel/dependencies_modddel_template.dart';
import 'package:modddels/src/generation_templates/invalid_template/modddel/invalid_modddel_template.dart';
import 'package:modddels/src/generation_templates/test_classes_templates/modddel_params_template/modddel/modddel_params_modddel_template.dart';
import 'package:modddels/src/generation_templates/valid_template/modddel/valid_modddel_template.dart';
import 'package:modddels/src/generation_templates/validation_steps_templates/modddel/validation_steps_modddel_template.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

typedef ModddelTemplateConstructor<SI extends SSealedInfo<MI>,
        MI extends ModddelInfo>
    = ModddelTemplate<SI, MI> Function({
  required MI modddelInfo,
  required SI? sSealedInfo,
  required bool generateTestClasses,
});

/// The template for the classes generated for a modddel. This modddel can
/// either be the annotated solo class or a case-modddel.
///
/// NB : All subclasses should have a default constructor and which tear-off
/// should have the same type as [ModddelTemplateConstructor].
///
abstract class ModddelTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends ModddelGenerationTemplate<SI, MI> {
  ModddelTemplate({
    required this.modddelInfo,
    required this.sSealedInfo,
    required this.generateTestClasses,
  });

  @override
  final MI modddelInfo;

  @override
  final SI? sSealedInfo;

  /// See [Modddel.generateTestClasses].
  ///
  final bool generateTestClasses;

  @override
  String toString() {
    return '''
    $baseClassModddelTemplate
    
    $validModddelTemplate

    $invalidModddelTemplate

    $validationStepsModddelTemplate

    ${hasDependencies ? dependenciesModddelTemplate : ''}

    ${generateTestClasses ? modddelParamsModddelTemplate : ''}
    ''';
  }

  BaseClassModddelTemplate get baseClassModddelTemplate;

  ValidationStepsModddelTemplate get validationStepsModddelTemplate;

  ValidModddelTemplate get validModddelTemplate => ValidModddelTemplate(
        modddelInfo: modddelInfo,
        sSealedInfo: sSealedInfo,
      );

  InvalidModddelTemplate get invalidModddelTemplate => InvalidModddelTemplate(
        modddelInfo: modddelInfo,
        sSealedInfo: sSealedInfo,
      );

  DependenciesModddelTemplate get dependenciesModddelTemplate =>
      DependenciesModddelTemplate(
        sSealedInfo: sSealedInfo,
        modddelInfo: modddelInfo,
      );

  ModddelParamsModddelTemplate get modddelParamsModddelTemplate =>
      ModddelParamsModddelTemplate(
        sSealedInfo: sSealedInfo,
        modddelInfo: modddelInfo,
      );
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

abstract class ValueObjectModddelTemplate<SI extends ValueObjectSSealedInfo<MI>,
    MI extends ValueObjectModddelInfo> extends ModddelTemplate<SI, MI> {
  ValueObjectModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassModddelTemplate => ValueObjectBaseClassModddelTemplate(
      modddelInfo: modddelInfo, sSealedInfo: sSealedInfo);

  @override
  get validationStepsModddelTemplate =>
      NonIterablesValidationStepsModddelTemplate(
          sSealedInfo: sSealedInfo, modddelInfo: modddelInfo);
}

class SingleValueObjectModddelTemplate extends ValueObjectModddelTemplate<
    SingleValueObjectSSealedInfo, SingleValueObjectModddelInfo> {
  SingleValueObjectModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.generateTestClasses,
  });
}

class MultiValueObjectModddelTemplate extends ValueObjectModddelTemplate<
    MultiValueObjectSSealedInfo, MultiValueObjectModddelInfo> {
  MultiValueObjectModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.generateTestClasses,
  });
}

/* -------------------------------- Entities -------------------------------- */

class SimpleEntityModddelTemplate
    extends ModddelTemplate<SimpleEntitySSealedInfo, SimpleEntityModddelInfo> {
  SimpleEntityModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassModddelTemplate => SimpleEntityBaseClassModddelTemplate(
      modddelInfo: modddelInfo, sSealedInfo: sSealedInfo);

  @override
  get validationStepsModddelTemplate =>
      NonIterablesValidationStepsModddelTemplate(
          sSealedInfo: sSealedInfo, modddelInfo: modddelInfo);
}

class IterableEntityModddelTemplate extends ModddelTemplate<
    IterableEntitySSealedInfo, IterableEntityModddelInfo> {
  IterableEntityModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassModddelTemplate => IterableEntityBaseClassModddelTemplate(
      modddelInfo: modddelInfo, sSealedInfo: sSealedInfo);

  @override
  get validationStepsModddelTemplate =>
      IterableEntityValidationStepsModddelTemplate(
          sSealedInfo: sSealedInfo, modddelInfo: modddelInfo);
}

class Iterable2EntityModddelTemplate extends ModddelTemplate<
    Iterable2EntitySSealedInfo, Iterable2EntityModddelInfo> {
  Iterable2EntityModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassModddelTemplate => Iterable2EntityBaseClassModddelTemplate(
      modddelInfo: modddelInfo, sSealedInfo: sSealedInfo);

  @override
  get validationStepsModddelTemplate =>
      Iterable2EntityValidationStepsModddelTemplate(
          sSealedInfo: sSealedInfo, modddelInfo: modddelInfo);
}
