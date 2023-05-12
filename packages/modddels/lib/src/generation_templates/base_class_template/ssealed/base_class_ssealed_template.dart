import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/shared_parameter.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_methods.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/top_level_elements/top_level_elements.dart';
import 'package:modddels/src/generation_templates/base_class_template/top_level_elements/top_level_modddel_elements.dart';

/// The template for the base ssealed class.
///
/// It's a mixin that is mixed-in by the annotated super-sealed class (=
/// top-level mixin).
///
abstract class BaseClassSSealedTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends SSealedGenerationTemplate<SI, MI> {
  BaseClassSSealedTemplate({
    required this.sSealedInfo,
  });

  @override
  final SI sSealedInfo;

  @override
  String toString() {
    final topLevelElements = this.topLevelElements;

    final caseModddelsTopLevelElements = caseModddelsInfos
        .map(getTopLevelModddelElements)
        .map((topLevelModddelElements) => '''
          ${topLevelModddelElements.createMethod}

          ${topLevelModddelElements.verifyStepMethods}

          ${topLevelModddelElements.validateContentMethod ?? ''}
          ''')
        .join('\n');

    return '''
    $classDeclaration {
      $sharedWithGetterGetters

      ${hasDependencies ? sharedDependenciesGetters : ''}

      ${topLevelElements.instanceMethod}

      $caseModddelsTopLevelElements

      $mapValidnessMethod

      $maybeMapValidnessMethod

      $mapOrNullValidnessMethod

      $mapValidityMethod

      $maybeMapValidityMethod

      $mapModddelsMethod

      $maybeMapModddelsMethod

      $mapOrNullModddelsMethod

      $copyWithGetter

      ${topLevelElements.validateMethods}

      ${topLevelElements.propsGetter}
    }
    ''';
  }

  /// Holds some elements that are part of the top-level mixin.
  ///
  TopLevelElements get topLevelElements =>
      TopLevelElements.forSSealedTemplate(baseClassSSealedTemplate: this);

  /// Returns the [TopLevelModddelElements] for the given [caseModddel].
  ///
  /// Each [TopLevelModddelElements] holds some elements that are part of the
  /// top-level mixin and that are related to the case-modddel.
  ///
  TopLevelModddelElements getTopLevelModddelElements(MI caseModddel);

  /// The declaration of the base ssealed class.
  ///
  /// For example : `mixin _$Weather`
  ///
  String get classDeclaration {
    final declaration = MixinDeclarationTemplate(
      className: sSealedClassIdentifiers.baseClassName,
    );

    return declaration.toString();
  }

  /// The getters for the shared member parameters that are annotated with `@withGetter`
  /// in all case-modddels.
  ///
  String get sharedWithGetterGetters {
    final sharedWithGetterParameters = sSealedInfo
        .sSealedParametersInfo.sharedMemberParameters
        .asExpandedParameters()
        .where((p) => p.hasWithGetterAnnotation)
        .toList();

    return sharedWithGetterParameters
        .asGetters(
            implementation:
                'throw ${GlobalIdentifiers.unimplementedErrorVarName}')
        .join('\n');
  }

  /// Getters for shared dependency parameters.
  ///
  String get sharedDependenciesGetters {
    assert(hasDependencies);

    final sharedDependenciesParameters = sSealedInfo
        .sSealedParametersInfo.sharedDependencyParameters
        .asExpandedParameters();

    return sharedDependenciesParameters
        .asGetters(
            implementation:
                'throw ${GlobalIdentifiers.unimplementedErrorVarName}')
        .join('\n');
  }

  /// The "copyWith" getter.
  ///
  /// NB : Due to a limitation in the Dart language related to inheritence, this
  /// method only includes shared properties that have _the same type_ across
  /// all case-modddels (which should equal the type of the shared property
  /// itself). See
  /// https://dart.dev/guides/language/sound-problems#invalid-method-override
  ///
  String get copyWithGetter {
    final copyWithParameters = sSealedInfo
        .sSealedParametersInfo.sharedParameters
        .where((sharedParam) => sharedParam.caseParametersHaveSameType)
        .toList()
        .asExpandedParameters();

    final parametersTemplate =
        ParametersTemplate(namedParameters: copyWithParameters)
            .asNamed(optionality: Optionality.makeAllOptional);

    final returnType =
        '${sSealedClassIdentifiers.className} Function($parametersTemplate)';

    return Getter(
      name: generalIdentifiers.copyWithGetterName,
      type: returnType,
      implementation: 'throw ${GlobalIdentifiers.unimplementedErrorVarName}',
    ).toString();
  }

  String get mapValidnessMethod {
    return MapValidnessMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.throwUnimplementedError,
    ).toString();
  }

  String get maybeMapValidnessMethod {
    return MaybeMapValidnessMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.throwUnimplementedError,
      unionCaseParamName: null,
    ).toString();
  }

  String get mapOrNullValidnessMethod {
    return MapOrNullValidnessMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.throwUnimplementedError,
    ).toString();
  }

  String get mapValidityMethod {
    return MapValidityMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.throwUnimplementedError,
    ).toString();
  }

  String get maybeMapValidityMethod {
    return MaybeMapValidityMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.throwUnimplementedError,
    ).toString();
  }

  String get mapModddelsMethod {
    return MapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.throwUnimplementedError,
    ).toString();
  }

  String get maybeMapModddelsMethod {
    return MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.throwUnimplementedError,
      unionCaseParamName: null,
    ).toString();
  }

  String get mapOrNullModddelsMethod {
    return MapOrNullModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.throwUnimplementedError,
    ).toString();
  }

  CaseModddelParam _getCaseModddelParam(ModddelClassInfo caseModddel) {
    return CaseModddelParam(
      name: caseModddel.constructor.callbackName,
      type: caseModddel.classIdentifiers.className,
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

class ValueObjectBaseClassSSealedTemplate extends BaseClassSSealedTemplate<
    ValueObjectSSealedInfo, ValueObjectModddelInfo> {
  ValueObjectBaseClassSSealedTemplate({
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements getTopLevelModddelElements(
          ValueObjectModddelInfo caseModddel) =>
      ValueObjectTopLevelModddelElements.forSSealedTemplate(
        baseClassSSealedTemplate: this,
        modddelInfo: caseModddel,
      );
}

class SimpleEntityBaseClassSSealedTemplate extends BaseClassSSealedTemplate<
    SimpleEntitySSealedInfo, SimpleEntityModddelInfo> {
  SimpleEntityBaseClassSSealedTemplate({
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements getTopLevelModddelElements(
          SimpleEntityModddelInfo caseModddel) =>
      SimpleEntityTopLevelModddelElements.forSSealedTemplate(
        baseClassSSealedTemplate: this,
        modddelInfo: caseModddel,
      );
}

class IterableEntityBaseClassSSealedTemplate extends BaseClassSSealedTemplate<
    IterableEntitySSealedInfo, IterableEntityModddelInfo> {
  IterableEntityBaseClassSSealedTemplate({
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements getTopLevelModddelElements(
          IterableEntityModddelInfo caseModddel) =>
      IterableEntityTopLevelModddelElements.forSSealedTemplate(
        baseClassSSealedTemplate: this,
        modddelInfo: caseModddel,
      );
}

class Iterable2EntityBaseClassSSealedTemplate extends BaseClassSSealedTemplate<
    Iterable2EntitySSealedInfo, Iterable2EntityModddelInfo> {
  Iterable2EntityBaseClassSSealedTemplate({
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements getTopLevelModddelElements(
          Iterable2EntityModddelInfo caseModddel) =>
      Iterable2EntityTopLevelModddelElements.forSSealedTemplate(
        baseClassSSealedTemplate: this,
        modddelInfo: caseModddel,
      );
}
