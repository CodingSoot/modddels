import 'package:analyzer/dart/element/type.dart';

/// Thrown if an unexpected [InvalidType] has been encountered.
///
class InvalidTypeException implements Exception {
  @override
  String toString() {
    return 'InvalidTypeException: An unexpected InvalidType has been encountered.';
  }
}
