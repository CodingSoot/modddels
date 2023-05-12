import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';

/// The template for the super-sealed "subholder" class of the [validation].
///
/// It's an abstract class which has as union-cases the subholders of that
/// [validation] in the different case-modddels.
///
class SubHolderSSealedTemplate extends SSealedGenerationTemplate {
  SubHolderSSealedTemplate({
    required this.sSealedInfo,
    required this.validation,
  });

  @override
  final SSealedInfo sSealedInfo;

  final ValidationInfo validation;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $membersGetters

      ${hasDependencies ? dependenciesGetters : ''}

      $mapModddelsMethod

      $maybeMapModddelsMethod

      $mapOrNullModddelsMethod
    }
    ''';
  }

  /// The declaration of the subholder class.
  ///
  /// For example : `abstract class _ValidateWeatherHabitable`
  ///
  String get classDeclaration {
    final subHolderClassName =
        sSealedClassIdentifiers.getSubHolderClassName(validation);

    return ClassDeclarationTemplate(
      className: subHolderClassName,
      isAbstract: true,
    ).toString();
  }

  /// The getters for the member parameters.
  ///
  String get membersGetters {
    final getters = validation.subHolderParametersTemplate.allParameters
        .asGetters(implementation: null)
        .toList();

    return getters.join('\n');
  }

  /// The getters for the dependency parameters.
  ///
  String get dependenciesGetters {
    assert(hasDependencies);

    final dependencyParameters = sSealedInfo
        .sSealedParametersInfo.sharedDependencyParameters
        .map((p) => p.toExpandedParameter())
        .toList();

    return dependencyParameters.asGetters(implementation: null).join('\n');
  }

  String get mapModddelsMethod {
    return MapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
    ).toString();
  }

  String get maybeMapModddelsMethod {
    return MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.abstract,
      unionCaseParamName: null,
    ).toString();
  }

  String get mapOrNullModddelsMethod {
    return MapOrNullModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
    ).toString();
  }

  CaseModddelParam _getCaseModddelParam(ModddelClassInfo caseModddel) {
    return CaseModddelParam(
      name: caseModddel.constructor.callbackName,
      type: caseModddel.classIdentifiers.getSubHolderClassName(validation),
    );
  }
}
