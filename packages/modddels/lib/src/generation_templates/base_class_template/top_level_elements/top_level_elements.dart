import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/generation_templates/base_class_template/modddel/base_class_modddel_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/ssealed/base_class_ssealed_template.dart';
import 'package:fpdart/fpdart.dart';

/// This class holds elements that are part of the top-level mixin, and that can
/// be used in both [BaseClassModddelTemplate] and [BaseClassSSealedTemplate].
///
class TopLevelElements {
  /// Creates the [TopLevelElements] used by [baseClassModddelTemplate].
  ///
  TopLevelElements.forModddelTemplate({
    required BaseClassModddelTemplate baseClassModddelTemplate,
  })  : assert(!baseClassModddelTemplate.isCaseModddel,
            'The TopLevelElements can only be used in a top-level mixin.'),
        classInfo = baseClassModddelTemplate.modddelInfo.modddelClassInfo,
        validationSteps = baseClassModddelTemplate
            .modddelInfo.modddelValidationInfo.allValidationSteps;

  /// Creates the [TopLevelElements] used by [baseClassSSealedTemplate].
  ///
  TopLevelElements.forSSealedTemplate({
    required BaseClassSSealedTemplate baseClassSSealedTemplate,
  })  : classInfo = baseClassSSealedTemplate.sSealedInfo.sSealedClassInfo,
        validationSteps = baseClassSSealedTemplate
            .sSealedInfo.sSealedValidationInfo.allValidationSteps;

  final ClassInfo classInfo;
  final List<ValidationStepInfo> validationSteps;

  /// Returns the "instance" method, a static method that creates a private
  /// instance of the annotated class.
  ///
  String get instanceMethod {
    final className = classInfo.classIdentifiers.className;

    final instanceMethodName = classInfo
        .generalIdentifiers.topLevelMixinIdentifiers.instanceMethodName;

    return 'static $className $instanceMethodName() => $className._();';
  }

  /// Returns the "validate" methods, which are abstract methods that must
  /// be implemented by the developer in the annotated class.
  ///
  /// NB : This doesn't include the "contentValidation" method.
  ///
  String get validateMethods {
    final allValidationsExceptContentValidation = validationSteps
        .map((vStep) => vStep.validations)
        .expand(id)
        .where((validation) => !validation.isContentValidation)
        .toList();

    return allValidationsExceptContentValidation
        .map(_makeValidateMethod)
        .join('\n');
  }

  /// Returns the "props" getter of the Equatable package. Here it throws an
  /// unimplemented error, but it is then properly overridden in all concrete
  /// subclasses of the annotated class.
  ///
  String get propsGetter {
    return Getter(
      name: GlobalIdentifiers.propsGetterName,
      type: 'List<Object?>',
      implementation: 'throw ${GlobalIdentifiers.unimplementedErrorVarName}',
    ).toString();
  }

  String _makeValidateMethod(ValidationInfo validation) {
    final failureType = validation.failureType;

    final validateMethodName = classInfo
        .generalIdentifiers.topLevelMixinIdentifiers
        .getValidateMethodName(validation);

    final subHolderParameter = ExpandedParameter.empty(
      name: classInfo.classIdentifiers.variableName,
      type: classInfo.classIdentifiers.getSubHolderClassName(validation),
    );

    return 'Option<$failureType> $validateMethodName($subHolderParameter);';
  }
}
