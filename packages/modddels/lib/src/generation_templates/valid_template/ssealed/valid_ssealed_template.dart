import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/fields_interface_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_methods.dart';
import 'package:modddels/src/generation_templates/abstract/ssealed_generation_template.dart';

/// The template for the valid super-sealed class.
///
class ValidSSealedTemplate extends SSealedGenerationTemplate {
  ValidSSealedTemplate({
    required this.sSealedInfo,
  });

  @override
  final SSealedInfo sSealedInfo;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $mapModddelsMethod

      $maybeMapModddelsMethod

      $mapOrNullModddelsMethod
    }
    ''';
  }

  /// The declaration of the valid ssealed class.
  ///
  /// For example : `mixin ValidWeather implements Weather, ValidValueObject` ±
  /// the [FieldsInterfaceTemplate].
  ///
  String get classDeclaration {
    final validClassName = sSealedClassIdentifiers.validClassName;

    final declaration = MixinDeclarationTemplate(
      className: validClassName,
      implementsClasses: [
        sSealedClassIdentifiers.className,
        _validBaseInterfaceName,
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
    final parametersTemplate =
        sSealedInfo.sSealedValidationInfo.validParametersTemplate;

    final getters =
        parametersTemplate.allParameters.asGetters(implementation: null);

    return getters.join('\n');
  }

  String get mapModddelsMethod {
    final function = MapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
    );
    return '''
    @override
    $function
    ''';
  }

  String get maybeMapModddelsMethod {
    final function = MaybeMapModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.abstract,
      unionCaseParamName: null,
    );
    return '''
    @override
    $function
    ''';
  }

  String get mapOrNullModddelsMethod {
    final function = MapOrNullModddelsMethod(
      sSealedClassInfo: sSealedInfo.sSealedClassInfo,
      getCaseModddelParam: _getCaseModddelParam,
      bodyKind: MethodBodyKind.withImplementation,
    );
    return '''
    @override
    $function
    ''';
  }

  /// The name of the implemented "valid" base interface.
  ///
  String get _validBaseInterfaceName =>
      GlobalIdentifiers.validnessInterfacesIdentifiers
          .getValidBaseInterfaceName(modddelKind);

  CaseModddelParam _getCaseModddelParam(ModddelClassInfo caseModddel) {
    return CaseModddelParam.fromParameter(
        caseModddel.classIdentifiers.validParameter);
  }
}
