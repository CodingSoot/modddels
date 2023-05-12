import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/fields_interface_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_methods.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';

/// The template for the invalid super-sealed class.
///
class InvalidSSealedTemplate extends SSealedGenerationTemplate {
  InvalidSSealedTemplate({
    required this.sSealedInfo,
  });

  @override
  final SSealedInfo sSealedInfo;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $mapInvalidMethod

      $maybeMapInvalidMethod

      $mapOrNullInvalidMethod

      $whenInvalidMethod

      $maybeWhenInvalidMethod

      $whenOrNullInvalidMethod

      $mapModddelsMethod

      $maybeMapModddelsMethod

      $mapOrNullModddelsMethod
    }
    ''';
  }

  /// The declaration of the invalid super-sealed class.
  ///
  /// For example : `mixin InvalidWeather implements Weather,
  /// InvalidValueObject` ± the [FieldsInterfaceTemplate].
  ///
  String get classDeclaration {
    final invalidClassName = sSealedClassIdentifiers.invalidClassName;

    final declaration = MixinDeclarationTemplate(
      className: invalidClassName,
      implementsClasses: [
        sSealedClassIdentifiers.className,
        _invalidBaseInterfaceName,
      ],
    );

    return FieldsInterfaceTemplate.wrapDeclaration(
      mixinDeclaration: declaration,
      fields: sharedMembersGetters,
    ).toString();
  }

  /// The getters for the shared member parameters.
  ///
  String get sharedMembersGetters {
    final parameters = sSealedInfo.sSealedParametersInfo.sharedMemberParameters
        .map((sharedParam) => sharedParam.toExpandedParameter())
        .toList();

    final getters = parameters.asGetters(implementation: null);

    return getters.join('\n');
  }

  String get mapInvalidMethod {
    return MapInvalidMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.abstract,
    ).toString();
  }

  String get maybeMapInvalidMethod {
    return MaybeMapInvalidMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.abstract,
    ).toString();
  }

  String get mapOrNullInvalidMethod {
    return MapOrNullInvalidMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.abstract,
    ).toString();
  }

  String get whenInvalidMethod {
    return WhenInvalidMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.abstract,
    ).toString();
  }

  String get maybeWhenInvalidMethod {
    return MaybeWhenInvalidMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.abstract,
    ).toString();
  }

  String get whenOrNullInvalidMethod {
    return WhenOrNullInvalidMethod(
      classInfo: sSealedInfo.sSealedClassInfo,
      validationSteps: sSealedInfo.sSealedValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.abstract,
    ).toString();
  }

  String get mapModddelsMethod {
    final method = MapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
    );
    return '''
    @override
    $method
    ''';
  }

  String get maybeMapModddelsMethod {
    final method = MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.abstract,
      unionCaseParamName: null,
    );
    return '''
    @override
    $method
    ''';
  }

  String get mapOrNullModddelsMethod {
    final method = MapOrNullModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
    );
    return '''
    @override
    $method
    ''';
  }

  /// The name of the implemented "invalid" base interface.
  ///
  String get _invalidBaseInterfaceName =>
      GlobalIdentifiers.validnessInterfacesIdentifiers
          .getInvalidBaseInterfaceName(modddelKind);

  CaseModddelParam _getCaseModddelParam(ModddelClassInfo caseModddel) {
    return CaseModddelParam.fromParameter(
        caseModddel.classIdentifiers.invalidParameter);
  }
}
