import 'package:modddels/src/core/identifiers/general_identifiers.dart';
import 'package:modddels/src/core/identifiers/class_identifiers.dart';
import 'package:modddels/src/core/info/class_info/class_info.dart';
import 'package:modddels/src/core/templates/constructor_details.dart';

/// The [ClassInfo] of a modddel.
///
class ModddelClassInfo extends ClassInfo {
  ModddelClassInfo._({
    required this.classIdentifiers,
    required this.generalIdentifiers,
    required this.isCaseModddel,
    required this.constructor,
  });

  factory ModddelClassInfo({
    required String annotatedClassName,
    required bool isCaseModddel,
    required ConstructorDetails constructor,
  }) {
    final generalIdentifiers =
        GeneralIdentifiers(annotatedClassName: annotatedClassName);

    final classIdentifiers = ModddelClassIdentifiers(
      generalIdentifiers: generalIdentifiers,
      className: isCaseModddel
          ? constructor.caseModddelClassName
          : generalIdentifiers.annotatedClassName,
      isCaseModddel: isCaseModddel,
    );

    return ModddelClassInfo._(
      classIdentifiers: classIdentifiers,
      generalIdentifiers: generalIdentifiers,
      isCaseModddel: isCaseModddel,
      constructor: constructor,
    );
  }

  @override
  final ModddelClassIdentifiers classIdentifiers;

  @override
  final GeneralIdentifiers generalIdentifiers;

  /// Whether the modddel is a case-modddel.
  ///
  final bool isCaseModddel;

  /// Holds information about the factory constructor of the modddel.
  final ConstructorDetails constructor;
}
