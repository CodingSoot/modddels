import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/shared_parameter.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// Base class for all templates or elements that are related to a single
/// modddel. This modddel can either be the annotated solo class or a
/// case-modddel.
///
abstract class ModddelGenerationTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> {
  ModddelGenerationTemplate() {
    assert(
        modddelInfo.modddelClassInfo.isCaseModddel == (sSealedInfo != null),
        '`sSealedInfo should be null if the modddel is solo, and non-null '
        'if it\'s a case-modddel.`');
  }

  /// The info of the modddel.
  ///
  MI get modddelInfo;

  /// The info of the annotated super-sealed class if the modddel is a
  /// case-modddel.
  ///
  /// Null if the modddel is solo.
  ///
  SI? get sSealedInfo;

  /// Whether the modddel is a case-modddel.
  ///
  bool get isCaseModddel => sSealedInfo != null;

  /// The kind of the modddel.
  ///
  ModddelKind get modddelKind => modddelInfo.modddelKind;

  /// The identifiers related to the annotated class.
  ///
  GeneralIdentifiers get generalIdentifiers =>
      modddelInfo.modddelClassInfo.generalIdentifiers;

  /// The identifiers related to the modddel.
  ///
  ModddelClassIdentifiers get modddelClassIdentifiers =>
      modddelInfo.modddelClassInfo.classIdentifiers;

  /// The identifiers related to the annotated super-sealed class if the modddel
  /// is a case-modddel.
  ///
  /// Null if the modddel is solo.
  ///
  SSealedClassIdentifiers? get sSealedClassIdentifiers =>
      sSealedInfo?.sSealedClassInfo.classIdentifiers;

  /// Whether the modddel has any dependency parameters.
  ///
  bool get hasDependencies =>
      modddelInfo.modddelParametersInfo.hasDependencyParameters;

  /// Use this if an element (method, property...) is only overidden if the
  /// modddel is a case-modddel.
  ///
  String get overrideCase => isCaseModddel ? '@override' : '';

  /// Whether the parameter named [paramName] is a [SharedParameter].
  ///
  /// NB : This is always false if the modddel is solo.
  ///
  bool isSharedParam(String paramName) => isCaseModddel
      ? sSealedInfo!.sSealedParametersInfo.isSharedParam(paramName)
      : false;
}
