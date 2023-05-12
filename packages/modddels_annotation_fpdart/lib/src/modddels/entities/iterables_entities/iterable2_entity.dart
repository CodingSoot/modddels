import 'package:dartz/dartz.dart' show IMap;
import 'package:fpdart/fpdart.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:modddels_annotation_fpdart/src/modddels/base_modddel.dart';
import 'package:modddels_annotation_fpdart/src/modddels/entities/entity.dart';
import 'package:modddels_annotation_fpdart/src/modddels/entities/iterables_entities/common.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';

/// An [Iterable2Entity] is an [Entity] that holds a collection of modddels.
///
/// The collection must be able to be converted to **two iterables** of
/// modddels. For example : Map<M1, M2>`, `Map<M1, List<M2>>`... where `M1` and
/// `M2` are the two modddels types.
///
abstract class Iterable2Entity<I extends InvalidEntity, V extends ValidEntity>
    extends Entity<I, V> {
  const Iterable2Entity();

  /// Returns the description of the modddel at the given [index] in the first
  /// iterable.
  ///
  /// This description is used in the [ContentFailure.toString] method to label
  /// an invalid modddel in the first iterable (See [ModddelInvalidMember]).
  ///
  /// Example of a description : 'first 7', 'key 3'...
  ///
  @protected
  String $description1(int index) => 'first $index';

  /// Returns the description of the modddel at the given [index] in the second
  /// iterable.
  ///
  /// This description is used in the [ContentFailure.toString] method to label
  /// an invalid modddel in the second iterable (See [ModddelInvalidMember]).
  ///
  /// Example of a description : 'second 4', 'value 8'...
  ///
  @protected
  String $description2(int index) => 'second $index';

  /// Optional. Returns the description details of the [modddel] at the given
  /// [index] in the first iterable.
  ///
  /// If not null, the result is appended to the description1, in parenthesis.
  ///
  /// Example of a description : 'key 3 (id = 1234)'
  ///
  @protected
  String? $descriptionDetails1(BaseModddel modddel, int index) => null;

  /// Optional. Returns the description details of the [modddel] at the given
  /// [index] in the second iterable.
  ///
  /// If not null, the result is appended to the description2, in parenthesis.
  ///
  /// Example of a description : 'value 3 (id = 1234)'
  ///
  @protected
  String? $descriptionDetails2(BaseModddel modddel, int index) => null;

  /// Implementation of the "validateContent" method for [Iterable2Entity].
  ///
  /// The [list1] and [list2] parameters are respectively the first and second
  /// iterables of the [Iterable2Entity] converted to simple [List]s.
  ///
  @nonVirtual
  @protected
  Option<ContentFailure> $validateContent(
      List<BaseModddel?> list1, List<BaseModddel?> list2) {
    final invalidMembers = <ModddelInvalidMember>[
      ...validateListContent(list1,
          descriptionFor: $description1,
          descriptionDetailsFor: $descriptionDetails1),
      ...validateListContent(list2,
          descriptionFor: $description2,
          descriptionDetailsFor: $descriptionDetails2)
    ];

    if (invalidMembers.isEmpty) {
      return none();
    }
    final contentFailure = ContentFailure(invalidMembers);
    return some(contentFailure);
  }
}

/* -------------------------------------------------------------------------- */
/*                               Map Iterables2                               */
/* -------------------------------------------------------------------------- */

/// A [MapEntity] is an [Iterable2Entity] where the modddels are held inside
/// a [Map].
///
@TypeTemplate('Map<#1,#2>')
abstract class MapEntity<I extends InvalidEntity, V extends ValidEntity>
    extends Iterable2Entity<I, V> {
  @protected
  @optionalTypeArgs
  Map<R1, R2> $primeCollection<R1, R2>(Map<R1, R2> collection) =>
      Map.unmodifiable(collection);

  @protected
  @optionalTypeArgs
  Tuple2<Iterable<R1>, Iterable<R2>> $collectionToIterable<R1, R2>(
          Map<R1, R2> collection) =>
      Tuple2(collection.keys, collection.values);

  // NB : `Map.cast` keeps the Map unmodifiable.
  @protected
  @optionalTypeArgs
  Map<R1, R2> $castCollection<S1, R1, S2, R2>(Map<S1, S2> source) =>
      source.cast<R1, R2>();

  @protected
  @override
  String $description1(int index) => 'key $index';

  @protected
  @override
  String $description2(int index) => 'value $index';
}

/// A [KtMapEntity] is an [Iterable2Entity] where the modddels are held inside
/// a [KtMap].
///
@TypeTemplate('KtMap<#1,#2>')
abstract class KtMapEntity<I extends InvalidEntity, V extends ValidEntity>
    extends Iterable2Entity<I, V> {
  @protected
  @optionalTypeArgs
  KtMap<R1, R2> $primeCollection<R1, R2>(KtMap<R1, R2> collection) =>
      collection;

  @protected
  @optionalTypeArgs
  Tuple2<Iterable<R1>, Iterable<R2>> $collectionToIterable<R1, R2>(
          KtMap<R1, R2> collection) =>
      Tuple2(collection.keys.iter, collection.values.iter);

  @protected
  @optionalTypeArgs
  KtMap<R1, R2> $castCollection<S1, R1, S2, R2>(KtMap<S1, S2> source) =>
      source.asMap().cast<R1, R2>().toImmutableMap();

  @protected
  @override
  String $description1(int index) => 'key $index';

  @protected
  @override
  String $description2(int index) => 'value $index';
}

/// An [IMapEntity] is an [Iterable2Entity] where the modddels are held inside
/// an [IMap].
///
@TypeTemplate('IMap<#1,#2>')
abstract class IMapEntity<I extends InvalidEntity, V extends ValidEntity>
    extends Iterable2Entity<I, V> with DartzIterables {
  @protected
  @optionalTypeArgs
  IMap<R1, R2> $primeCollection<R1, R2>(IMap<R1, R2> collection) =>
      IMap.from($getOrder<R1>(), collection.toMap());

  @protected
  @optionalTypeArgs
  Tuple2<Iterable<R1>, Iterable<R2>> $collectionToIterable<R1, R2>(
          IMap<R1, R2> collection) =>
      Tuple2(collection.keys().toIterable(), collection.values().toIterable());

  @protected
  @optionalTypeArgs
  IMap<R1, R2> $castCollection<S1, R1, S2, R2>(IMap<S1, S2> source) =>
      IMap.from($getOrder<R1>(), source.toMap().cast<R1, R2>());

  @protected
  @override
  String $description1(int index) => 'key $index';

  @protected
  @override
  String $description2(int index) => 'value $index';
}
