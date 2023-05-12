import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';

import 'package:modddels/src/core/utils.dart';

/// Identifiers that are related to a class which can either be a modddel or an
/// annotated super-sealed class, and that differ depending on which one it is.
///
abstract class ClassIdentifiers {
  ClassIdentifiers(this._generalIdentifiers);

  final GeneralIdentifiers _generalIdentifiers;

  /// The name of the class. The class can either be a modddel or an annotated
  /// super-sealed class.
  ///
  /// Example : 'Username' - 'Weather'
  ///
  String get className;

  /// The name of the variable representing the class.
  ///
  /// Example : 'username' - 'weather'
  ///
  String get variableName => className.uncapitalize();

  /// The name of the base class.
  ///
  String get baseClassName;

  /// The name of the "valid" union-case / ssealed class.
  ///
  /// Example : 'ValidUsername' - 'ValidWeather'
  ///
  String get validClassName => 'Valid$className';

  /// The name of the variable representing the "valid" union-case / ssealed
  /// class.
  ///
  /// Example : 'validUsername' - 'validWeather'
  ///
  String get validVariableName => validClassName.uncapitalize();

  /// The parameter that represents the "valid" union-case / "valid" ssealed
  /// class.
  ///
  /// Example : 'ValidUsername validUsername'
  ///
  ExpandedParameter get validParameter => ExpandedParameter.empty(
        name: validVariableName,
        type: validClassName,
      );

  /// The name of the "invalid" union-case / ssealed class.
  ///
  /// Example : 'InvalidUsername' - 'InvalidWeather'
  ///
  String get invalidClassName => 'Invalid$className';

  /// The name of the variable representing the "invalid" union-case / ssealed
  /// class.
  ///
  /// Example : 'invalidUsername' - 'invalidWeather'
  ///
  String get invalidVariableName => invalidClassName.uncapitalize();

  /// The parameter that represents the "invalid" union-case / ssealed class.
  ///
  /// Example : 'InvalidUsername invalidUsername'
  ///
  ExpandedParameter get invalidParameter => ExpandedParameter.empty(
        name: invalidVariableName,
        type: invalidClassName,
      );

  /// The name of the ModddelParams of the class.
  ///
  String get modddelParamsClassName;

  /// Returns the name of the "invalid-step" union-case / ssealed class matching
  /// the [validationStep].
  ///
  /// Example : 'InvalidUsernameForm'
  ///
  String getInvalidStepClassName(ValidationStepInfo validationStep) =>
      'Invalid$className${validationStep.name}';

  /// Returns the name of the variable that represents the "invalid-step"
  /// union-case / ssealed class matching the [validationStep].
  ///
  /// Example : 'invalidUsernameForm'
  ///
  String getInvalidStepVariableName(ValidationStepInfo validationStep) =>
      getInvalidStepClassName(validationStep).uncapitalize();

  /// Returns the parameter that represents the "invalid-step" union-case /
  /// ssealed class matching the [validationStep].
  ///
  /// Example : 'InvalidUsernameForm invalidUsernameForm'
  ///
  ExpandedParameter getInvalidStepParameter(
          ValidationStepInfo validationStep) =>
      ExpandedParameter.empty(
        name: getInvalidStepVariableName(validationStep),
        type: getInvalidStepClassName(validationStep),
      );

  /// Returns the name of the subholder class for the [validation].
  ///
  /// Example : '_ValidateUsernameCharacters'
  ///
  String getSubHolderClassName(ValidationInfo validation) =>
      '_Validate$className${validation.validationName.capitalize()}';
}

/// Identifiers that are related to a modddel.
///
class ModddelClassIdentifiers extends ClassIdentifiers {
  ModddelClassIdentifiers({
    required GeneralIdentifiers generalIdentifiers,
    required this.className,
    required this.isCaseModddel,
  }) : super(generalIdentifiers);

  /// The name of the modddel.
  ///
  /// Example : 'Username'
  ///
  @override
  final String className;

  /// Whether the modddel is a case-modddel.
  ///
  final bool isCaseModddel;

  /// The name of the base modddel class.
  ///
  /// - If the modddel is solo : It's the name of the top-level mixin.
  /// - If the modddel is a case-modddel : It's the name of the modddel.
  ///
  @override
  String get baseClassName => isCaseModddel
      ? className
      : _generalIdentifiers.topLevelMixinIdentifiers.topLevelMixinName;

  /// The name of the "dependencies" class of the modddel.
  ///
  /// Example : '_$UsernameDependencies'
  ///
  String get dependenciesClassName => '_\$${className}Dependencies';

  /// The name of the variable representing the "dependencies" class of the
  /// modddel.
  ///
  /// Example : '$usernameDependencies'
  ///
  String get dependenciesVariableName => '\$${variableName}Dependencies';

  /// The parameter that represents the "dependencies" class of the modddel.
  ///
  /// Example : '_$UsernameDependencies $usernameDependencies'
  ///
  ExpandedParameter get dependenciesParameter => ExpandedParameter.empty(
        name: dependenciesVariableName,
        type: dependenciesClassName,
      );

  String get createMethodName =>
      isCaseModddel ? '_create$className' : '_create';

  @override
  String get modddelParamsClassName =>
      isCaseModddel ? '_${className}Params' : '${className}Params';

  /// Returns the name of the holder class of the [validationStep].
  ///
  /// Example : '_$UsernameFormHolder'
  ///
  String getHolderClassName(ValidationStepInfo validationStep) =>
      '_\$$className${validationStep.name}Holder';

  /// Returns the name of the variable representing the holder class of the
  /// [validationStep].
  ///
  /// Example : '$usernameFormHolder'
  ///
  String getHolderVariableName(ValidationStepInfo validationStep) =>
      '\$$variableName${validationStep.name}Holder';

  /// Returns the parameter that represents the holder class of the
  /// [validationStep].
  ///
  /// Example : '_$UsernameFormHolder $usernameFormHolder'
  ///
  ExpandedParameter getHolderParameter(ValidationStepInfo validationStep) =>
      ExpandedParameter.empty(
        name: getHolderVariableName(validationStep),
        type: getHolderClassName(validationStep),
      );

  /// Returns the name of the "verify" method for the [validationStep].
  ///
  /// Example : '_verifyFormStep'
  ///
  /// If the annotated class is super-sealed, the "verify" method should have
  /// a distinct name per case-modddel, so the name of the case-modddel is
  /// included.
  ///
  /// Example : '_verifySunnyValueStep'
  ///
  String getVerifyMethodName(ValidationStepInfo validationStep) => isCaseModddel
      ? '_verify$className${validationStep.name}Step'
      : '_verify${validationStep.name}Step';

  /// Returns the name of the "validateContent" method of the
  /// [contentValidation].
  ///
  /// Example : 'validateContent'
  ///
  /// If the annotated class is super-sealed, the "validateContent" method
  /// should have a distinct name per case-modddel, so the name of the
  /// case-modddel is included.
  ///
  /// Example : 'validateSunnyContent'
  ///
  /// Throws an [ArgumentError] if [contentValidation] is not the
  /// contentValidation. For other validations, use instead
  /// [GeneralIdentifiers.getValidateMethodName].
  ///
  String getValidateContentMethodName(ValidationInfo contentValidation) {
    if (!contentValidation.isContentValidation) {
      throw ArgumentError(
          'Must be the contentValidation. Use instead `getValidateMethodName`.',
          'validation');
    }

    return isCaseModddel
        ? 'validate$className${contentValidation.validationName.capitalize()}'
        : 'validate${contentValidation.validationName.capitalize()}';
  }
}

/// Identifiers that are related to an annotated super-sealed class.
///
class SSealedClassIdentifiers extends ClassIdentifiers {
  SSealedClassIdentifiers({
    required GeneralIdentifiers generalIdentifiers,
  }) : super(generalIdentifiers);

  /// The name of the annotated super-sealed class.
  ///
  /// Example : 'Weather'
  ///
  @override
  String get className => _generalIdentifiers.annotatedClassName;

  @override
  String get baseClassName =>
      _generalIdentifiers.topLevelMixinIdentifiers.topLevelMixinName;

  @override
  String get modddelParamsClassName => '${className}Params';
}
