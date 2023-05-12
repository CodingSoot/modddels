import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/fields_interface_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/validness_pattern_matching/validness_pattern_matching_prototypes.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/top_level_elements/top_level_elements.dart';
import 'package:modddels/src/generation_templates/base_class_template/top_level_elements/top_level_modddel_elements.dart';

/// The template for the base modddel class.
///
/// - If the modddel is solo : It's a mixin that is mixed-in by the annotated
///   class (= top-level mixin).
/// - If the modddel is a case-modddel : It's a stand-alone mixin.
///
abstract class BaseClassModddelTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends ModddelGenerationTemplate<SI, MI> {
  BaseClassModddelTemplate({
    required this.modddelInfo,
    required this.sSealedInfo,
  });

  @override
  final MI modddelInfo;

  @override
  final SI? sSealedInfo;

  @override
  String toString() {
    final topLevelElements = this.topLevelElements;

    // If this is a case-modddel, the fields would be included in the
    // FieldsInterface, so they shouldn't be part of the mixin.
    final fields = isCaseModddel ? '' : withGetterGetters;

    return '''
    $classDeclaration {
      $fields

      ${hasDependencies ? dependenciesProperties : ''}

      ${hasDependencies ? initMethod : ''}

      ${isTopLevelMixin ? topLevelElements!.instanceMethod : ''}

      ${isTopLevelMixin ? topLevelModddelElements!.createMethod : ''}

      ${isTopLevelMixin ? topLevelModddelElements!.verifyStepMethods : ''}

      ${isTopLevelMixin ? topLevelModddelElements!.validateContentMethod ?? '' : ''}

      ${isCaseModddel ? toEitherGetter : ''}

      ${isCaseModddel ? toBroadEitherGetter : ''}

      $mapValidnessMethod

      $maybeMapValidnessMethod

      $mapOrNullValidnessMethod

      $mapValidityMethod

      $maybeMapValidityMethod

      $copyWithGetter

      ${isTopLevelMixin ? topLevelElements!.validateMethods : ''}

      ${isTopLevelMixin ? topLevelElements!.propsGetter : ''}
    }
    ''';
  }

  /// Whether the base modddel class is a mixin that is mixed-in by the
  /// annotated class.
  ///
  bool get isTopLevelMixin => !isCaseModddel;

  /// Holds some elements that are part of the top-level mixin.
  ///
  /// Null if the base class modddel is not a top-level mixin.
  ///
  TopLevelElements? get topLevelElements => isTopLevelMixin
      ? TopLevelElements.forModddelTemplate(baseClassModddelTemplate: this)
      : null;

  /// Holds some elements that are part of the top-level mixin and that are
  /// related to the solo modddel.
  ///
  /// Null if the base class modddel is not a top-level mixin (i.e if the
  /// modddel is a case-modddel).
  ///
  TopLevelModddelElements? get topLevelModddelElements;

  /// Whether the [parameter], which is part of the factory parameters of the
  /// modddel represented by [modddelInfo], can be accessed from the base
  /// modddel class.
  ///
  /// True if the parameter is a dependency (because dependencies are declared
  /// as late properties in the base class), or is a member parameter annotated
  /// with `@withGetter` (because these have getters in the base class).
  ///
  static bool isDeclaredInBaseModddelClass(
    Parameter parameter, {
    required ModddelInfo modddelInfo,
  }) {
    assert(
        modddelInfo
            .modddelParametersInfo.constructorParametersTemplate.allParameters
            .any((param) => param.name == parameter.name),
        'The parameter must be part of the factory constructor parameters of '
        'the modddel.');

    return parameter.hasDependencyAnnotation ||
        parameter.hasWithGetterAnnotation;
  }

  /// The declaration of the base modddel class.
  ///
  /// For example :
  ///
  /// - If the modddel is solo : `mixin _$Person`
  /// - If the modddel is a case-modddel : `mixin Sunny implements Weather` ±
  ///   the [FieldsInterfaceTemplate].
  ///
  String get classDeclaration {
    final baseClassName = modddelClassIdentifiers.baseClassName;

    if (isTopLevelMixin) {
      final declaration = MixinDeclarationTemplate(className: baseClassName);

      return declaration.toString();
    }

    final declaration = MixinDeclarationTemplate(
      className: baseClassName,
      implementsClasses: [sSealedClassIdentifiers!.className],
    );

    return FieldsInterfaceTemplate.wrapDeclaration(
      mixinDeclaration: declaration,
      fields: withGetterGetters,
    ).toString();
  }

  /// The getters for the member parameters that are annotated with `@withGetter`.
  ///
  String get withGetterGetters {
    final withGetterParameters = modddelInfo
        .modddelParametersInfo.memberParametersTemplate.allParameters
        .where((param) => param.hasWithGetterAnnotation)
        .toList();

    return withGetterParameters
        .asGetters(
            implementation: isTopLevelMixin
                ? 'throw ${GlobalIdentifiers.unimplementedErrorVarName}'
                : null)
        .join('\n');
  }

  /// The late final properties for the dependency parameters.
  ///
  /// NB : These shouldn't be included in the [FieldsInterfaceTemplate], because
  /// they are not affected by the multi-inheritance type mismatch problem, and
  /// they must be declared directly inside the base modddel class.
  ///
  String get dependenciesProperties {
    assert(hasDependencies);

    final dependencyParameters = modddelInfo
        .modddelParametersInfo.dependencyParametersTemplate.allParameters;

    return dependencyParameters
        .asPropreties(isLate: true)
        .map((prop) => prop.copyWithModifiers(
            addOverrideAnnotation: isSharedParam(prop.name)))
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

  /// The override of the [BaseModddel.toEither] getter.
  ///
  /// This is needed when the modddel is a case-modddel in order to tighten the
  /// getter's return type.
  ///
  String get toEitherGetter {
    assert(isCaseModddel);

    final returnType =
        'Either<${modddelClassIdentifiers.invalidClassName}, ${modddelClassIdentifiers.validClassName}>';

    String getImplementation() {
      final mapValidityPrototype = MapValidityPrototype(
          classInfo: modddelInfo.modddelClassInfo,
          validationSteps:
              modddelInfo.modddelValidationInfo.allValidationSteps);

      final mapValidityMethodName = mapValidityPrototype.methodName;

      final mapValidityArgs = mapValidityPrototype.makeArgumentsTemplate(
        validArgument: (validCallbackParameter) {
          final callbackVar = validCallbackParameter.name;
          return '($callbackVar) => right($callbackVar)';
        },
        invalidArgument: (invalidCallbackParameter) {
          final callbackVar = invalidCallbackParameter.name;
          return '($callbackVar) => left($callbackVar)';
        },
      );

      return '$mapValidityMethodName($mapValidityArgs)';
    }

    return Getter(
            name: GlobalIdentifiers.baseModddelIdentifiers.toEitherGetterName,
            type: returnType,
            implementation: getImplementation())
        .copyWithModifiers(addOverrideAnnotation: true)
        .toString();
  }

  /// The override of the [BaseModddel.toBroadEither] getter.
  ///
  /// This is needed when the modddel is a case-modddel in order to tighten the
  /// getter's return type.
  ///
  String get toBroadEitherGetter {
    assert(isCaseModddel);

    final returnType =
        'Either<List<Failure>, ${modddelClassIdentifiers.validClassName}>';

    String getImplementation() {
      final mapValidityPrototype = MapValidityPrototype(
          classInfo: modddelInfo.modddelClassInfo,
          validationSteps:
              modddelInfo.modddelValidationInfo.allValidationSteps);

      final mapValidityMethodName = mapValidityPrototype.methodName;

      final mapValidityArgs = mapValidityPrototype.makeArgumentsTemplate(
        validArgument: (validCallbackParameter) {
          final callbackVar = validCallbackParameter.name;
          return '($callbackVar) => right($callbackVar)';
        },
        invalidArgument: (invalidCallbackParameter) {
          final callbackVar = invalidCallbackParameter.name;
          final failuresGetterName = GlobalIdentifiers
              .invalidModddelBaseIdentifiers.failuresGetterName;

          return '($callbackVar) => left($callbackVar.$failuresGetterName)';
        },
      );

      return '$mapValidityMethodName($mapValidityArgs)';
    }

    return Getter(
      name: GlobalIdentifiers.baseModddelIdentifiers.toBroadEitherGetterName,
      type: returnType,
      implementation: getImplementation(),
    ).copyWithModifiers(addOverrideAnnotation: true).toString();
  }

  /// The "copyWith" getter.
  ///
  String get copyWithGetter {
    final allParameters = modddelInfo
        .modddelParametersInfo.constructorParametersTemplate.allParameters;

    final allParametersTemplate =
        ParametersTemplate(namedParameters: allParameters)
            .asNamed(optionality: Optionality.makeAllOptional);

    final returnType =
        '${modddelClassIdentifiers.className} Function($allParametersTemplate)';

    String getImplementation() {
      final copyWithDefaultConstName =
          GlobalIdentifiers.copyWithIdentifiers.copyWithDefaultConstName;

      final anonymousParamsTemplate = allParametersTemplate
          .transformParameters((parameter) => parameter.copyWith(
                type: 'Object?',
                defaultValue: copyWithDefaultConstName,
              ))
          .asExpanded(showDefaultValue: true);

      final mapValidityPrototype = MapValidityPrototype(
          classInfo: modddelInfo.modddelClassInfo,
          validationSteps:
              modddelInfo.modddelValidationInfo.allValidationSteps);

      final copiedVariablesDeclaration = allParameters.map((parameter) {
        final paramName = parameter.name;
        final copiedVariableName = GlobalIdentifiers.copyWithIdentifiers
            .getCopyWithLocalVarName(parameter);

        if (isDeclaredInBaseModddelClass(parameter, modddelInfo: modddelInfo)) {
          return 'final $copiedVariableName = this.$paramName;';
        }

        final mapValidityMethodName = mapValidityPrototype.methodName;

        final mapValidityArgs = ArgumentsTemplate.fromParametersTemplate(
                mapValidityPrototype.parametersTemplate)
            .asAssignedWith((callbackParam) {
          final callbackVar = callbackParam.name;
          return '($callbackVar) => $callbackVar.$paramName';
        });

        return 'final $copiedVariableName = $mapValidityMethodName($mapValidityArgs);';
      }).join();

      final constructor = modddelInfo.modddelClassInfo.constructor;

      final constructorName = constructor.fullName;

      final constructorArgs = ArgumentsTemplate.fromParametersTemplate(
              constructor.parametersTemplate)
          .asAssignedWith((parameter) {
        final paramName = parameter.name;

        final copiedVariableName = GlobalIdentifiers.copyWithIdentifiers
            .getCopyWithLocalVarName(parameter);

        return '$paramName == $copyWithDefaultConstName ? $copiedVariableName : $paramName as ${parameter.type}';
      });

      final cast =
          isCaseModddel ? ' as ${modddelClassIdentifiers.className}' : '';

      return '''
      return ($anonymousParamsTemplate) {
        $copiedVariablesDeclaration

        return $constructorName($constructorArgs)$cast;
      };
      ''';
    }

    final getter = Getter(
      name: generalIdentifiers.copyWithGetterName,
      type: returnType,
      implementation: getImplementation(),
      implementationKind: ImplementationKind.regular,
    );

    return '''
    $overrideCase
    $getter
    ''';
  }

  String get mapValidnessMethod {
    final method = MapValidnessMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get maybeMapValidnessMethod {
    final method = MaybeMapValidnessMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: isTopLevelMixin
          ? MethodBodyKind.throwUnimplementedError
          : MethodBodyKind.abstract,
      unionCaseParamName: null,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get mapOrNullValidnessMethod {
    final method = MapOrNullValidnessMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get mapValidityMethod {
    final method = MapValidityMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }

  String get maybeMapValidityMethod {
    final method = MaybeMapValidityMethod(
      classInfo: modddelInfo.modddelClassInfo,
      validationSteps: modddelInfo.modddelValidationInfo.allValidationSteps,
      bodyKind: MethodBodyKind.withImplementation,
    );

    return '''
    $overrideCase
    $method
    ''';
  }
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

class ValueObjectBaseClassModddelTemplate extends BaseClassModddelTemplate<
    ValueObjectSSealedInfo, ValueObjectModddelInfo> {
  ValueObjectBaseClassModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements? get topLevelModddelElements => isTopLevelMixin
      ? ValueObjectTopLevelModddelElements.forModddelTemplate(
          baseClassModddelTemplate: this)
      : null;
}

class SimpleEntityBaseClassModddelTemplate extends BaseClassModddelTemplate<
    SimpleEntitySSealedInfo, SimpleEntityModddelInfo> {
  SimpleEntityBaseClassModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements? get topLevelModddelElements => isTopLevelMixin
      ? SimpleEntityTopLevelModddelElements.forModddelTemplate(
          baseClassModddelTemplate: this)
      : null;
}

class IterableEntityBaseClassModddelTemplate extends BaseClassModddelTemplate<
    IterableEntitySSealedInfo, IterableEntityModddelInfo> {
  IterableEntityBaseClassModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements? get topLevelModddelElements => isTopLevelMixin
      ? IterableEntityTopLevelModddelElements.forModddelTemplate(
          baseClassModddelTemplate: this)
      : null;
}

class Iterable2EntityBaseClassModddelTemplate extends BaseClassModddelTemplate<
    Iterable2EntitySSealedInfo, Iterable2EntityModddelInfo> {
  Iterable2EntityBaseClassModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
  });

  @override
  TopLevelModddelElements? get topLevelModddelElements => isTopLevelMixin
      ? Iterable2EntityTopLevelModddelElements.forModddelTemplate(
          baseClassModddelTemplate: this)
      : null;
}
