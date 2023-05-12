import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/fields_interface_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_methods.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';

/// The template for the abstract invalid union-case class.
///
class InvalidModddelTemplate extends ModddelGenerationTemplate {
  InvalidModddelTemplate({
    required this.modddelInfo,
    required this.sSealedInfo,
  });

  @override
  final ModddelInfo modddelInfo;

  @override
  final SSealedInfo? sSealedInfo;

  @override
  String toString() {
    // If this is a case-modddel, the fields would be included in the
    // FieldsInterface, so they shouldn't be part of the mixin.
    final fields = isCaseModddel ? '' : membersGetters;

    return '''
    $classDeclaration {
      ${isCaseModddel ? '' : fields}

      $mapInvalidMethod

      $maybeMapInvalidMethod

      $mapOrNullInvalidMethod

      $whenInvalidMethod

      $maybeWhenInvalidMethod

      $whenOrNullInvalidMethod
    }
    ''';
  }

  /// The declaration of the abstract invalid union-case class.
  ///
  /// For example :
  ///
  /// - If the modddel is solo : `mixin InvalidPerson implements Person,
  ///   InvalidEntity`
  /// - If the modddel is a case-modddel : `mixin InvalidSunny implements
  ///   InvalidWeather, Sunny` ± the [FieldsInterfaceTemplate].
  ///
  String get classDeclaration {
    final invalidClassName = modddelClassIdentifiers.invalidClassName;

    if (isCaseModddel) {
      final declaration = MixinDeclarationTemplate(
        className: invalidClassName,
        implementsClasses: [
          sSealedClassIdentifiers!.invalidClassName,
          modddelClassIdentifiers.className,
        ],
      );

      return FieldsInterfaceTemplate.wrapDeclaration(
        mixinDeclaration: declaration,
        fields: membersGetters,
      ).toString();
    }

    final declaration = MixinDeclarationTemplate(
      className: invalidClassName,
      implementsClasses: [
        modddelClassIdentifiers.className,
        _invalidBaseInterfaceName,
      ],
    );

    return declaration.toString();
  }

  /// The getters for the member parameters.
  ///
  String get membersGetters {
    final parameters = modddelInfo
        .modddelParametersInfo.memberParametersTemplate.allParameters;

    final getters = parameters.map((parameter) {
      final getter = Getter.fromParameter(parameter, implementation: null);

      // If the parameter has a `@withGetter` annotation, the getter should have
      // an `@override` annotation. BUT if the modddel is a case-modddel, it
      // shouldn't because the getter will be extracted in the FieldsInterface.
      final hasOverride = parameter.hasWithGetterAnnotation && !isCaseModddel;

      // The doc should only be removed if the parameter has a withGetter
      // annotation, in which case the doc will be copied in the base modddel
      // template.
      final removeDoc = parameter.hasWithGetterAnnotation;

      return getter.copyWithModifiers(
        addOverrideAnnotation: hasOverride,
        removeDoc: removeDoc,
      );
    }).toList();

    return getters.join('\n');
  }

  String get mapInvalidMethod {
    final method = MapInvalidMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get maybeMapInvalidMethod {
    final method = MaybeMapInvalidMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get mapOrNullInvalidMethod {
    final method = MapOrNullInvalidMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get whenInvalidMethod {
    final method = WhenInvalidMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get maybeWhenInvalidMethod {
    final method = MaybeWhenInvalidMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get whenOrNullInvalidMethod {
    final method = WhenOrNullInvalidMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  /// The name of the implemented "invalid" base interface.
  ///
  String get _invalidBaseInterfaceName =>
      GlobalIdentifiers.validnessInterfacesIdentifiers
          .getInvalidBaseInterfaceName(modddelKind);
}
