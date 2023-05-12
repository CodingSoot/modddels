import 'package:modddels/src/core/identifiers/global_identifiers.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_prototypes.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

enum MethodBodyKind {
  abstract,
  withImplementation,
  throwUnimplementedError,
}

/// A pattern matching method.
///
/// The current implementation of pattern matching methods is that all methods
/// except the [MaybeMapMethod] are implemented when they are declared (in the
/// abstract level). These methods are called [StandardPatternMatchingMethod]s.
/// Their implementation is made by calling the [MaybeMapMethod], which is only
/// implemented in the concrete union-cases.
///
abstract class PatternMatchingMethod {
  PatternMatchingPrototype get prototype;

  MethodBodyKind get bodyKind;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

abstract class StandardPatternMatchingMethod extends PatternMatchingMethod {
  /// The name of the [MaybeMapMethod] that should be called in this method's
  /// implementation.
  ///
  String get maybeMapMethodName;

  /// The arguments that should be passed to the [MaybeMapMethod] in this
  /// method's implementation.
  ///
  ArgumentsTemplate get maybeMapMethodArguments;

  @override
  String toString() {
    switch (bodyKind) {
      case MethodBodyKind.abstract:
        return '$prototype;';
      case MethodBodyKind.throwUnimplementedError:
        return '$prototype => throw ${GlobalIdentifiers.unimplementedErrorVarName};';
      case MethodBodyKind.withImplementation:
        return '''
        $prototype {
          return $maybeMapMethodName(
            $maybeMapMethodArguments
          );
        }
        ''';
    }
  }
}

abstract class MaybeMapMethod extends PatternMatchingMethod {
  /// The name of the callback parameter that represents the concrete union-case
  /// where the method is being implemented.
  ///
  /// Should be provided if [bodyKind] equals
  /// [MethodBodyKind.withImplementation].
  ///
  String? get unionCaseParamName;

  @override
  String toString() {
    switch (bodyKind) {
      case MethodBodyKind.abstract:
        return '$prototype;';
      case MethodBodyKind.throwUnimplementedError:
        return '$prototype => throw ${GlobalIdentifiers.unimplementedErrorVarName};';
      case MethodBodyKind.withImplementation:
        if (unionCaseParamName == null) {
          throw ArgumentError.value(unionCaseParamName, 'unionCaseParamName',
              'Should not be null if the method body is to be implemented.');
        }

        return '''
        $prototype {
          return $unionCaseParamName != null ? $unionCaseParamName(this) : orElse();
        }
        ''';
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

/// An arguments template where each [prototype]'s callback parameter is
/// assigned to itself, with an extra "orElse" parameter that throws an
/// [UnreachableError].
///
/// Example :
///
/// ```text
/// case1: case1,
/// case2: case2,
/// orElse: () => throw UnreachableError(),
/// ```
///
ArgumentsTemplate orElseThrowArgumentsTemplate(
    PatternMatchingPrototype prototype) {
  final orElseArgument = orElseNamedCallbackParameter()
      .toExpandedParameter()
      .toArgument(argument: '() => throw UnreachableError()');

  return ArgumentsTemplate.fromParametersTemplate(prototype.parametersTemplate)
      .appendNamedArgument(orElseArgument);
}

/// An arguments template where each [prototype]'s callback parameter is
/// assigned to itself, with an extra "orElse" parameter that returns null.
///
/// Example :
///
/// ```text
/// case1: case1,
/// case2: case2,
/// orElse: () => null,
/// ```
///
ArgumentsTemplate orElseReturnNullArgumentsTemplate(
    PatternMatchingPrototype prototype) {
  final orElseArgument = orElseNamedCallbackParameter()
      .toExpandedParameter()
      .toArgument(argument: '() => null');

  return ArgumentsTemplate.fromParametersTemplate(prototype.parametersTemplate)
      .appendNamedArgument(orElseArgument);
}
