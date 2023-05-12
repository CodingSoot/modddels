import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';

/// The template for the dependencies class, which holds all the dependency
/// parameters.
///
class DependenciesModddelTemplate extends ModddelGenerationTemplate {
  DependenciesModddelTemplate({
    required this.sSealedInfo,
    required this.modddelInfo,
  });

  @override
  final ModddelInfo modddelInfo;

  @override
  final SSealedInfo? sSealedInfo;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $properties
    }
    ''';
  }

  String get dependenciesClassName =>
      modddelClassIdentifiers.dependenciesClassName;

  /// The declaration of the dependencies class.
  ///
  /// For example : `class _$SunnyDependencies`
  ///
  String get classDeclaration {
    return ClassDeclarationTemplate(
      className: dependenciesClassName,
      isAbstract: false,
    ).toString();
  }

  /// The constructor of the dependencies class.
  ///
  String get constructor {
    final constructorParams = modddelInfo
        .modddelParametersInfo.dependencyParametersTemplate
        .asNamed(optionality: Optionality.makeAllRequired)
        .asLocal();

    return '$dependenciesClassName($constructorParams);';
  }

  /// The dependency properties.
  ///
  String get properties {
    final properties = modddelInfo
        .modddelParametersInfo.dependencyParametersTemplate.allParameters
        .asPropreties()
        .map((param) => param.copyWith(doc: ''))
        .toList();

    return properties.join('\n');
  }
}
