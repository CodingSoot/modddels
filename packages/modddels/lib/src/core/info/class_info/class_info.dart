import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/info/class_info/modddel/modddel_class_info.dart';
import 'package:modddels/src/core/info/class_info/ssealed/ssealed_class_info.dart';

abstract class ClassInfo {
  /// These identifiers vary depending on whether this is a [ModddelClassInfo]
  /// or a [SSealedClassInfo].
  ///
  ClassIdentifiers get classIdentifiers;

  /// These identifiers stay the same no matter if this is a [ModddelClassInfo]
  /// or a [SSealedClassInfo].
  ///
  GeneralIdentifiers get generalIdentifiers;
}
