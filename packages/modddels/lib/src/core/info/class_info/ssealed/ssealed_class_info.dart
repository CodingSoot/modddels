import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';

/// The [ClassInfo] of an annotated super-sealed class.
///
class SSealedClassInfo extends ClassInfo {
  SSealedClassInfo._({
    required this.classIdentifiers,
    required this.generalIdentifiers,
    required this.caseModddelsClassInfos,
  });

  factory SSealedClassInfo({
    required String annotatedClassName,
    required List<ModddelClassInfo> caseModddelsClassInfos,
  }) {
    final generalIdentifiers =
        GeneralIdentifiers(annotatedClassName: annotatedClassName);

    final classIdentifiers =
        SSealedClassIdentifiers(generalIdentifiers: generalIdentifiers);

    return SSealedClassInfo._(
      classIdentifiers: classIdentifiers,
      generalIdentifiers: generalIdentifiers,
      caseModddelsClassInfos: caseModddelsClassInfos,
    );
  }

  @override
  final SSealedClassIdentifiers classIdentifiers;

  @override
  final GeneralIdentifiers generalIdentifiers;

  /// The list that contains the [ModddelClassInfo] of each case-modddel.
  ///
  final List<ModddelClassInfo> caseModddelsClassInfos;
}
