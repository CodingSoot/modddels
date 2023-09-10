## 0.2.0

- Require **Dart 3.0**
- Support analyzer 6.2.0
- Support fpdart 1.1.0
- Update dependencies
- Improve how types that are invalid generation-time are handled
- **Breaking change :** For custom Iterable2Entity kinds, the method `$collectionToIterable` should return a record of the two iterables instead of a `Tuple2`.

  Example :
  
  ```dart
  // Old :
  Tuple2<Iterable<R1>, Iterable<R2>> $collectionToIterable<R1, R2>(
          Map<R1, R2> collection) =>
      Tuple2(collection.keys, collection.values);

  // New :
  (Iterable<R1>, Iterable<R2>) $collectionToIterable<R1, R2>(
          Map<R1, R2> collection) =>
      (collection.keys, collection.values);
  ```

## 0.1.5

Bump fpdart version to 0.6.0

## 0.1.4

- **Breaking :** Disallow adding non-factory constructors other than the private constructor to a class decorated with `@Modddel`. (See [#6](https://github.com/CodingSoot/modddels/issues/6))
- Fix an issue where the default value of a factory parameter in a union is not included in the matching factory constructor of the generated ModddelParams class. (See [#11](https://github.com/CodingSoot/modddels/issues/11))

## 0.1.3

Add example to README

## 0.1.2

Improve pub points

## 0.1.1

Update README

## 0.1.0

Initial release
