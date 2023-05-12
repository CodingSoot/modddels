import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/class_info/ssealed/ssealed_class_info.dart';
import 'package:modddels/src/core/templates/arguments/arguments_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_methods.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/modddel_pattern_matching_prototypes.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';

/// This is a mixin for "modddel pattern matching" methods.
///
/// As a reminder : "Modddel pattern matching" is the pattern matching between
/// the different case-modddels of a ssealed class.
///
mixin _ModddelPatternMatchingMixin {
  /// The [SSealedClassInfo] of the annotated super-sealed class.
  ///
  SSealedClassInfo get sSealedClassInfo;

  /// This callback should return the [CaseModddelParam] of the given
  /// case-modddel.
  ///
  CaseModddelParam Function(ModddelClassInfo caseModddel)
      get getCaseModddelParam;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

class MapModddelsMethod extends StandardPatternMatchingMethod
    with _ModddelPatternMatchingMixin {
  MapModddelsMethod({
    required this.sSealedClassInfo,
    required this.getCaseModddelParam,
    required this.bodyKind,
  });

  @override
  final SSealedClassInfo sSealedClassInfo;

  @override
  final CaseModddelParam Function(ModddelClassInfo caseModddel)
      getCaseModddelParam;

  @override
  final MethodBodyKind bodyKind;

  @override
  MapModddelsPrototype get prototype => MapModddelsPrototype(
      sSealedClassInfo: sSealedClassInfo,
      getCaseModddelParam: getCaseModddelParam);

  @override
  String get maybeMapMethodName => MaybeMapModddelsPrototype(
          sSealedClassInfo: sSealedClassInfo,
          getCaseModddelParam: getCaseModddelParam)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseThrowArgumentsTemplate(prototype);
}

class MaybeMapModddelsMethod extends MaybeMapMethod
    with _ModddelPatternMatchingMixin {
  MaybeMapModddelsMethod({
    required this.sSealedClassInfo,
    required this.getCaseModddelParam,
    required this.bodyKind,
    required this.unionCaseParamName,
  });

  @override
  final SSealedClassInfo sSealedClassInfo;

  @override
  final CaseModddelParam Function(ModddelClassInfo caseModddel)
      getCaseModddelParam;

  @override
  final MethodBodyKind bodyKind;

  @override
  final String? unionCaseParamName;

  @override
  MaybeMapModddelsPrototype get prototype => MaybeMapModddelsPrototype(
      sSealedClassInfo: sSealedClassInfo,
      getCaseModddelParam: getCaseModddelParam);
}

class MapOrNullModddelsMethod extends StandardPatternMatchingMethod
    with _ModddelPatternMatchingMixin {
  MapOrNullModddelsMethod({
    required this.sSealedClassInfo,
    required this.getCaseModddelParam,
    required this.bodyKind,
  });

  @override
  final SSealedClassInfo sSealedClassInfo;

  @override
  final CaseModddelParam Function(ModddelClassInfo caseModddel)
      getCaseModddelParam;

  @override
  final MethodBodyKind bodyKind;

  @override
  MapOrNullModddelsPrototype get prototype => MapOrNullModddelsPrototype(
      sSealedClassInfo: sSealedClassInfo,
      getCaseModddelParam: getCaseModddelParam);

  @override
  String get maybeMapMethodName => MaybeMapModddelsPrototype(
          sSealedClassInfo: sSealedClassInfo,
          getCaseModddelParam: getCaseModddelParam)
      .methodName;

  @override
  ArgumentsTemplate get maybeMapMethodArguments =>
      orElseReturnNullArgumentsTemplate(prototype);
}
