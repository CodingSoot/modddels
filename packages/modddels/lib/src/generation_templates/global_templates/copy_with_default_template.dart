import 'package:modddels/src/core/identifiers/global_identifiers.dart';

/// The template that provides the "copyWithDefault constant".
///
/// It's a global template, i.e it is included at the top of the generated file
/// **once**, no matter how many annotated classes the source file contains.
///
class CopyWithDefaultTemplate {
  @override
  String toString() {
    final copyWithDefaultClassName =
        GlobalIdentifiers.copyWithIdentifiers.copyWithDefaultClassName;

    final copyWithDefaultConstName =
        GlobalIdentifiers.copyWithIdentifiers.copyWithDefaultConstName;

    return '''
    class $copyWithDefaultClassName {
      const $copyWithDefaultClassName();
    }

    const $copyWithDefaultConstName = $copyWithDefaultClassName();
    ''';
  }
}
