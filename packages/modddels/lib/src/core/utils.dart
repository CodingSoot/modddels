import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

/* -------------------------------------------------------------------------- */
/*                                    Maps                                    */
/* -------------------------------------------------------------------------- */

/// Returns a new map with all key/value pairs in the provided [maps].
///
/// If there are keys that occur in multiple maps, the [value] function is
/// used to select the value that is kept (one map pair at a time). If
/// [value] is omitted, the value from the latter map in the list is kept.
///
Map<K, V> mergeAllMaps<K, V>(
  List<Map<K, V>> maps, {
  V Function(V v1, V v2)? value,
}) {
  if (maps.isEmpty) {
    return {};
  }
  if (maps.length == 1) {
    return maps.single;
  }
  return mergeMaps(
    maps[0],
    mergeAllMaps(maps.sublist(1), value: value),
    value: value,
  );
}

/* -------------------------------------------------------------------------- */
/*                                  Iterables                                 */
/* -------------------------------------------------------------------------- */

K _selectFirst<K>(K p0, K p1) => p0;

bool _defaultEquality<K>(K p0, K p1) => p0 == p1;

/// Returns a new iterable which is the intersection between [iter1] and
/// [iter2], with all duplicates removed.
///
/// That is, the returned iterable contains the items that are both in [iter1]
/// and [iter2]. Duplicates are removed.
///
/// If [equals] is provided, it will be used to determine whether two items are
/// equal, and thus whether an iterable contains an element. (instead of the
/// default equality).
///
/// If [select] is provided, it will be used to determine which version of the
/// duplicated/repeated element to keep.
///
/// Example :
/// ```dart
/// final result = intersectIterables<String>(
///   ['A1',  'B1', 'D6', 'B9'],
///   ['A1', 'A3', 'B1'],
///   // Two items are considered equal if the first letter is equal
///   equals: (p0, p1) => p0[0] == p1[0],
///   // We select the item that has the highest number
///   select: (p0, p1) => int.parse(p0[1]) > int.parse(p1[1]) ? p0 : p1,
/// );
///
/// /// result = [A3, B9]
/// ```
///
Iterable<K> intersectIterables<K>(
  Iterable<K> iter1,
  Iterable<K> iter2, {
  bool Function(K, K)? equals,
  K Function(K, K)? select,
}) {
  equals = equals ?? _defaultEquality;
  select = select ?? _selectFirst;

  // We remove duplicates within the lists first.
  final list1 = iter1.toList().distinct(equals: equals, select: select);
  final list2 = iter2.toList().distinct(equals: equals, select: select);

  return list1.fold([], (previousValue, element) {
    final duplicateOption = list2.where((e) => equals!(e, element)).firstOption;
    return duplicateOption.match(
      () => previousValue,
      (duplicate) => [...previousValue, select!(element, duplicate)],
    );
  });
}

/// Returns a new iterable which is the intersection between all [iters], with
/// all duplicates removed.
///
/// That is, the returned iterables contains the elements that are contained in
/// all [iters]. Duplicates are removed.
///
/// If [equals] is provided, it will be used to determine whether an iterable
/// contains an element (instead of the default equality).
///
Iterable<K> intersectAllIterables<K>(
  List<Iterable<K>> iters, {
  bool Function(K, K)? equals,
  K Function(K, K)? select,
}) {
  if (iters.isEmpty) {
    return [];
  }
  if (iters.length == 1) {
    return iters.single;
  }
  return intersectIterables(
    iters.first,
    intersectAllIterables(iters.sublist(1), equals: equals, select: select),
    equals: equals,
    select: select,
  );
}

extension ListExtension<T> on List<T> {
  /// Returns a list that contains all the values in this list with duplicates
  /// removed.
  ///
  /// If [equals] is provided, it will be used to determine whether two items
  /// are equal (instead of the default equality).
  ///
  /// If [select] is provided, it will be used to determine which version of the
  /// duplicated item to keep.
  ///
  /// Example :
  /// ```dart
  /// final result = ['A1', 'A3', 'B1', 'D6', 'B0'].distinct(
  ///   // Two items are considered equal if the first letter is the same
  ///   equals: (p0, p1) => p0[0] == p1[0],
  ///   // We select the item that has the highest number
  ///   select: (p0, p1) => int.parse(p0[1]) > int.parse(p1[1]) ? p0 : p1,
  /// );
  ///
  /// // result = [A3, B1, D6]
  /// ```
  ///
  List<T> distinct({
    bool Function(T, T)? equals,
    T Function(T, T)? select,
  }) {
    equals = equals ?? _defaultEquality;
    select = select ?? _selectFirst;

    return fold(
      [],
      (previousValue, element) {
        // We skip this element if it has been processed as a duplicate
        if (previousValue.any((e) => equals!(e, element))) {
          return previousValue;
        }
        final duplicates = where((e) => equals!(e, element)).toList();

        final Option<T> selectedOption = select == _selectFirst
            ? duplicates.firstOption
            : duplicates.fold(
                none(),
                (previousValue, element) => previousValue.match(
                  () => some(element),
                  (pVal) => some(select!(pVal, element)),
                ),
              );

        return selectedOption.match(
          () => previousValue,
          (selected) => [...previousValue, selected],
        );
      },
    );
  }

  /// Returns a list that contains all the items in this list with items that
  /// have a duplicate [keyOf] property removed.
  ///
  /// If [equals] is provided, it will be used to determine whether two
  /// [keyOf] properties are equal.
  ///
  /// If [select] is provided, it will be used to determine which version of the
  /// duplicated item to keep.
  ///
  /// ```dart
  /// final result = [User('john', 24), User('avi', 20), User('josh', 19)].distinctBy<String>(
  ///   (e) => e.name,
  ///   // Two names are considered equal if the first letter is the same
  ///   equals: (p0, p1) => p0[0] == p1[0],
  ///   // We select the user that has the highest number
  ///   select: (p0, p1) => p0.age > p1.age ? p0 : p1,
  /// );
  ///
  /// /// result = [User(john, 24), User(avi, 20)]
  /// ```
  ///
  List<T> distinctBy<R>(
    R Function(T element) keyOf, {
    bool Function(R, R)? equals,
    T Function(T, T)? select,
  }) {
    equals = equals ?? _defaultEquality;

    return distinct(
        equals: (p0, p1) => equals!(keyOf(p0), keyOf(p1)), select: select);
  }
}

/* -------------------------------------------------------------------------- */
/*                                   Strings                                  */
/* -------------------------------------------------------------------------- */

extension StringExtension on String {
  /// Turns the first letter of this String to upper-case.
  ///
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  /// Turns the first letter of this String to lower-case.
  ///
  String uncapitalize() {
    return "${this[0].toLowerCase()}${substring(1)}";
  }

  /// Similar to [replaceAllMapped] but with the indexes.
  ///
  String replaceAllIndexed(
      Pattern from, Function(int index, Match match) replace) {
    var i = 0;
    return replaceAllMapped(from, (match) => replace(i++, match));
  }

  /// Replaces '$' with '\$'
  ///
  String escaped() => replaceAll(r'$', r'\$');
}

/* -------------------------------------------------------------------------- */
/*                                    Type                                    */
/* -------------------------------------------------------------------------- */

/// The non-nullable version of [type].
///
/// Returns the type without any trailing '?'. If the type is 'Null', returns
/// 'Never'.
///
String nonNullableType(String type) => type.endsWith('?')
    ? nonNullableType(type.substring(0, type.length - 1))
    : isNullType(type)
        ? 'Never'
        : type;

/// The nullable version of [type].
///
/// If [type] is already nullable, returns the same [type].
///
String nullableType(String type) => isNullableType(type) ? type : '$type?';

/// The "valid" version of [type].
///
/// If the type is 'Null', then it is considered valid.
///
String validType(String type) => isNullType(type) ? type : 'Valid$type';

/// Whether [type] is nullable.
///
/// Returns true if the type ends with '?', is 'Null', or is dynamic.
///
bool isNullableType(String type) =>
    isDynamicType(type) || isNullType(type) || type.endsWith('?');

/// Whether the [type] is dynamic.
///
bool isDynamicType(String type) =>
    RegExp(r'^dynamic' + RegexUtils.optionalNullabilitySuffix + r'$')
        .hasMatch(type);

/// Whether the [type] is 'Null'.
///
bool isNullType(String type) =>
    RegExp(r'^Null' + RegexUtils.optionalNullabilitySuffix + r'$')
        .hasMatch(type);

class RegexUtils {
  /// Matches a dart prefix including the dot and the possible preceding and
  /// trailing spacing. The group 1 matches the prefix without the dot and the
  /// spacing.
  ///
  static const optionalPrefixGroup = r'(?:(\b[\w$]+\b)\s*\.\s*)?';

  /// Matches the nullability suffix "?" with the possible spacing preceding it.
  ///
  static const optionalNullabilitySuffix = r'(?:\s*\?)?';

  /// Matches a type name.
  ///
  static const typeName = r'\b[\w$]+\b';

  /// Creates a capturing group for the [source] string.
  ///
  static String group(String source) => '($source)';
}
