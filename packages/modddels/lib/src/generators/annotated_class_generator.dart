import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/class_info/ssealed/ssealed_class_info.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/modddel/modddel_parameters_info.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/ssealed_parameters_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/modddel/modddel_validation_info.dart';
import 'package:modddels/src/core/info/validation_info/ssealed/ssealed_validation_info.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_modddel_annotation.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_validation_step.dart';
import 'package:modddels/src/core/templates/constructor_details.dart';
import 'package:modddels/src/generation_templates/modddel_template.dart';
import 'package:modddels/src/generation_templates/ssealed_template.dart';
import 'package:modddels/src/generators/annotated_class_template/annotated_solo_template.dart';
import 'package:modddels/src/generators/annotated_class_template/annotated_ssealed_template.dart';
import 'package:source_gen/source_gen.dart';

abstract class AnnotatedClassGenerator<
    SI extends SSealedInfo<MI>,
    MI extends ModddelInfo,
    MPI extends ModddelParametersInfo,
    MVI extends ModddelValidationInfo,
    PTIM extends ParameterTypeInfoMaker> {
  SSealedInfoConstructor<SI, MI> get sSealedInfoConstructor;

  ModddelInfoConstructor<MI, MPI, MVI, PTIM> get modddelInfoConstructor;

  ModddelParametersInfoConstructor<MPI> get modddelParametersInfoConstructor;

  ModddelValidationInfoConstructor<MVI> get modddelValidationInfoConstructor;

  ParameterTypeInfoMakerConstructor<PTIM> get parameterTypeInfoMakerConstructor;

  SSealedTemplateConstructor<SI, MI> get sSealedTemplateConstructor;

  ModddelTemplateConstructor<SI, MI> get modddelTemplateConstructor;

  String generate({
    required ClassElement annotatedClass,
    required List<ConstructorDetails> constructors,
    required ParsedModddelAnnotation parsedModddelAnnotation,
  }) {
    final parameterTypeInfoMaker =
        parameterTypeInfoMakerConstructor(annotatedClass: annotatedClass);

    final annotatedClassName = annotatedClass.name;

    // ** The annotated class is solo **
    //
    // (NB: Like freezed, if there is only one factory constructor that is
    // named, it is considered a union-case)
    if (constructors.length == 1 && constructors.single.isDefault) {
      if (parsedModddelAnnotation.parsedSharedProps.isNotEmpty) {
        throw InvalidGenerationSourceError(
          'Shared props can only be provided for a union of modddels.',
          element: annotatedClass,
        );
      }

      final constructor = constructors.single;

      final modddelInfo = createModddelInfo(
        isCaseModddel: false,
        annotatedClass: annotatedClass,
        constructor: constructor,
        parsedVSteps: parsedModddelAnnotation.parsedValidationSteps,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
      );

      final modddelTemplate = modddelTemplateConstructor(
        modddelInfo: modddelInfo,
        sSealedInfo: null,
        generateTestClasses: parsedModddelAnnotation.generateTestClasses,
      );

      return AnnotatedSoloTemplate(
        modddelInfo: modddelInfo,
        modddelTemplate: modddelTemplate,
        generateTestClasses: parsedModddelAnnotation.generateTestClasses,
        maxTestInfoLength: parsedModddelAnnotation.maxTestInfoLength,
      ).toString();
    }

    // ** The annotated class is ssealed **

    final caseModddelsInfos = constructors.map((constructor) {
      return createModddelInfo(
        isCaseModddel: true,
        annotatedClass: annotatedClass,
        constructor: constructor,
        parsedVSteps: parsedModddelAnnotation.parsedValidationSteps,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
      );
    }).toList();

    final sSealedClassInfo = SSealedClassInfo(
      annotatedClassName: annotatedClassName,
      caseModddelsClassInfos: caseModddelsInfos
          .map((modddelInfo) => modddelInfo.modddelClassInfo)
          .toList(),
    );

    final sSealedParametersInfo = SSealedParametersInfo.fromParsedSharedProps(
      parsedSharedProps: parsedModddelAnnotation.parsedSharedProps,
      caseModddelsParametersInfos:
          caseModddelsInfos.map((info) => info.modddelParametersInfo).toList(),
      annotatedClass: annotatedClass,
    );

    final sSealedValidationInfo = SSealedValidationInfo.from(
      sharedMemberParameters: sSealedParametersInfo.sharedMemberParameters,
      caseModddelsInfos: caseModddelsInfos,
      parsedVSteps: parsedModddelAnnotation.parsedValidationSteps,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    final sSealedInfo = sSealedInfoConstructor(
      sSealedClassInfo: sSealedClassInfo,
      sSealedParametersInfo: sSealedParametersInfo,
      sSealedValidationInfo: sSealedValidationInfo,
      caseModddelsInfos: caseModddelsInfos,
    );

    final sSealedTemplate = sSealedTemplateConstructor(
      sSealedInfo: sSealedInfo,
      generateTestClasses: parsedModddelAnnotation.generateTestClasses,
    );

    final caseModddelsTemplates = caseModddelsInfos.map((modddelInfo) {
      return modddelTemplateConstructor(
        modddelInfo: modddelInfo,
        sSealedInfo: sSealedInfo,
        generateTestClasses: parsedModddelAnnotation.generateTestClasses,
      );
    }).toList();

    return AnnotatedSSealedTemplate(
            sSealedInfo: sSealedInfo,
            sSealedTemplate: sSealedTemplate,
            caseModddelsTemplates: caseModddelsTemplates,
            generateTestClasses: parsedModddelAnnotation.generateTestClasses,
            maxTestInfoLength: parsedModddelAnnotation.maxTestInfoLength)
        .toString();
  }

  MI createModddelInfo({
    required bool isCaseModddel,
    required ClassElement annotatedClass,
    required ConstructorDetails constructor,
    required List<ParsedValidationStep> parsedVSteps,
    required PTIM parameterTypeInfoMaker,
  }) {
    final modddelClassInfo = ModddelClassInfo(
      annotatedClassName: annotatedClass.name,
      isCaseModddel: isCaseModddel,
      constructor: constructor,
    );

    final generalIdentifiers = modddelClassInfo.generalIdentifiers;

    final modddelClassIdentifiers = modddelClassInfo.classIdentifiers;

    final sSealedClassIdentifiers = isCaseModddel
        ? SSealedClassIdentifiers(generalIdentifiers: generalIdentifiers)
        : null;

    final modddelParametersInfo = modddelParametersInfoConstructor(
      constructorDetails: constructor,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );

    final modddelValidationInfo = modddelValidationInfoConstructor(
      parsedVSteps: parsedVSteps,
      annotatedClass: annotatedClass,
      modddelParametersInfo: modddelParametersInfo,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
      generalIdentifiers: generalIdentifiers,
      modddelClassIdentifiers: modddelClassIdentifiers,
      sSealedClassIdentifiers: sSealedClassIdentifiers,
    );

    return modddelInfoConstructor(
      modddelClassInfo: modddelClassInfo,
      modddelParametersInfo: modddelParametersInfo,
      modddelValidationInfo: modddelValidationInfo,
      parameterTypeInfoMaker: parameterTypeInfoMaker,
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

class SingleValueObjectGenerator extends AnnotatedClassGenerator<
    SingleValueObjectSSealedInfo,
    SingleValueObjectModddelInfo,
    SingleValueObjectParametersInfo,
    ValueObjectValidationInfo,
    NormalParameterTypeInfoMaker> {
  @override
  get sSealedInfoConstructor => SingleValueObjectSSealedInfo.new;

  @override
  get modddelInfoConstructor => SingleValueObjectModddelInfo.new;

  @override
  get modddelParametersInfoConstructor =>
      SingleValueObjectParametersInfo.fromConstructorDetails;

  @override
  get modddelValidationInfoConstructor =>
      ValueObjectValidationInfo.fromParsedValidationSteps;

  @override
  get parameterTypeInfoMakerConstructor => NormalParameterTypeInfoMaker.new;

  @override
  get sSealedTemplateConstructor => SingleValueObjectSSealedTemplate.new;

  @override
  get modddelTemplateConstructor => SingleValueObjectModddelTemplate.new;
}

class MultiValueObjectGenerator extends AnnotatedClassGenerator<
    MultiValueObjectSSealedInfo,
    MultiValueObjectModddelInfo,
    MultiValueObjectParametersInfo,
    ValueObjectValidationInfo,
    NormalParameterTypeInfoMaker> {
  @override
  get sSealedInfoConstructor => MultiValueObjectSSealedInfo.new;

  @override
  get modddelInfoConstructor => MultiValueObjectModddelInfo.new;

  @override
  get modddelParametersInfoConstructor =>
      MultiValueObjectParametersInfo.fromConstructorDetails;

  @override
  get modddelValidationInfoConstructor =>
      ValueObjectValidationInfo.fromParsedValidationSteps;

  @override
  get parameterTypeInfoMakerConstructor => NormalParameterTypeInfoMaker.new;

  @override
  get sSealedTemplateConstructor => MultiValueObjectSSealedTemplate.new;

  @override
  get modddelTemplateConstructor => MultiValueObjectModddelTemplate.new;
}

/* -------------------------------- Entities -------------------------------- */

class SimpleEntityGenerator extends AnnotatedClassGenerator<
    SimpleEntitySSealedInfo,
    SimpleEntityModddelInfo,
    SimpleEntityParametersInfo,
    EntityValidationInfo,
    NormalParameterTypeInfoMaker> {
  @override
  get sSealedInfoConstructor => SimpleEntitySSealedInfo.new;

  @override
  get modddelInfoConstructor => SimpleEntityModddelInfo.new;

  @override
  get modddelParametersInfoConstructor =>
      SimpleEntityParametersInfo.fromConstructorDetails;

  @override
  get modddelValidationInfoConstructor =>
      EntityValidationInfo.fromParsedValidationSteps;

  @override
  get parameterTypeInfoMakerConstructor => NormalParameterTypeInfoMaker.new;

  @override
  get sSealedTemplateConstructor => SimpleEntitySSealedTemplate.new;

  @override
  get modddelTemplateConstructor => SimpleEntityModddelTemplate.new;
}

class IterableEntityGenerator extends AnnotatedClassGenerator<
    IterableEntitySSealedInfo,
    IterableEntityModddelInfo,
    IterablesEntityParametersInfo,
    EntityValidationInfo,
    IterableParameterTypeInfoMaker> {
  @override
  get sSealedInfoConstructor => IterableEntitySSealedInfo.new;

  @override
  get modddelInfoConstructor => IterableEntityModddelInfo.new;

  @override
  get modddelParametersInfoConstructor =>
      IterablesEntityParametersInfo.fromConstructorDetails;

  @override
  get modddelValidationInfoConstructor =>
      EntityValidationInfo.fromParsedValidationSteps;

  @override
  get parameterTypeInfoMakerConstructor => IterableParameterTypeInfoMaker.new;

  @override
  get sSealedTemplateConstructor => IterableEntitySSealedTemplate.new;

  @override
  get modddelTemplateConstructor => IterableEntityModddelTemplate.new;
}

class Iterable2EntityGenerator extends AnnotatedClassGenerator<
    Iterable2EntitySSealedInfo,
    Iterable2EntityModddelInfo,
    IterablesEntityParametersInfo,
    EntityValidationInfo,
    Iterable2ParameterTypeInfoMaker> {
  @override
  get sSealedInfoConstructor => Iterable2EntitySSealedInfo.new;

  @override
  get modddelInfoConstructor => Iterable2EntityModddelInfo.new;

  @override
  get modddelParametersInfoConstructor =>
      IterablesEntityParametersInfo.fromConstructorDetails;

  @override
  get modddelValidationInfoConstructor =>
      EntityValidationInfo.fromParsedValidationSteps;

  @override
  get parameterTypeInfoMakerConstructor => Iterable2ParameterTypeInfoMaker.new;

  @override
  get sSealedTemplateConstructor => Iterable2EntitySSealedTemplate.new;

  @override
  get modddelTemplateConstructor => Iterable2EntityModddelTemplate.new;
}
