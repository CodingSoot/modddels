import 'dart:async';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_modddel_annotation.dart';
import 'package:modddels/src/core/templates/constructor_details.dart';
import 'package:modddels/src/generation_templates/global_templates/copy_with_default_template.dart';
import 'package:modddels/src/generation_templates/global_templates/unimplemented_error_template.dart';
import 'package:modddels/src/generators/annotated_class_generator.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';
import 'package:source_gen/source_gen.dart';

class ModddelsGenerator extends GeneratorForAnnotation<Modddel> {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final generatedForAnnotatedElements =
        await super.generate(library, buildStep);

    final generatedForAll = await generateForAll(library, buildStep);

    return '$generatedForAll \n\n $generatedForAnnotatedElements';
  }

  /// This will be generated **once** at the top of the generated file, no
  /// matter how many annotated classes the source file contains.
  ///
  /// Contains :
  ///
  /// - The unimplementedError variable
  /// - The copyWithDefault constant
  ///
  Future<String> generateForAll(
      LibraryReader library, BuildStep buildStep) async {
    final unimplementedError = UnimplementedErrorTemplate();

    final copyWithDefault = CopyWithDefaultTemplate();

    return '''
    $unimplementedError

    $copyWithDefault
    ''';
  }

  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@Modddel can only be applied on classes.',
        element: element,
      );
    }

    final ClassElement annotatedClass = element;

    final library = annotatedClass.library;

    final parsedModddelAnnotation =
        ParsedModddelAnnotation.fromModddelAnnotation(
      library: library,
      annotation: annotation,
      annotatedClass: annotatedClass,
    );

    final modddelKind = getModddelKind(annotatedClass);

    if (modddelKind == null) {
      throw InvalidGenerationSourceError(
        'Should extend a single Modddel superclass.',
        element: annotatedClass,
      );
    }

    final constructorsDetails = await parseConstructorsDetails(
      buildStep: buildStep,
      originLibrary: library,
      annotatedClass: annotatedClass,
    );

    final AnnotatedClassGenerator generator = await modddelKind.when(
      valueObject: (valueObjectKind) {
        return valueObjectKind.when(
          singleValueObject: () => SingleValueObjectGenerator(),
          multiValueObject: () => MultiValueObjectGenerator(),
        );
      },
      entity: (entityKind) {
        return entityKind.when(
          simpleEntity: () => SimpleEntityGenerator(),
          iterableEntity: () => IterableEntityGenerator(),
          iterable2Entity: () => Iterable2EntityGenerator(),
        );
      },
    );

    return generator.generate(
      annotatedClass: annotatedClass,
      constructors: constructorsDetails,
      parsedModddelAnnotation: parsedModddelAnnotation,
    );
  }

  /// Returns the [ModddelKind] of the [annotatedClass].
  ///
  /// It checks all the superclasses of the [annotatedClass], and if one of them
  /// matches a [ModddelKind], it returns it.
  ///
  /// Returns null if none of the superclasses matches a [ModddelKind], or if
  /// there are two superclasses of different [ModddelKind]s (which should not
  /// be possible).
  ///
  ModddelKind? getModddelKind(ClassElement annotatedClass) {
    final superClasses =
        annotatedClass.allSupertypes.map((e) => e.element).toList();

    // Whether the annotated class extends the superclass matching
    // [modddelKind].
    bool extendsModddel(ModddelKind modddelKind) {
      return superClasses.any((element) => element.name == modddelKind.name);
    }

    final allModddelKinds = const [
      // SingleValueObject
      ModddelKind.valueObject(
          valueObjectKind: ValueObjectKind.singleValueObject()),
      // MultiValueObject
      ModddelKind.valueObject(
          valueObjectKind: ValueObjectKind.multiValueObject()),
      // SimpleEntity
      ModddelKind.entity(entityKind: EntityKind.simpleEntity()),
      // IterableEntity
      ModddelKind.entity(entityKind: EntityKind.iterableEntity()),
      // Iterable2Entity
      ModddelKind.entity(entityKind: EntityKind.iterable2Entity()),
    ];

    return allModddelKinds
        .singleWhereOrNull((modddelKind) => extendsModddel(modddelKind));
  }
}
