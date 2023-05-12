import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_info.dart';
import 'package:modddels/src/core/info/validation_info/validation_step_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/declaration_template.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/generation_templates/abstract/modddel_generation_template.dart';

/// The template for the "holder" class of the [validationStep].
///
/// It's a class that holds the fields of the [validationStep]. These fields
/// are simply the member parameters with all transformations of the previous
/// validationSteps applied.
///
abstract class HolderModddelTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> extends ModddelGenerationTemplate<SI, MI> {
  HolderModddelTemplate({
    required this.modddelInfo,
    required this.sSealedInfo,
    required this.validationStep,
  });

  @override
  final MI modddelInfo;

  @override
  final SI? sSealedInfo;

  final ValidationStepInfo validationStep;

  @override
  String toString() {
    return '''
    $classDeclaration {
      $constructor

      $membersProperties

      $conversionMethods
    }
    ''';
  }

  /// The declaration of the holder class.
  ///
  /// For example : `class _$PersonMidHolder` - `class _$RainyValueHolder`
  ///
  String get classDeclaration {
    return ClassDeclarationTemplate(
            className: _holderClassName, isAbstract: false)
        .toString();
  }

  /// The constructor of the holder class.
  ///
  String get constructor {
    final constructorParams = validationStep.parametersTemplate
        .asNamed(optionality: Optionality.makeAllRequired)
        .asLocal();

    return '''
    $_holderClassName($constructorParams);
    ''';
  }

  /// The properties for the member parameters.
  ///
  String get membersProperties {
    final properties = validationStep.parametersTemplate.allParameters
        .asPropreties()
        .map((property) => property.copyWith(doc: ''))
        .toList();

    return properties.join('\n');
  }

  /// The methods that convert the holder to each validation's subholder.
  ///
  /// - If the validation doesn't have any `NonNullParamTransformation`s : The
  ///   method is a "toSubholder" method.
  /// - If the validation has at least one `NonNullParamTransformation`, the
  ///   method is a "verifyNullables" method.
  ///
  String get conversionMethods {
    return validationStep.validations
        .where((validation) => !validation.isContentValidation)
        .map((validation) => validation.hasNullFailures
            ? _makeVerifyNullablesMethod(validation)
            : _makeToSubHolderMethod(validation))
        .join('\n');
  }

  /// True if the "verifyNullables" methods should receive an "instance"
  /// argument.
  ///
  bool get _verifyNullablesHasInstanceArg;

  /// The name of the holder class.
  ///
  String get _holderClassName =>
      modddelClassIdentifiers.getHolderClassName(validationStep);

  /// Generates the "toSubHolder" method of the given [validation].
  ///
  String _makeToSubHolderMethod(ValidationInfo validation) {
    final subHolderClassName =
        modddelClassIdentifiers.getSubHolderClassName(validation);

    final toSubHolderMethodName = generalIdentifiers.holderIdentifiers
        .getToSubHolderMethodName(validation);

    final parameters = ParametersTemplate(
      requiredPositionalParameters: [
        if (hasDependencies) modddelClassIdentifiers.dependenciesParameter
      ],
    );

    final arguments = ArgumentsTemplate.fromParametersTemplate(
            validationStep.parametersTemplate)
        .asNamed();

    return '''
    $subHolderClassName $toSubHolderMethodName($parameters) {
      return $subHolderClassName($arguments)$_initDependencies;
    }
    ''';
  }

  /// Generates the "verifyNullables" method of the given [validation].
  ///
  String _makeVerifyNullablesMethod(ValidationInfo validation);

  /// Returns the prototype of the "verifyNullables" method of the given
  /// [validation].
  ///
  /// If [_verifyNullablesHasInstanceArg] is true, the prototype has an extra
  /// "instance" parameter.
  ///
  String _getVerifyNullablesMethodPrototype(ValidationInfo validation) {
    final subHolderClassName =
        modddelClassIdentifiers.getSubHolderClassName(validation);

    final returnType = 'Either<${validation.failureType}, $subHolderClassName>';

    final verifyNullablesMethodName = generalIdentifiers.holderIdentifiers
        .getVerifyNullablesMethodName(validation);

    final parameters = ParametersTemplate(
      requiredPositionalParameters: [
        if (_verifyNullablesHasInstanceArg)
          generalIdentifiers.topLevelMixinIdentifiers.instanceParameter,
        if (hasDependencies) modddelClassIdentifiers.dependenciesParameter,
      ],
    );

    return '$returnType $verifyNullablesMethodName($parameters)';
  }

  String get _initDependencies {
    if (!hasDependencies) {
      return '';
    }

    final initMethodName =
        generalIdentifiers.topLevelMixinIdentifiers.initMethodName;

    final dependenciesVariableName =
        modddelClassIdentifiers.dependenciesVariableName;

    return '..$initMethodName($dependenciesVariableName)';
  }
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

class NonIterablesHolderModddelTemplate
    extends HolderModddelTemplate<SSealedInfo, ModddelInfo> {
  NonIterablesHolderModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.validationStep,
  });

  @override
  final bool _verifyNullablesHasInstanceArg = false;

  @override
  String _makeVerifyNullablesMethod(ValidationInfo validation) {
    assert(validation.hasNullFailures);

    String getReturnLeft() {
      return validation.nullFailureParameters.map((nullFailureParam) {
        final paramName = nullFailureParam.name;
        final nullFailure = nullFailureParam.nullFailures
            .where((nf) => nf.validationName == validation.validationName)
            .single;

        return '''
        final $paramName = this.$paramName;
        if ($paramName == null) {
          return left(${nullFailure.failure});
        }
        ''';
      }).join('\n');
    }

    String getReturnRight() {
      final subHolderClassName =
          modddelClassIdentifiers.getSubHolderClassName(validation);

      final rightArguments = ArgumentsTemplate.fromParametersTemplate(
              validationStep.parametersTemplate)
          .asNamed();

      return 'return right($subHolderClassName($rightArguments)$_initDependencies);';
    }

    return '''
    ${_getVerifyNullablesMethodPrototype(validation)} {
      ${getReturnLeft()}

      ${getReturnRight()}
    }
    ''';
  }
}

abstract class IterablesEntityHolderModddelTemplate<
        SI extends IterablesEntitySSealedInfo<MI>,
        MI extends IterablesEntityModddelInfo>
    extends HolderModddelTemplate<SI, MI> {
  IterablesEntityHolderModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.validationStep,
  });

  @override
  final bool _verifyNullablesHasInstanceArg = true;

  /// Returns the "right" return statement for the "verifyNullables" method of
  /// the given [validation]. It is the same in both IterableEntity and
  /// Iterable2Entity.
  ///
  String _getVerifyNullablesMethodReturnRight(ValidationInfo validation) {
    final instanceVariableName =
        generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

    final iterableParameter =
        modddelInfo.modddelParametersInfo.iterableParameter;

    final subHolderClassName =
        modddelClassIdentifiers.getSubHolderClassName(validation);

    final castCollectionMethodName =
        GlobalIdentifiers.iterablesIdentifiers.castCollectionMethodName;

    final rightArguments = ArgumentsTemplate(namedArguments: [
      iterableParameter.toArgument(
        argument:
            '$instanceVariableName.$castCollectionMethodName(${iterableParameter.name})',
      ),
    ]);

    return 'return right($subHolderClassName($rightArguments)$_initDependencies);';
  }
}

class IterableHolderModddelTemplate
    extends IterablesEntityHolderModddelTemplate<IterableEntitySSealedInfo,
        IterableEntityModddelInfo> {
  IterableHolderModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.validationStep,
  });

  @override
  String _makeVerifyNullablesMethod(ValidationInfo validation) {
    assert(validation.hasNullFailures);

    String getReturnLeft() {
      final instanceVariableName =
          generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

      final iterableParameter =
          modddelInfo.modddelParametersInfo.iterableParameter;

      // An IterableEntity can only have a single member parameter, with a single
      // nullFailure annotation.
      final nullFailure = iterableParameter.nullFailures
          .where((nf) => nf.validationName == validation.validationName)
          .single;

      final collectionToIterableMethodName =
          GlobalIdentifiers.iterablesIdentifiers.collectionToIterableMethodName;

      return '''
      if ($instanceVariableName
          .$collectionToIterableMethodName(${iterableParameter.name})
          .contains(null)) {
        return left(${nullFailure.failure});
      }
      ''';
    }

    return '''
    ${_getVerifyNullablesMethodPrototype(validation)} {
      ${getReturnLeft()}

      ${_getVerifyNullablesMethodReturnRight(validation)}
    }
    ''';
  }
}

class Iterable2HolderModddelTemplate
    extends IterablesEntityHolderModddelTemplate<Iterable2EntitySSealedInfo,
        Iterable2EntityModddelInfo> {
  Iterable2HolderModddelTemplate({
    required super.modddelInfo,
    required super.sSealedInfo,
    required super.validationStep,
  });

  @override
  String _makeVerifyNullablesMethod(ValidationInfo validation) {
    assert(validation.hasNullFailures);

    String getReturnLeft() {
      final instanceVariableName =
          generalIdentifiers.topLevelMixinIdentifiers.instanceVariableName;

      final iterableParameter =
          modddelInfo.modddelParametersInfo.iterableParameter;

      // An Iterable2Entity can only have a single member parameter, with at most
      // two `@NullFailure` annotations.
      final nullFailures = iterableParameter.nullFailures
          .where((nf) => nf.validationName == validation.validationName)
          .toList();

      final collectionToIterableMethodName =
          GlobalIdentifiers.iterablesIdentifiers.collectionToIterableMethodName;

      return nullFailures.map((nullFailure) {
        final tupleValue = nullFailure.maskNb == 1 ? 'first' : 'second';
        return '''
        if ($instanceVariableName
            .$collectionToIterableMethodName(${iterableParameter.name})
            .$tupleValue
            .contains(null)) {
          return left(${nullFailure.failure});
        }
        ''';
      }).join('\n');
    }

    return '''
    ${_getVerifyNullablesMethodPrototype(validation)} {
      ${getReturnLeft()}

      ${_getVerifyNullablesMethodReturnRight(validation)}
    }
    ''';
  }
}
