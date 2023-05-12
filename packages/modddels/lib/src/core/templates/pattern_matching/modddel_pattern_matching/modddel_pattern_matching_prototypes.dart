import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/class_info/ssealed/ssealed_class_info.dart';
import 'package:modddels/src/core/templates/parameters/callback_parameter.dart';
import 'package:modddels/src/core/templates/parameters/parameters_template.dart';
import 'package:modddels/src/core/templates/pattern_matching/_pattern_matching_prototypes.dart';
import 'package:modddels/src/core/templates/pattern_matching/modddel_pattern_matching/case_modddel_param.dart';

/// The [PatternMatchingPrototype] of a "modddel pattern matching" method.
///
/// As a reminder : "Modddel pattern matching" is the pattern matching between
/// the different case-modddels of a ssealed class.
///
abstract class ModddelPatternMatchingPrototype
    extends PatternMatchingPrototype {
  /// The [SSealedClassInfo] of the annotated super-sealed class.
  ///
  SSealedClassInfo get sSealedClassInfo;

  /// This callback should return the [CaseModddelParam] of the given
  /// case-modddel.
  ///
  CaseModddelParam Function(ModddelClassInfo caseModddel)
      get getCaseModddelParam;

  /// For now, all modddel pattern matching methods are "map" methods.
  ///
  @override
  final patternMatchKind = PatternMatchKind.map;
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

class MapModddelsPrototype extends ModddelPatternMatchingPrototype {
  MapModddelsPrototype({
    required this.sSealedClassInfo,
    required this.getCaseModddelParam,
  }) : methodName = 'map${sSealedClassInfo.classIdentifiers.className}';

  @override
  final String methodName;

  @override
  final isReturnTypeNullable = false;

  @override
  final SSealedClassInfo sSealedClassInfo;

  @override
  final CaseModddelParam Function(ModddelClassInfo caseModddel)
      getCaseModddelParam;

  @override
  List<CallbackParameter> get positionalCallbackParameters =>
      _modddelsCallbackParameters(
        sSealedClassInfo.defaultCaseModddels,
        getCaseModddelParam: getCaseModddelParam,
        callbacksHaveRequired: false,
        callbacksAreNullable: false,
      );

  @override
  List<CallbackParameter> get namedCallbackParameters =>
      _modddelsCallbackParameters(
        sSealedClassInfo.namedCasedModddels,
        getCaseModddelParam: getCaseModddelParam,
        callbacksHaveRequired: true,
        callbacksAreNullable: false,
      );
}

class MaybeMapModddelsPrototype extends ModddelPatternMatchingPrototype {
  MaybeMapModddelsPrototype({
    required this.sSealedClassInfo,
    required this.getCaseModddelParam,
  }) : methodName = 'maybeMap${sSealedClassInfo.classIdentifiers.className}';

  @override
  final String methodName;

  @override
  final isReturnTypeNullable = false;

  @override
  final SSealedClassInfo sSealedClassInfo;

  @override
  final CaseModddelParam Function(ModddelClassInfo caseModddel)
      getCaseModddelParam;

  @override
  List<CallbackParameter> get positionalCallbackParameters =>
      _modddelsCallbackParameters(
        sSealedClassInfo.defaultCaseModddels,
        getCaseModddelParam: getCaseModddelParam,
        callbacksHaveRequired: false,
        callbacksAreNullable: true,
      );

  @override
  List<CallbackParameter> get namedCallbackParameters => [
        ..._modddelsCallbackParameters(
          sSealedClassInfo.namedCasedModddels,
          getCaseModddelParam: getCaseModddelParam,
          callbacksHaveRequired: false,
          callbacksAreNullable: true,
        ),
        orElseNamedCallbackParameter(),
      ];
}

class MapOrNullModddelsPrototype extends ModddelPatternMatchingPrototype {
  MapOrNullModddelsPrototype({
    required this.sSealedClassInfo,
    required this.getCaseModddelParam,
  }) : methodName = 'mapOrNull${sSealedClassInfo.classIdentifiers.className}';

  @override
  final String methodName;

  @override
  final isReturnTypeNullable = true;

  @override
  final SSealedClassInfo sSealedClassInfo;

  @override
  final CaseModddelParam Function(ModddelClassInfo caseModddel)
      getCaseModddelParam;

  @override
  List<CallbackParameter> get positionalCallbackParameters =>
      _modddelsCallbackParameters(
        sSealedClassInfo.defaultCaseModddels,
        getCaseModddelParam: getCaseModddelParam,
        callbacksHaveRequired: false,
        callbacksAreNullable: true,
      );

  @override
  List<CallbackParameter> get namedCallbackParameters =>
      _modddelsCallbackParameters(
        sSealedClassInfo.namedCasedModddels,
        getCaseModddelParam: getCaseModddelParam,
        callbacksHaveRequired: false,
        callbacksAreNullable: true,
      );
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
/* -------------------------------------------------------------------------- */

/// Returns the callback parameters representing the given [caseModddels].
///
/// The [getCaseModddelParam] callback is used to obtain the [CaseModddelParam]
/// of each case-modddel.
///
/// If [callbacksHaveRequired] is true, the callback parameters are preceded
/// with the "required" keyword.
///
/// If [callbacksAreNullable] is true, the type of the callback parameters is
/// nullable.
///
List<CallbackParameter> _modddelsCallbackParameters(
  List<ModddelClassInfo> caseModddels, {
  required CaseModddelParam Function(ModddelClassInfo caseModddel)
      getCaseModddelParam,
  required bool callbacksHaveRequired,
  required bool callbacksAreNullable,
}) {
  // Returns the [CallbackParameter.parameters] for the [caseModddel].
  ParametersTemplate makeParameters(ModddelClassInfo caseModddel) {
    final caseModddelParam = getCaseModddelParam(caseModddel);

    return ParametersTemplate(
        requiredPositionalParameters: [caseModddelParam.toExpandedParameter()]);
  }

  return caseModddels
      .map((modddelClassInfo) => CallbackParameter(
            name: modddelClassInfo.constructor.callbackName,
            returnType: 'TResult',
            hasRequired: callbacksHaveRequired,
            isNullable: callbacksAreNullable,
            decorators: const [],
            parameters: makeParameters(modddelClassInfo),
          ))
      .toList();
}

extension _SSealedClassInfoX on SSealedClassInfo {
  /// The [ModddelClassInfo]s of the case-modddels that have a default
  /// factory constructor (generally 0 or 1).
  ///
  List<ModddelClassInfo> get defaultCaseModddels => caseModddelsClassInfos
      .where((modddelClassInfo) => modddelClassInfo.constructor.isDefault)
      .toList();

  /// The [ModddelClassInfo]s of the case-modddels that have a named non-default
  /// factory constructor.
  ///
  List<ModddelClassInfo> get namedCasedModddels => caseModddelsClassInfos
      .where((modddelClassInfo) => !modddelClassInfo.constructor.isDefault)
      .toList();
}
