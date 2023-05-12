import 'package:modddels/src/core/identifiers/global_identifiers.dart';

/// The template that provides the "unimplementedError variable".
///
/// It's a global template, i.e it is included at the top of the generated file
/// **once**, no matter how many annotated classes the source file contains.
///
class UnimplementedErrorTemplate {
  @override
  String toString() {
    final unimplementedErrorVarName =
        GlobalIdentifiers.unimplementedErrorVarName;

    final unimplementedErrorString =
        'It seems like you constructed your class using `MyClass._()`, '
        'or you tried to access an instance member from within the annotated class.';

    return '''
    final $unimplementedErrorVarName = UnsupportedError('$unimplementedErrorString');
    ''';
  }
}
