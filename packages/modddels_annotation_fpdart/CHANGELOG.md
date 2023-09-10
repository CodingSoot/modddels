## 0.2.0

- Require **Dart 3.0**
- Support fpdart 1.1.0
- Update dependencies
- The annotations' classes that have a constant variable are no longer exported (For example : `ValidParam` is not exported because there is the `validParam` constant).
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

## 0.1.1

Bump fpdart version to 0.6.0

## 0.1.0

Initial release
