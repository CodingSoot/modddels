import 'package:modddels_annotation_fpdart/src/modddels/entities/entity.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// A [SimpleEntity] is an [Entity] that holds the modddels as separate fields.
///
abstract class SimpleEntity<I extends InvalidEntity, V extends ValidEntity>
    extends Entity<I, V> {}
