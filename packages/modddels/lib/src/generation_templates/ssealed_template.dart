import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/ssealed/base_class_ssealed_template.dart';
import 'package:modddels/src/generation_templates/invalid_template/ssealed/invalid_ssealed_template.dart';
import 'package:modddels/src/generation_templates/test_classes_templates/modddel_params_template/ssealed/modddel_params_ssealed_template.dart';
import 'package:modddels/src/generation_templates/valid_template/ssealed/valid_ssealed_template.dart';
import 'package:modddels/src/generation_templates/validation_steps_templates/ssealed/validation_steps_ssealed_template.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

typedef SSealedTemplateConstructor<SI extends SSealedInfo<MI>,
        MI extends ModddelInfo>
    = SSealedTemplate<SI, MI> Function({
  required SI sSealedInfo,
  required bool generateTestClasses,
});

/// The template for the super-sealed classes generated for the annotated
/// super-sealed class.
///
/// NB : All subclasses should have a default constructor and which tear-off
/// should have the same type as [SSealedTemplateConstructor].
///
abstract class SSealedTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends SSealedGenerationTemplate<SI, MI> {
  SSealedTemplate({
    required this.sSealedInfo,
    required this.generateTestClasses,
  });

  @override
  final SI sSealedInfo;

  /// See [Modddel.generateTestClasses].
  ///
  final bool generateTestClasses;

  BaseClassSSealedTemplate get baseClassSSealedTemplate;

  ValidSSealedTemplate get validSSealedTemplate =>
      ValidSSealedTemplate(sSealedInfo: sSealedInfo);

  InvalidSSealedTemplate get invalidSSealedTemplate =>
      InvalidSSealedTemplate(sSealedInfo: sSealedInfo);

  ValidationStepsSSealedTemplate get validationStepsSSealedTemplate =>
      ValidationStepsSSealedTemplate(sSealedInfo: sSealedInfo);

  ModddelParamsSSealedTemplate get modddelParamsSSealedTemplate =>
      ModddelParamsSSealedTemplate(sSealedInfo: sSealedInfo);

  @override
  String toString() {
    return '''
    $baseClassSSealedTemplate

    $validSSealedTemplate

    $invalidSSealedTemplate

    $validationStepsSSealedTemplate

    ${generateTestClasses ? modddelParamsSSealedTemplate : ''}
    ''';
  }
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

abstract class ValueObjectSSealedTemplate<SI extends ValueObjectSSealedInfo<MI>,
    MI extends ValueObjectModddelInfo> extends SSealedTemplate<SI, MI> {
  ValueObjectSSealedTemplate({
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassSSealedTemplate =>
      ValueObjectBaseClassSSealedTemplate(sSealedInfo: sSealedInfo);
}

class SingleValueObjectSSealedTemplate extends ValueObjectSSealedTemplate<
    SingleValueObjectSSealedInfo, SingleValueObjectModddelInfo> {
  SingleValueObjectSSealedTemplate({
    required super.sSealedInfo,
    required super.generateTestClasses,
  });
}

class MultiValueObjectSSealedTemplate extends ValueObjectSSealedTemplate<
    MultiValueObjectSSealedInfo, MultiValueObjectModddelInfo> {
  MultiValueObjectSSealedTemplate({
    required super.sSealedInfo,
    required super.generateTestClasses,
  });
}

/* -------------------------------- Entities -------------------------------- */

class SimpleEntitySSealedTemplate
    extends SSealedTemplate<SimpleEntitySSealedInfo, SimpleEntityModddelInfo> {
  SimpleEntitySSealedTemplate({
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassSSealedTemplate =>
      SimpleEntityBaseClassSSealedTemplate(sSealedInfo: sSealedInfo);
}

class IterableEntitySSealedTemplate extends SSealedTemplate<
    IterableEntitySSealedInfo, IterableEntityModddelInfo> {
  IterableEntitySSealedTemplate({
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassSSealedTemplate =>
      IterableEntityBaseClassSSealedTemplate(sSealedInfo: sSealedInfo);
}

class Iterable2EntitySSealedTemplate extends SSealedTemplate<
    Iterable2EntitySSealedInfo, Iterable2EntityModddelInfo> {
  Iterable2EntitySSealedTemplate({
    required super.sSealedInfo,
    required super.generateTestClasses,
  });

  @override
  get baseClassSSealedTemplate =>
      Iterable2EntityBaseClassSSealedTemplate(sSealedInfo: sSealedInfo);
}
