import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/parameter_type_info/parameter_type_info_maker.dart';
import 'package:modddels/src/core/info/parameters_info/modddel/_modddel_parameters_info_resolver.dart';
import 'package:modddels/src/core/info/parameters_info/_unresolved_parameters_info_exception.dart';
import 'package:modddels/src/core/templates/constructor_details.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:source_gen/source_gen.dart';

typedef ModddelParametersInfoConstructor<MPI extends ModddelParametersInfo>
    = MPI Function({
  required ConstructorDetails constructorDetails,
  required ParameterTypeInfoMaker parameterTypeInfoMaker,
  required GeneralIdentifiers generalIdentifiers,
  required ModddelClassIdentifiers modddelClassIdentifiers,
  required SSealedClassIdentifiers? sSealedClassIdentifiers,
});

/// Holds information about the parameters of a modddel.
///
/// NB : All subclasses should have a factory called "fromConstructorDetails"
/// and which tear-off should have the same type as
/// [ModddelParametersInfoConstructor].
///
abstract class ModddelParametersInfo {
  /// The parameters template of the factory constructor of the modddel, without
  /// any changes.
  ///
  /// This is the same as [ModddelClassInfo.constructor]'s parametersTemplate.
  ///
  ParametersTemplate get constructorParametersTemplate;

  /// Contains the dependency parameters.
  ///
  ParametersTemplate get dependencyParametersTemplate;

  /// Contains the member parameters.
  ///
  ParametersTemplate get memberParametersTemplate;

  /// Whether the modddel has any dependency parameters.
  ///
  bool get hasDependencyParameters =>
      dependencyParametersTemplate.allParameters.isNotEmpty;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ ValueObjects ------------------------------ */

/// The [ModddelParametersInfo] of a SingleValueObject.
///
/// A SingleValueObject has a single member parameter that we call the
/// [valueParameter].
///
class SingleValueObjectParametersInfo extends ModddelParametersInfo {
  SingleValueObjectParametersInfo._({
    required this.constructorParametersTemplate,
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
    required this.valueParameter,
  });

  factory SingleValueObjectParametersInfo.fromConstructorDetails({
    required ConstructorDetails constructorDetails,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    final SingleValueObjectParametersResolver resolver;

    try {
      resolver = SingleValueObjectParametersResolver.resolve(
        constructorParametersTemplate: constructorDetails.parametersTemplate,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
        generalIdentifiers: generalIdentifiers,
        modddelClassIdentifiers: modddelClassIdentifiers,
        sSealedClassIdentifiers: sSealedClassIdentifiers,
      );
    } on UnresolvedParametersInfoException catch (exception) {
      throw _getInvalidGenerationSourceError(
        exception,
        factoryConstructor: constructorDetails.constructorElement,
      );
    }

    return SingleValueObjectParametersInfo._(
      constructorParametersTemplate: constructorDetails.parametersTemplate,
      dependencyParametersTemplate: resolver.dependencyParametersTemplate,
      memberParametersTemplate: resolver.memberParametersTemplate,
      valueParameter: resolver.valueParameter,
    );
  }

  @override
  final ParametersTemplate constructorParametersTemplate;

  @override
  final ParametersTemplate dependencyParametersTemplate;

  /// Contains a single member parameter : the [valueParameter].
  ///
  @override
  final ParametersTemplate memberParametersTemplate;

  /// The single member parameter of the SingleValueObject.
  ///
  final Parameter valueParameter;
}

/// The [ModddelParametersInfo] of a MultiValueObject.
///
class MultiValueObjectParametersInfo extends ModddelParametersInfo {
  MultiValueObjectParametersInfo._({
    required this.constructorParametersTemplate,
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
  });

  factory MultiValueObjectParametersInfo.fromConstructorDetails({
    required ConstructorDetails constructorDetails,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    final MultiValueObjectParametersResolver resolver;

    try {
      resolver = MultiValueObjectParametersResolver.resolve(
        constructorParametersTemplate: constructorDetails.parametersTemplate,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
        generalIdentifiers: generalIdentifiers,
        modddelClassIdentifiers: modddelClassIdentifiers,
        sSealedClassIdentifiers: sSealedClassIdentifiers,
      );
    } on UnresolvedParametersInfoException catch (exception) {
      throw _getInvalidGenerationSourceError(
        exception,
        factoryConstructor: constructorDetails.constructorElement,
      );
    }

    return MultiValueObjectParametersInfo._(
      constructorParametersTemplate: constructorDetails.parametersTemplate,
      dependencyParametersTemplate: resolver.dependencyParametersTemplate,
      memberParametersTemplate: resolver.memberParametersTemplate,
    );
  }

  @override
  final ParametersTemplate constructorParametersTemplate;

  @override
  final ParametersTemplate dependencyParametersTemplate;

  @override
  final ParametersTemplate memberParametersTemplate;
}

/* -------------------------------- Entities -------------------------------- */

/// The [ModddelParametersInfo] of a SimpleEntity.
///
class SimpleEntityParametersInfo extends ModddelParametersInfo {
  SimpleEntityParametersInfo._({
    required this.constructorParametersTemplate,
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
  });

  factory SimpleEntityParametersInfo.fromConstructorDetails({
    required ConstructorDetails constructorDetails,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    final SimpleEntityParametersResolver resolver;

    try {
      resolver = SimpleEntityParametersResolver.resolve(
        constructorParametersTemplate: constructorDetails.parametersTemplate,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
        generalIdentifiers: generalIdentifiers,
        modddelClassIdentifiers: modddelClassIdentifiers,
        sSealedClassIdentifiers: sSealedClassIdentifiers,
      );
    } on UnresolvedParametersInfoException catch (exception) {
      throw _getInvalidGenerationSourceError(
        exception,
        factoryConstructor: constructorDetails.constructorElement,
      );
    }

    return SimpleEntityParametersInfo._(
      constructorParametersTemplate: constructorDetails.parametersTemplate,
      dependencyParametersTemplate: resolver.dependencyParametersTemplate,
      memberParametersTemplate: resolver.memberParametersTemplate,
    );
  }

  @override
  final ParametersTemplate constructorParametersTemplate;

  @override
  final ParametersTemplate dependencyParametersTemplate;

  @override
  final ParametersTemplate memberParametersTemplate;
}

/// The [ModddelParametersInfo] of an IterableEntity or Iterable2Entity.
///
/// An IterableEntity/Iterable2Entity has a single member parameter that we
/// call the [iterableParameter].
///
class IterablesEntityParametersInfo extends ModddelParametersInfo {
  IterablesEntityParametersInfo._({
    required this.constructorParametersTemplate,
    required this.dependencyParametersTemplate,
    required this.memberParametersTemplate,
    required this.iterableParameter,
  });

  factory IterablesEntityParametersInfo.fromConstructorDetails({
    required ConstructorDetails constructorDetails,
    required ParameterTypeInfoMaker parameterTypeInfoMaker,
    required GeneralIdentifiers generalIdentifiers,
    required ModddelClassIdentifiers modddelClassIdentifiers,
    required SSealedClassIdentifiers? sSealedClassIdentifiers,
  }) {
    final IterablesEntityParametersResolver resolver;

    try {
      resolver = IterablesEntityParametersResolver.resolve(
        constructorParametersTemplate: constructorDetails.parametersTemplate,
        parameterTypeInfoMaker: parameterTypeInfoMaker,
        generalIdentifiers: generalIdentifiers,
        modddelClassIdentifiers: modddelClassIdentifiers,
        sSealedClassIdentifiers: sSealedClassIdentifiers,
      );
    } on UnresolvedParametersInfoException catch (exception) {
      throw _getInvalidGenerationSourceError(
        exception,
        factoryConstructor: constructorDetails.constructorElement,
      );
    }

    return IterablesEntityParametersInfo._(
      constructorParametersTemplate: constructorDetails.parametersTemplate,
      dependencyParametersTemplate: resolver.dependencyParametersTemplate,
      memberParametersTemplate: resolver.memberParametersTemplate,
      iterableParameter: resolver.iterableParameter,
    );
  }

  @override
  final ParametersTemplate constructorParametersTemplate;

  @override
  final ParametersTemplate dependencyParametersTemplate;

  /// Contains a single member parameter : the [iterableParameter].
  ///
  @override
  final ParametersTemplate memberParametersTemplate;

  /// The single member parameter of the IterableEntity/Iterable2Entity.
  ///
  final Parameter iterableParameter;
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

/// Converts the [UnresolvedParametersInfoException] to an
/// [InvalidGenerationSourceError].
InvalidGenerationSourceError _getInvalidGenerationSourceError(
  UnresolvedParametersInfoException exception, {
  required ConstructorElement factoryConstructor,
}) {
  final Element? failingParameter = exception.failedParameter?.parameterElement;
  return InvalidGenerationSourceError(
    exception.toString(),
    element: failingParameter ?? factoryConstructor,
  );
}
