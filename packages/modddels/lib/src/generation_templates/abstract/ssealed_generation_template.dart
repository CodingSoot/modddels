import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/info/modddel_info.dart';
import 'package:modddels/src/core/info/ssealed_info.dart';
import 'package:modddels_annotation_internal/modddels_freezed_files.dart';

/// Base class for all templates or elements that are related to the
/// super-sealed classes.
///
abstract class SSealedGenerationTemplate<SI extends SSealedInfo<MI>,
    MI extends ModddelInfo> {
  /// The info of the annotated super-sealed class.
  ///
  SI get sSealedInfo;

  /// The list that contains the [ModddelInfo] of each case-modddel.
  ///
  List<MI> get caseModddelsInfos => sSealedInfo.caseModddelsInfos;

  /// The kind of the case-modddels.
  ///
  ModddelKind get modddelKind => sSealedInfo.modddelKind;

  /// Whether the annotated super-sealed class has any shared dependency
  /// parameters.
  ///
  bool get hasDependencies =>
      sSealedInfo.sSealedParametersInfo.hasDependencyParameters;

  /// The identifiers related to the annotated class.
  ///
  GeneralIdentifiers get generalIdentifiers =>
      sSealedInfo.sSealedClassInfo.generalIdentifiers;

  /// The identifiers related to the annotated super-sealed class.
  ///
  SSealedClassIdentifiers get sSealedClassIdentifiers =>
      sSealedInfo.sSealedClassInfo.classIdentifiers;
}
