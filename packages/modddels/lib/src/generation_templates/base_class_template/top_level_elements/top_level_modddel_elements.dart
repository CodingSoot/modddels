import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/utils.dart';
import 'package:collection/collection.dart';
import 'package:modddels/src/generation_templates/base_class_template/modddel/base_class_modddel_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/ssealed/base_class_ssealed_template.dart';
import 'package:modddels/src/generation_templates/base_class_template/top_level_elements/_verify_step_method.dart';
import 'package:modddels/src/generation_templates/base_class_template/top_level_elements/_create_method.dart';

/// This class holds elements that are part of the top-level mixin, and that are
/// related to a single modddel.
///
/// These elements can be used in both [BaseClassModddelTemplate] and
/// [BaseClassSSealedTemplate].
///
/// These top-level elements concern a single modddel (Ex :
/// createQcmQuestion...).
///
abstract class TopLevelModddelElements<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends ModddelGenerationTemplate<SI, MI> {
  /// Creates the [TopLevelModddelElements] of the solo modddel, used by
  /// [baseClassModddelTemplate].
  ///
  TopLevelModddelElements.forModddelTemplate({
    required BaseClassModddelTemplate<SI, MI> baseClassModddelTemplate,
  })  : assert(!baseClassModddelTemplate.isCaseModddel,
            'The TopLevelModddelElements can only be used in a top-level mixin.'),
        modddelInfo = baseClassModddelTemplate.modddelInfo,
        sSealedInfo = baseClassModddelTemplate.sSealedInfo; // equals null

  /// Creates the [TopLevelModddelElements] of the case-modddel represented by
  /// [modddelInfo], used by [baseClassSSealedTemplate].
  ///
  TopLevelModddelElements.forSSealedTemplate({
    required BaseClassSSealedTemplate<SI, MI> baseClassSSealedTemplate,
    required this.modddelInfo,
  }) : sSealedInfo = baseClassSSealedTemplate.sSealedInfo;

  @override
  final MI modddelInfo;

  @override
  final SI? sSealedInfo;

  /// Returns the validateContent method, or null if the modddel has no
  /// validateContent method.
  ///
  String? get validateContentMethod;

  /// Returns the "create" method, which is the entry point for creating an
  /// instance of the modddel. See [CreateMethod].
  ///
  String get createMethod {
    return CreateMethod(
      modddelInfo: modddelInfo,
      sSealedInfo: sSealedInfo,
      firstHolderArgumentsTemplate: _firstHolderArgumentsTemplate,
    ).toString();
  }

  /// Returns the "verifyStep" methods, which are methods that check that
  /// the validationSteps are passed. See [VerifyStepMethod].
  ///
  String get verifyStepMethods {
    final validationSteps =
        modddelInfo.modddelValidationInfo.allValidationSteps;

    return validationSteps.mapIndexed((index, validationStep) {
      final isLastVStep = index == (validationSteps.length - 1);

      return VerifyStepMethod(
        modddelInfo: modddelInfo,
        sSealedInfo: sSealedInfo,
        validationStep: validationStep,
        nextValidationStep: isLastVStep ? null : validationSteps[index + 1],
        verifyNullablesHasInstanceArg: _verifyNullablesHasInstanceArg,
        validateContentHasInstanceArg: _validateContentHasInstanceArg,
        cast: _cast,
      );
    }).join('\n');
  }

  /// True if the "verifyNullables" methods should receive an "instance"
  /// argument.
  ///
  bool get _verifyNullablesHasInstanceArg;

  /// True if the validateContent method should receive an "instance"
  /// argument.
  ///
  bool get _validateContentHasInstanceArg;

  /// The arguments of the first holder, used in the create method. See
  /// [CreateMethod.firstHolderArgumentsTemplate].
  ///
  ArgumentsTemplate get _firstHolderArgumentsTemplate;

  /// See [VerifyStepMethod.cast].
  ///
  String _cast(
    String castedArgument, {
    required Parameter fromParamType,
    required Parameter toParamType,
  });
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------- Non-Iterables modddels ------------------------- */

abstract class NonIterablesTopLevelModddelElements<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends TopLevelModddelElements<SI, MI> {
  NonIterablesTopLevelModddelElements.forModddelTemplate({
    required super.baseClassModddelTemplate,
  }) : super.forModddelTemplate();

  NonIterablesTopLevelModddelElements.forSSealedTemplate({
    required super.baseClassSSealedTemplate,
    required super.modddelInfo,
  }) : super.forSSealedTemplate();

  @override
  final _validateContentHasInstanceArg = false;

  @override
  final _verifyNullablesHasInstanceArg = false;

  @override
  String _cast(
    String castedArgument, {
    required Parameter fromParamType,
    required Parameter toParamType,
  }) {
    // Returns null if no typecast needed, otherwise returns the typecast
    // that should be appended to the argument.
    String? getTypeCast(String fromType, String toType) {
      if (fromType == toType ||
          nullableType(fromType) == toType ||
          isDynamicType(toType)) {
        return null;
      }

      if (nonNullableType(fromType) == toType) {
        return '!';
      }

      return ' as $toType';
    }

    final typeCast = getTypeCast(fromParamType.type, toParamType.type);

    return (typeCast != null) ? '$castedArgument$typeCast' : castedArgument;
  }

  @override
  ArgumentsTemplate get _firstHolderArgumentsTemplate {
    return ArgumentsTemplate.fromParametersTemplate(
            modddelInfo.modddelParametersInfo.memberParametersTemplate)
        .asNamed();
  }
}

class ValueObjectTopLevelModddelElements
    extends NonIterablesTopLevelModddelElements<ValueObjectSSealedInfo,
        ValueObjectModddelInfo> {
  ValueObjectTopLevelModddelElements.forModddelTemplate({
    required super.baseClassModddelTemplate,
  }) : super.forModddelTemplate();

  ValueObjectTopLevelModddelElements.forSSealedTemplate({
    required super.baseClassSSealedTemplate,
    required super.modddelInfo,
  }) : super.forSSealedTemplate();

  @override
  String? get validateContentMethod => null;
}

class SimpleEntityTopLevelModddelElements
    extends NonIterablesTopLevelModddelElements<SimpleEntitySSealedInfo,
        SimpleEntityModddelInfo> {
  SimpleEntityTopLevelModddelElements.forModddelTemplate({
    required super.baseClassModddelTemplate,
  }) : super.forModddelTemplate();

  SimpleEntityTopLevelModddelElements.forSSealedTemplate({
    required super.baseClassSSealedTemplate,
    required super.modddelInfo,
  }) : super.forSSealedTemplate();

  @override
  String get validateContentMethod {
    final contentFailureClassName =
        GlobalIdentifiers.failuresBaseIdentifiers.contentFailureClassName;

    final contentFailureLocalVarName =
        GlobalIdentifiers.failuresBaseIdentifiers.contentFailureLocalVarName;

    final contentValidationStep =
        modddelInfo.modddelValidationInfo.contentValidationStep;

    final contentValidation = contentValidationStep.validations
        .singleWhere((validation) => validation.isContentValidation);

    String getMethodPrototype() {
      final validateContentMethodName = modddelClassIdentifiers
          .getValidateContentMethodName(contentValidation);

      final methodParameters = ParametersTemplate(
        requiredPositionalParameters: [
          modddelClassIdentifiers.getHolderParameter(contentValidationStep)
        ],
      );

      return 'static Option<$contentFailureClassName> $validateContentMethodName($methodParameters)';
    }

    // We don't verify :
    // - The parameters that are annotated with '@validParam'
    // - The parameters which type is 'Null', because they are null and thus
    //   valid
    final parametersToVerify = contentValidationStep
        .parametersTemplate.allParameters
        .where((param) => !param.hasValidAnnotation && !isNullType(param.type))
        .toList();

    final holderVariableName =
        modddelClassIdentifiers.getHolderVariableName(contentValidationStep);

    String getInvalidVariablesDeclaration() {
      final invalidVariables = parametersToVerify.map((param) {
        final invalidVariableName = GlobalIdentifiers
            .validateContentMethodIdentifiers
            .getInvalidLocalVarName(param);

        final paramDeclaration = 'final $invalidVariableName =';

        var res = '$holderVariableName.${param.name}';

        if (param.hasInvalidAnnotation) {
          return '$paramDeclaration $res;';
        }

        if (isNullableType(param.type)) {
          res += '?';
        }

        return '$paramDeclaration $res.toEither.getLeft().toNullable();';
      }).toList();

      return invalidVariables.join('\n');
    }

    String getIfInvalidVariablesAreNull() {
      final conditions = parametersToVerify.map((param) {
        final invalidVariableName = GlobalIdentifiers
            .validateContentMethodIdentifiers
            .getInvalidLocalVarName(param);

        return '$invalidVariableName == null';
      }).join(' && ');

      return 'if($conditions)';
    }

    String getContentFailureDeclaration() {
      final modddelInvalidMemberClassName = GlobalIdentifiers
          .failuresBaseIdentifiers.modddelInvalidMemberClassName;

      final invalidMembers = parametersToVerify.map((param) {
        final paramName = param.name;
        final invalidVariableName = GlobalIdentifiers
            .validateContentMethodIdentifiers
            .getInvalidLocalVarName(param);

        final modddelInvalidMemberArgs = ArgumentsTemplate(namedArguments: [
          GlobalIdentifiers.failuresBaseIdentifiers.mimMemberParameter
              .toArgument(argument: invalidVariableName),
          GlobalIdentifiers.failuresBaseIdentifiers.mimDescriptionParameter
              .toArgument(argument: "'${paramName.escaped()}'"),
        ]);

        return '''
        if($invalidVariableName != null)
          $modddelInvalidMemberClassName($modddelInvalidMemberArgs)
        ''';
      }).join(',');

      return 'final $contentFailureLocalVarName = $contentFailureClassName([$invalidMembers]);';
    }

    return '''
    ${getMethodPrototype()} {

      ${getInvalidVariablesDeclaration()}

      ${getIfInvalidVariablesAreNull()} {
        return none();
      }

      ${getContentFailureDeclaration()}

      return some($contentFailureLocalVarName);
    }
    ''';
  }
}

/* --------------------------- Iterables modddels --------------------------- */

abstract class IterablesEntityTopLevelModddelElements<
        SI extends IterablesEntitySSealedInfo<MI>,
        MI extends IterablesEntityModddelInfo>
    extends TopLevelModddelElements<SI, MI> {
  IterablesEntityTopLevelModddelElements.forModddelTemplate({
    required super.baseClassModddelTemplate,
  }) : super.forModddelTemplate();

  IterablesEntityTopLevelModddelElements.forSSealedTemplate({
    required super.baseClassSSealedTemplate,
    required super.modddelInfo,
  }) : super.forSSealedTemplate();

  @override
  final _validateContentHasInstanceArg = true;

  @override
  final _verifyNullablesHasInstanceArg = true;

  @override
  ArgumentsTemplate get _firstHolderArgumentsTemplate {
    final instanceMethodName =
        generalIdentifiers.topLevelMixinIdentifiers.instanceMethodName;

    final primeCollectionMethodName =
        GlobalIdentifiers.iterablesIdentifiers.primeCollectionMethodName;

    final result = ArgumentsTemplate.fromParametersTemplate(
            modddelInfo.modddelParametersInfo.memberParametersTemplate)
        .asNamed()
        .asAssignedWith((parameter) =>
            '$instanceMethodName().$primeCollectionMethodName(${parameter.name})');

    return result;
  }
}

class IterableEntityTopLevelModddelElements
    extends IterablesEntityTopLevelModddelElements<IterableEntitySSealedInfo,
        IterableEntityModddelInfo> {
  IterableEntityTopLevelModddelElements.forModddelTemplate({
    required super.baseClassModddelTemplate,
  }) : super.forModddelTemplate();

  IterableEntityTopLevelModddelElements.forSSealedTemplate({
    required super.baseClassSSealedTemplate,
    required super.modddelInfo,
  }) : super.forSSealedTemplate();

  @override
  String _cast(
    String castedArgument, {
    required Parameter fromParamType,
    required Parameter toParamType,
  }) {
    final fromType =
        modddelInfo.parameterTypeInfoMaker(fromParamType).modddelType;
    final toType = modddelInfo.parameterTypeInfoMaker(toParamType).modddelType;

    if (fromType == toType) {
      return castedArgument;
    }

    final instanceVariableName =
        generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

    final castCollectionMethodName =
        GlobalIdentifiers.iterablesIdentifiers.castCollectionMethodName;

    return '$instanceVariableName.$castCollectionMethodName($castedArgument)';
  }

  @override
  String get validateContentMethod {
    final contentFailureClassName =
        GlobalIdentifiers.failuresBaseIdentifiers.contentFailureClassName;

    final contentValidationStep =
        modddelInfo.modddelValidationInfo.contentValidationStep;

    final contentValidation = contentValidationStep.validations
        .singleWhere((validation) => validation.isContentValidation);

    final validateContentMethodName =
        modddelClassIdentifiers.getValidateContentMethodName(contentValidation);

    final iterableParameter =
        modddelInfo.modddelParametersInfo.iterableParameter;

    final parameters = ParametersTemplate(
      requiredPositionalParameters: [
        modddelClassIdentifiers.getHolderParameter(contentValidationStep),
        generalIdentifiers.topLevelMixinIdentifiers.instanceParameter,
      ],
    );

    final instanceVariableName =
        generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

    final holderVariableName =
        modddelClassIdentifiers.getHolderVariableName(contentValidationStep);

    final collectionToIterableMethodName =
        GlobalIdentifiers.iterablesIdentifiers.collectionToIterableMethodName;

    final validateIterableContentMethodName = GlobalIdentifiers
        .iterablesIdentifiers.validateIterableContentMethodName;

    return '''
    static Option<$contentFailureClassName> $validateContentMethodName($parameters) {
        final list = $instanceVariableName
            .$collectionToIterableMethodName($holderVariableName.${iterableParameter.name})
            .toList();

        return $instanceVariableName.$validateIterableContentMethodName(list);
    }
    ''';
  }
}

class Iterable2EntityTopLevelModddelElements
    extends IterablesEntityTopLevelModddelElements<Iterable2EntitySSealedInfo,
        Iterable2EntityModddelInfo> {
  Iterable2EntityTopLevelModddelElements.forModddelTemplate({
    required super.baseClassModddelTemplate,
  }) : super.forModddelTemplate();

  Iterable2EntityTopLevelModddelElements.forSSealedTemplate({
    required super.baseClassSSealedTemplate,
    required super.modddelInfo,
  }) : super.forSSealedTemplate();

  @override
  String _cast(
    String castedArgument, {
    required Parameter fromParamType,
    required Parameter toParamType,
  }) {
    final fromTypeInfo = modddelInfo.parameterTypeInfoMaker(fromParamType);
    final toTypeInfo = modddelInfo.parameterTypeInfoMaker(toParamType);

    final from1 = fromTypeInfo.modddel1Type;
    final to1 = toTypeInfo.modddel1Type;
    final from2 = fromTypeInfo.modddel2Type;
    final to2 = toTypeInfo.modddel2Type;

    if (from1 == to1 && from2 == to2) {
      return castedArgument;
    }

    final instanceVariableName =
        generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

    final castCollectionMethodName =
        GlobalIdentifiers.iterablesIdentifiers.castCollectionMethodName;

    return '$instanceVariableName.$castCollectionMethodName($castedArgument)';
  }

  @override
  String get validateContentMethod {
    final contentFailureClassName =
        GlobalIdentifiers.failuresBaseIdentifiers.contentFailureClassName;

    final contentValidationStep =
        modddelInfo.modddelValidationInfo.contentValidationStep;

    final contentValidation = contentValidationStep.validations
        .singleWhere((validation) => validation.isContentValidation);

    final validateContentMethodName =
        modddelClassIdentifiers.getValidateContentMethodName(contentValidation);

    final iterableParameter =
        modddelInfo.modddelParametersInfo.iterableParameter;

    final parameters = ParametersTemplate(
      requiredPositionalParameters: [
        modddelClassIdentifiers.getHolderParameter(contentValidationStep),
        generalIdentifiers.topLevelMixinIdentifiers.instanceParameter,
      ],
    );

    final instanceVariableName =
        generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

    final holderVariableName =
        modddelClassIdentifiers.getHolderVariableName(contentValidationStep);

    final collectionToIterableMethodName =
        GlobalIdentifiers.iterablesIdentifiers.collectionToIterableMethodName;

    final validateIterableContentMethodName = GlobalIdentifiers
        .iterablesIdentifiers.validateIterableContentMethodName;

    return '''
    static Option<$contentFailureClassName> $validateContentMethodName($parameters) {
      final tuple = $instanceVariableName.$collectionToIterableMethodName($holderVariableName.${iterableParameter.name});
      return $instanceVariableName.$validateIterableContentMethodName(tuple.first.toList(), tuple.second.toList());
    }
    ''';
  }
}
