import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/generators/annotated_class_template/annotated_solo_template.dart';
import 'package:modddels/src/generators/annotated_class_template/annotated_ssealed_template.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// The template for the "Tester" class.
///
/// It's a class that allows the developer to easily create tests for a modddel.
///
class TesterTemplate {
  TesterTemplate.forAnnotatedSSealedTemplate({
    required AnnotatedSSealedTemplate annotatedSSealedTemplate,
  })  : classInfo = annotatedSSealedTemplate.sSealedInfo.sSealedClassInfo,
        validationSteps = annotatedSSealedTemplate
            .sSealedInfo.sSealedValidationInfo.allValidationSteps,
        maxTestInfoLength = annotatedSSealedTemplate.maxTestInfoLength;

  TesterTemplate.forAnnotatedSoloTemplate({
    required AnnotatedSoloTemplate annotatedSoloTemplate,
  })  : classInfo = annotatedSoloTemplate.modddelInfo.modddelClassInfo,
        validationSteps = annotatedSoloTemplate
            .modddelInfo.modddelValidationInfo.allValidationSteps,
        maxTestInfoLength = annotatedSoloTemplate.maxTestInfoLength;

  final ClassInfo classInfo;

  /// See [Modddel.maxTestInfoLength].
  final int maxTestInfoLength;

  final List<ValidationStepInfo> validationSteps;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $isInvalidTestsGetters
    }
    ''';
  }

  GeneralIdentifiers get generalIdentifiers => classInfo.generalIdentifiers;

  ClassIdentifiers get classIdentifiers => classInfo.classIdentifiers;

  /// The declaration of the "Tester" class.
  ///
  /// For example : `class TestWeather extends BaseTester<Weather,
  /// InvalidWeather, ValidWeather>`
  ///
  String get classDeclaration {
    final baseTesterClassName =
        GlobalIdentifiers.baseTesterIdentifiers.baseTesterClassName;

    final className = classIdentifiers.className;
    final invalidClassName = classIdentifiers.invalidClassName;
    final validClassName = classIdentifiers.validClassName;

    final declaration = ClassDeclarationTemplate(
      className: _testerClassName,
      isAbstract: false,
      extendsClasses: [
        '$baseTesterClassName<$className, $invalidClassName, $validClassName>'
      ],
    );

    return declaration.toString();
  }

  /// The constructor of the "Tester" class.
  ///
  String get constructor {
    final maxTestInfoLengthParameter = GlobalIdentifiers
        .baseTesterIdentifiers.maxTestInfoLengthParameter
        .copyWith(defaultValue: '$maxTestInfoLength');

    final constructorParams = ParametersTemplate(
      namedParameters: [maxTestInfoLengthParameter],
    ).asExpanded(showDefaultValue: true);

    final superArguments =
        ArgumentsTemplate.fromParametersTemplate(constructorParams);

    return 'const $_testerClassName($constructorParams) : super($superArguments);';
  }

  /// The "isInvalid" getters.
  ///
  /// An "isInvalid" getter is generated for each validationStep. Each one
  /// returns a matching "InvalidStepTest".
  ///
  String get isInvalidTestsGetters {
    return validationSteps.map(_makeInvalidTestGetter).join('\n');
  }

  /// The name of the "Tester" class.
  ///
  String get _testerClassName =>
      generalIdentifiers.testerIdentifiers.testerClassName;

  String _makeInvalidTestGetter(ValidationStepInfo validationStep) {
    final isInvalidGetterName = generalIdentifiers.testerIdentifiers
        .getIsInvalidGetterName(validationStep);

    final invalidStepTestClassName = generalIdentifiers
        .invalidStepTestClassIdentifiers
        .getInvalidStepTestClassName(validationStep);

    final getter = Getter(
      name: isInvalidGetterName,
      type: invalidStepTestClassName,
      implementation: '$invalidStepTestClassName(this)',
    );

    return getter.toString();
  }
}
