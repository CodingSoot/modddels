import 'package:modddels_annotation_fpdart/src/modddels/base_modddel.dart';
import 'package:modddels_annotation_fpdart/src/modddels/entities/simple_entity/simple_entity.dart';
import 'package:modddels_annotation_fpdart/src/modddels/entities/iterables_entities/iterable_entity.dart';
import 'package:modddels_annotation_fpdart/src/modddels/entities/iterables_entities/iterable2_entity.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// An [Entity] is a modddel that holds other modddels (ValueObjects or
/// Entities).
///
/// An [Entity] always has a special validation which we call the
/// "contentValidation". During the contentValidation, the modddels that are
/// held inside the entity are verified. If they are all valid, the
/// contentValidation passes successfully. If one of them is invalid, the
/// contentValidation fails with a [ContentFailure], which holds the invalid
/// modddel(s) and their failures.
///
/// In addition to the contentValidation, entities can have additionnal
/// validations that you specify. Each validation either passes successfully, or
/// fails with an [EntityFailure].
///
/// NB : The [ContentFailure] is a subclass of [EntityFailure], which is a
/// subclass of [Failure].
///
/// These are the available Entities :
///
/// - [SimpleEntity]
/// - [IterableEntity] :
///   - _Dart collections :_ [ListEntity] - [SetEntity] - [MappedValuesEntity] -
///     [MappedKeysEntity]
///   - _KtDart collections :_ [KtListEntity] - [KtSetEntity] -
///     [KtMappedValuesEntity] - [KtMappedKeysEntity]
///   - _Dartz collections :_ [IListEntity] - [ISetEntity] -
///     [IMappedValuesEntity] - [IMappedKeysEntity]
/// - [Iterable2Entity] :
///   - _Dart collections :_ [MapEntity]
///   - _KtDart collections :_ [KtMapEntity]
///   - _Dartz collections :_ [IMapEntity]
///
abstract class Entity<I extends InvalidEntity, V extends ValidEntity>
    extends BaseModddel<I, V> {
  const Entity();
}
