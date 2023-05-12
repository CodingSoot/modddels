import 'package:dartz/dartz.dart' show IList, ISet, IMap;
import 'package:fpdart/fpdart.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:modddels_annotation_fpdart/src/modddels/base_modddel.dart';
import 'package:modddels_annotation_fpdart/src/modddels/entities/entity.dart';
import 'package:modddels_annotation_fpdart/src/modddels/entities/iterables_entities/common.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// An [IterableEntity] is an [Entity] that holds a collection of modddels.
///
/// The collection must be able to be converted to **an iterable** of modddels.
/// For example : `List<M>`, `Set<M>`, `Map<int,M>`... where `M` is the type of
/// the modddel.
///
abstract class IterableEntity<I extends InvalidEntity, V extends ValidEntity>
    extends Entity<I, V> {
  const IterableEntity();

  /// Returns the description of the modddel at the given [index].
  ///
  /// This description is used in the [ContentFailure.toString] method to
  /// label an invalid modddel (See [ModddelInvalidMember]).
  ///
  /// Example : 'item 4', 'entry 2'...
  ///
  @protected
  String $description(int index) => 'item $index';

  /// Optional. Returns the description details of the [modddel] at the given
  /// [index].
  ///
  /// If not null, the result is appended to the description, in parenthesis.
  ///
  /// Example : 'item 1 (id = 1234)'
  ///
  @protected
  String? $descriptionDetails(BaseModddel modddel, int index) => null;

  /// Implementation of the "validateContent" method for [IterableEntity].
  ///
  /// The [list] parameter is the collection of modddels of the [IterableEntity]
  /// converted to a simple [List].
  ///
  @nonVirtual
  @protected
  Option<ContentFailure> $validateContent(List<BaseModddel?> list) {
    final invalidMembers = validateListContent(list,
        descriptionFor: $description,
        descriptionDetailsFor: $descriptionDetails);

    if (invalidMembers.isEmpty) {
      return none();
    }
    final contentFailure = ContentFailure(invalidMembers);
    return some(contentFailure);
  }
}

/* -------------------------------------------------------------------------- */
/*                               List Iterables                               */
/* -------------------------------------------------------------------------- */

/// A [ListEntity] is an [IterableEntity] where the modddels are held inside
/// a [List].
///
@TypeTemplate('List<#1>')
abstract class ListEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  List<R> $primeCollection<R>(List<R> collection) =>
      List.unmodifiable(collection);

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<R>(List<R> collection) => collection;

  // NB : List.cast keeps the List unmodifiable.
  @protected
  @optionalTypeArgs
  List<R> $castCollection<S, R>(List<S> source) => source.cast<R>();
}

/// A [KtListEntity] is an [IterableEntity] where the modddels are held inside
/// a [KtList].
///
@TypeTemplate('KtList<#1>')
abstract class KtListEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  KtList<R> $primeCollection<R>(KtList<R> collection) => collection;

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<R>(KtList<R> collection) => collection.iter;

  @protected
  @optionalTypeArgs
  KtList<R> $castCollection<S, R>(KtList<S> source) => source.cast<R>();
}

/// An [IListEntity] is an [IterableEntity] where the modddels are held inside
/// an [IList].
///
@TypeTemplate('IList<#1>')
abstract class IListEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  IList<R> $primeCollection<R>(IList<R> collection) => collection;

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<R>(IList<R> collection) =>
      collection.toIterable();

  @protected
  @optionalTypeArgs
  IList<R> $castCollection<S, R>(IList<S> source) =>
      source.map<R>((a) => a as R);
}

/* -------------------------------------------------------------------------- */
/*                                Set Iterables                               */
/* -------------------------------------------------------------------------- */

/// A [SetEntity] is an [IterableEntity] where the modddels are held inside
/// a [Set].
///
@TypeTemplate('Set<#1>')
abstract class SetEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  Set<R> $primeCollection<R>(Set<R> collection) => Set.unmodifiable(collection);

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<R>(Set<R> collection) => collection;

  // NB : `Set.cast` keeps the Set unmodifiable.
  @protected
  @optionalTypeArgs
  Set<R> $castCollection<S, R>(Set<S> source) => source.cast<R>();
}

/// A [KtSetEntity] is an [IterableEntity] where the modddels are held inside
/// a [KtSet].
///
@TypeTemplate('KtSet<#1>')
abstract class KtSetEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  KtSet<R> $primeCollection<R>(KtSet<R> collection) => collection;

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<R>(KtSet<R> collection) => collection.iter;

  @protected
  @optionalTypeArgs
  KtSet<R> $castCollection<S, R>(KtSet<S> source) => source.cast<R>().toSet();
}

/// An [ISetEntity] is an [IterableEntity] where the modddels are held inside
/// an [ISet].
///
@TypeTemplate('ISet<#1>')
abstract class ISetEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> with DartzIterables {
  @protected
  @optionalTypeArgs
  ISet<R> $primeCollection<R>(ISet<R> collection) =>
      collection.transform($getOrder<R>(), (a) => a);

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<R>(ISet<R> collection) =>
      collection.toIterable();

  @protected
  @optionalTypeArgs
  ISet<R> $castCollection<S, R>(ISet<S> source) =>
      source.transform($getOrder<R>(), (a) => a as R);
}

/* -------------------------------------------------------------------------- */
/*                           MappedValues Iterables                           */
/* -------------------------------------------------------------------------- */

/// A [MappedValuesEntity] is an [IterableEntity] where the modddels are held
/// inside the values of a [Map]. The keys can be any Dart objects, and they are
/// not validated during the contentValidation.
///
@TypeTemplate('Map<*,#1>')
abstract class MappedValuesEntity<I extends InvalidEntity,
    V extends ValidEntity> extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  Map<O, R> $primeCollection<O, R>(Map<O, R> collection) =>
      Map.unmodifiable(collection);

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<O, R>(Map<O, R> collection) =>
      collection.values;

  // NB : `Map.cast` keeps the Map unmodifiable.
  @protected
  @optionalTypeArgs
  Map<O, R> $castCollection<O, S, R>(Map<O, S> source) => source.cast<O, R>();

  @protected
  @override
  String $description(int index) => 'entry $index';
}

/// A [KtMappedValuesEntity] is an [IterableEntity] where the modddels are held
/// inside the values of a [KtMap]. The keys can be any Dart objects, and they
/// are not validated during the contentValidation.
///
@TypeTemplate('KtMap<*,#1>')
abstract class KtMappedValuesEntity<I extends InvalidEntity,
    V extends ValidEntity> extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  KtMap<O, R> $primeCollection<O, R>(KtMap<O, R> collection) => collection;

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<O, R>(KtMap<O, R> collection) {
    return collection.values.iter;
  }

  @protected
  @optionalTypeArgs
  KtMap<O, R> $castCollection<O, S, R>(KtMap<O, S> source) =>
      source.asMap().cast<O, R>().toImmutableMap();

  @protected
  @override
  String $description(int index) => 'entry $index';
}

/// An [IMappedValuesEntity] is an [IterableEntity] where the modddels are held
/// inside the values of an [IMap]. The keys can be any Dart objects, and they
/// are not validated during the contentValidation.
///
@TypeTemplate('IMap<*,#1>')
abstract class IMappedValuesEntity<I extends InvalidEntity,
    V extends ValidEntity> extends IterableEntity<I, V> with DartzIterables {
  @protected
  @optionalTypeArgs
  IMap<O, R> $primeCollection<O, R>(IMap<O, R> collection) =>
      IMap.from($getOrder<O>(), collection.toMap());

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<O, R>(IMap<O, R> collection) {
    return collection.values().toIterable();
  }

  @protected
  @optionalTypeArgs
  IMap<O, R> $castCollection<O, S, R>(IMap<O, S> source) =>
      IMap.from($getOrder<O>(), source.toMap().cast<O, R>());

  @protected
  @override
  String $description(int index) => 'entry $index';
}

/* -------------------------------------------------------------------------- */
/*                            MappedKeys Iterables                            */
/* -------------------------------------------------------------------------- */

/// A [MappedKeysEntity] is an [IterableEntity] where the modddels are held
/// inside the keys of a [Map]. The values can be any Dart objects, and they are
/// not validated during the contentValidation.
///
@TypeTemplate('Map<#1,*>')
abstract class MappedKeysEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  Map<R, O> $primeCollection<O, R>(Map<R, O> collection) =>
      Map.unmodifiable(collection);

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<O, R>(Map<R, O> collection) =>
      collection.keys;

  // NB : `Map.cast` keeps the Map unmodifiable.
  @protected
  @optionalTypeArgs
  Map<R, O> $castCollection<O, S, R>(Map<S, O> source) => source.cast<R, O>();

  @protected
  @override
  String $description(int index) => 'entry $index';
}

/// A [KtMappedKeysEntity] is an [IterableEntity] where the modddels are held
/// inside the keys of a [KtMap]. The values can be any Dart objects, and they
/// are not validated during the contentValidation.
///
@TypeTemplate('KtMap<#1,*>')
abstract class KtMappedKeysEntity<I extends InvalidEntity,
    V extends ValidEntity> extends IterableEntity<I, V> {
  @protected
  @optionalTypeArgs
  KtMap<R, O> $primeCollection<O, R>(KtMap<R, O> collection) => collection;

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<O, R>(KtMap<R, O> collection) {
    return collection.keys.iter;
  }

  @protected
  @optionalTypeArgs
  KtMap<R, O> $castCollection<O, S, R>(KtMap<S, O> source) =>
      source.asMap().cast<R, O>().toImmutableMap();

  @protected
  @override
  String $description(int index) => 'entry $index';
}

/// An [IMappedKeysEntity] is an [IterableEntity] where the modddels are held
/// inside the keys of an [IMap]. The values can be any Dart objects, and they
/// are not validated during the contentValidation.
///
@TypeTemplate('IMap<#1,*>')
abstract class IMappedKeysEntity<I extends InvalidEntity, V extends ValidEntity>
    extends IterableEntity<I, V> with DartzIterables {
  @protected
  @optionalTypeArgs
  IMap<R, O> $primeCollection<O, R>(IMap<R, O> collection) =>
      IMap.from($getOrder<R>(), collection.toMap());

  @protected
  @optionalTypeArgs
  Iterable<R> $collectionToIterable<O, R>(IMap<R, O> collection) {
    return collection.keys().toIterable();
  }

  @protected
  @optionalTypeArgs
  IMap<R, O> $castCollection<O, S, R>(IMap<S, O> source) =>
      IMap.from($getOrder<R>(), source.toMap().cast<R, O>());

  @protected
  @override
  String $description(int index) => 'entry $index';
}
