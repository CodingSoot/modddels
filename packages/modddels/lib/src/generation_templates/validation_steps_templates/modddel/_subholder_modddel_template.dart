import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// The template for the "subholder" class of the [validation].
///
/// It's a class that  holds the fields of the parent validationStep of the
/// [validation] **after** the [NonNullParamTransformation]s that refer to the
/// validation have been applied.
///
class SubHolderModddelTemplate extends ModddelGenerationTemplate {
  SubHolderModddelTemplate({
    required this.sSealedInfo,
    required this.modddelInfo,
    required this.validation,
  });

  @override
  final ModddelInfo modddelInfo;

  @override
  final SSealedInfo? sSealedInfo;

  final ValidationInfo validation;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $membersProperties

      ${hasDependencies ? dependenciesProperties : ''}

      ${hasDependencies ? initMethod : ''}

      ${isCaseModddel ? maybeMapModddelsMethod : ''}
    }
    ''';
  }

  /// The declaration of the subholder class.
  ///
  /// For example :
  ///
  /// - If the modddel is solo : `class _ValidatePersonBlackList`
  /// - If the modddel is a case-modddel : `class _ValidateRainyHabitable
  ///   extends _ValidateWeatherHabitable`.
  ///
  String get classDeclaration {
    if (isCaseModddel) {
      final sSealedSubHolderClassName =
          sSealedClassIdentifiers!.getSubHolderClassName(validation);

      return ClassDeclarationTemplate(
        className: _subHolderClassName,
        isAbstract: false,
        extendsClasses: [sSealedSubHolderClassName],
      ).toString();
    }

    return ClassDeclarationTemplate(
      className: _subHolderClassName,
      isAbstract: false,
    ).toString();
  }

  /// The constructor of the subholder class.
  ///
  String get constructor {
    final constructorParams = validation.subHolderParametersTemplate
        .asNamed(optionality: Optionality.makeAllRequired)
        .asLocal();

    return '$_subHolderClassName($constructorParams);';
  }

  /// The properties for the member parameters.
  ///
  String get membersProperties {
    final properties = validation.subHolderParametersTemplate.allParameters
        .asPropreties()
        .map((property) => property.copyWithModifiers(
            addOverrideAnnotation: isSharedParam(property.name)))
        .toList();

    return properties.join('\n');
  }

  /// The late final properties for the dependency parameters.
  ///
  String get dependenciesProperties {
    assert(hasDependencies);

    final dependencyParameters = modddelInfo
        .modddelParametersInfo.dependencyParametersTemplate.allParameters;

    return dependencyParameters
        .asPropreties(isLate: true)
        .map((property) => property.copyWithModifiers(
            addOverrideAnnotation: isSharedParam(property.name)))
        .join('\n');
  }

  /// The "init" method that initializes the late dependency properties.
  ///
  String get initMethod {
    assert(hasDependencies);

    final dependenciesParameter = modddelClassIdentifiers.dependenciesParameter;

    String getMethodPrototype() {
      final initMethodName =
          generalIdentifiers.topLevelMixinIdentifiers.initMethodName;
      return 'void $initMethodName($dependenciesParameter)';
    }

    String getLateInitialization() {
      final dependencyParameters = modddelInfo
          .modddelParametersInfo.dependencyParametersTemplate.allParameters;

      return dependencyParameters.map((param) {
        final paramName = param.name;
        return '$paramName = ${dependenciesParameter.name}.$paramName;';
      }).join('\n');
    }

    return '''
    ${getMethodPrototype()} {
      ${getLateInitialization()}
    }
    ''';
  }

  String get maybeMapModddelsMethod {
    assert(isCaseModddel);

    final unionCaseParamName =
        modddelInfo.modddelClassInfo.constructor.callbackName;

    final method = MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo!.sSealedClassInfo,
      getCaseModddelParam: (caseModddel) => CaseModddelParam(
        name: caseModddel.constructor.callbackName,
        type: caseModddel.classIdentifiers.getSubHolderClassName(validation),
      ),
      bodyKind: MethodBodyKind.withImplementation,
      unionCaseParamName: unionCaseParamName,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  /// The name of the subholder class.
  ///
  String get _subHolderClassName =>
      modddelClassIdentifiers.getSubHolderClassName(validation);
}
