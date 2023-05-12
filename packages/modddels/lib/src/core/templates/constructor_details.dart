import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/utils.dart';
import 'package:source_gen/source_gen.dart';
import 'package:collection/collection.dart';

/// Holds information about a factory constructor of an annotated class.
///
class ConstructorDetails {
  ConstructorDetails._({
    required this.name,
    required this.constructorElement,
    required this.parametersTemplate,
    required this.isDefault,
    required this.fullName,
    required this.callbackName,
    required this.caseModddelClassName,
  });

  @factory
  static Future<ConstructorDetails> fromConstructorElement({
    required LibraryElement originLibrary,
    required BuildStep buildStep,
    required ConstructorElement constructor,
    required String annotatedClassName,
  }) async {
    final parametersTemplate = await ParametersTemplate.fromParameterElements(
      buildStep: buildStep,
      originLibrary: originLibrary,
      parameters: constructor.parameters,
    );

    final constructorName = constructor.name;
    final isDefaultConstructor = constructor.name.isEmpty;

    return ConstructorDetails._(
      name: constructorName,
      constructorElement: constructor,
      isDefault: isDefaultConstructor,
      parametersTemplate: parametersTemplate,
      fullName: isDefaultConstructor
          ? annotatedClassName
          : '$annotatedClassName.$constructorName',
      callbackName:
          isDefaultConstructor ? 'default$annotatedClassName' : constructorName,
      caseModddelClassName: isDefaultConstructor
          ? 'Default$annotatedClassName'
          : constructorName.capitalize(),
    );
  }

  final ConstructorElement constructorElement;

  /// The parameters template of the constructor. Represents all the parameters
  /// of the constructors as they are declared.
  ///
  final ParametersTemplate parametersTemplate;

  /// The name of the constructor. Can be empty.
  ///
  /// Example :
  ///
  /// - For `factory Question.qcmQuestion()` : 'qcmQuestion'
  /// - For `factory Question()` : ''
  ///
  final String name;

  /// The full name of the constructor.
  ///
  /// Example :
  ///
  /// - For `factory Question.qcmQuestion()` : 'Question.qcmQuestion'
  /// - For `factory Question()` : 'Question'
  ///
  final String fullName;

  /// Whether this is a default (unnamed) factory constructor
  ///
  final bool isDefault;

  /// Example :
  ///
  /// - For `factory Question.qcmQuestion()` : 'qcmQuestion'
  /// - For `factory Question()` : 'defaultQuestion'
  ///
  final String callbackName;

  /// Example :
  ///
  /// - For `factory Question.qcmQuestion()` : QcmQuestion
  /// - For `factory Question()` : DefaultQuestion
  ///
  final String caseModddelClassName;
}

Future<List<ConstructorDetails>> parseConstructorsDetails({
  required BuildStep buildStep,
  required LibraryElement originLibrary,
  required ClassElement annotatedClass,
}) async {
  final normalConstructors = annotatedClass.constructors
      .where((element) => !element.isFactory)
      .toList();

  _assertValidNormalConstructorUsage(normalConstructors,
      annotatedClass: annotatedClass);

  final factoryConstructors = annotatedClass.constructors
      .where((element) => element.isFactory)
      .toList();

  if (factoryConstructors.isEmpty) {
    throw InvalidGenerationSourceError(
      'Marked ${annotatedClass.name} with @Modddel, but there is no factory constructor.',
      element: annotatedClass,
    );
  }

  _assertValidFactoryConstructorUsage(factoryConstructors, annotatedClass);

  final result = await Future.wait(factoryConstructors
      .map((constructor) => ConstructorDetails.fromConstructorElement(
            originLibrary: originLibrary,
            buildStep: buildStep,
            constructor: constructor,
            annotatedClassName: annotatedClass.name,
          )));

  _assertValidFactoryConstructorNames(result);

  return result;
}

void _assertValidNormalConstructorUsage(
  List<ConstructorElement> normalConstructors, {
  required ClassElement annotatedClass,
}) {
  final privateConstructor = normalConstructors.singleWhereOrNull(
      (constructor) =>
          !constructor.isFactory &&
          constructor.name == '_' &&
          constructor.parameters.isEmpty);

  if (privateConstructor == null) {
    throw InvalidGenerationSourceError(
      'Classes decorated with @Modddel should have a single non-factory '
      'constructor, without parameters, and named ${annotatedClass.name}._()',
      element: annotatedClass,
    );
  }
}

void _assertValidFactoryConstructorUsage(
    List<ConstructorElement> factoryConstructors, ClassElement annotatedClass) {
  for (final constructor in factoryConstructors) {
    if (constructor.isPrivate) {
      throw InvalidGenerationSourceError(
        'A Modddel cannot have private factory constructors.',
        element: constructor,
      );
    }

    if (constructor.isConst) {
      throw InvalidGenerationSourceError(
        'A Modddel cannot have const factory constructors.',
        element: constructor,
      );
    }

    if (constructor.redirectedConstructor != null) {
      throw InvalidGenerationSourceError(
        'A Modddel cannot have redirecting factory constructors.',
        element: constructor,
      );
    }
  }
}

void _assertValidFactoryConstructorNames(
    List<ConstructorDetails> factoryConstructors) {
  final defaultConstructor = factoryConstructors
      .firstWhereOrNull((constructor) => constructor.isDefault);

  if (defaultConstructor != null) {
    for (final constructor in factoryConstructors) {
      if (constructor == defaultConstructor) {
        continue;
      }
      if (defaultConstructor.caseModddelClassName ==
          constructor.caseModddelClassName) {
        throw InvalidGenerationSourceError(
          'The name of the factory constructor "${constructor.name}" conflicts '
          'with the default factory constructor.',
          element: constructor.constructorElement,
        );
      }
    }
  }
}
