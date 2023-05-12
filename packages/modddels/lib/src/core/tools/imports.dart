import 'package:analyzer/dart/element/element.dart';

extension LibraryHas on LibraryElement {
  /// Whether this library satisfies the [visitor] callback or has any
  /// export (immediate or transitive) that satisfies the callback.
  ///
  bool hasExportWhere(bool Function(LibraryElement library) visitor) {
    return findExportWhere(this, visitor) != null;
  }

  /// Whether this library satisfies the [visitor] callback or has any
  /// import (immediate or transitive) that satisfies the callback.
  ///
  bool hasImportWhere(bool Function(LibraryElement library) visitor) {
    return findImportWhere(this, visitor) != null;
  }
}

/// This function first checks if the [library] itself satisfies the [visitor]
/// callback, if so, it returns it. Otherwise, it traverses the library's
/// exports (immediate and transitive) in a breadth-first fashion until if finds
/// a library that satisfies the [visitor] callback.
///
/// If no such library is found, returns null.
///
/// **Note :**
///
/// There are two kind of exports :
/// - Immediate exports : exports that are directly made by the library. These
/// can be accessed using [LibraryElement.exportedLibraries].
/// - Transitive exports : exports that this library indirectly makes because
/// some of the libraries it exports are exporting them.
///
/// This function looks in both immediate and transitive exports.
///
LibraryElement? findExportWhere(
  LibraryElement library,
  bool Function(LibraryElement library) visitor,
) {
  // If this library satisfies the [visitor] callback, we return it.
  if (visitor(library)) {
    return library;
  }

  return _findWhere(library, visitor, (l) => l.exportedLibraries);
}

/// This function first checks if the [library] itself satisfies the [visitor]
/// callback, if so, it returns it. Otherwise, it traverses the library's
/// imports (immediate and transitive) in a breadth-first fashion until if finds
/// a library that satisfies the [visitor] callback.
///
/// If no such library is found, returns null.
///
/// **Note :**
///
/// There are two kind of imports :
/// - Immediate imports : imports that are directly made by the library. These
/// can be accessed using [LibraryElement.importedLibraries].
/// - Transitive imports : imports that this library indirectly makes because
/// some of the libraries it imports are importing them.
///
/// This function looks in both immediate and transitive imports.
///
LibraryElement? findImportWhere(
  LibraryElement library,
  bool Function(LibraryElement library) visitor,
) {
  // If this library satisfies the [visitor] callback, we return it.
  if (visitor(library)) {
    return library;
  }

  return _findWhere(library, visitor, (l) => l.importedLibraries);
}

/// A helper function for traversing a library's imports or exports in a
/// breadth-first fashion. It takes a [library], a [visitor] callback and a
/// [getLibraries] callback that returns the library's imports or exports.
///
/// This function uses a queue to keep track of the libraries to visit in a
/// breadth-first fashion. It keeps track of the visited libraries using a set
/// to avoid visiting the same library multiple times.
///
/// Returns the first library that satisfies the [visitor] callback or null if
/// no such library is found.
///
LibraryElement? _findWhere(
  LibraryElement library,
  bool Function(LibraryElement library) visitor,
  List<LibraryElement> Function(LibraryElement library) getLibraries,
) {
  final visitedLibraries = <LibraryElement>{};
  final queue = <LibraryElement>[];

  queue.addAll(getLibraries(library));
  visitedLibraries.add(library);

  while (queue.isNotEmpty) {
    final currentLibrary = queue.removeAt(0);

    // If we've already visited this library, we skip it
    if (visitedLibraries.contains(currentLibrary)) {
      continue;
    }

    visitedLibraries.add(currentLibrary);

    // If this library satisfies the [visitor] callback, we return it
    if (visitor(currentLibrary)) {
      return currentLibrary;
    }

    queue.addAll(getLibraries(currentLibrary));
  }

  return null;
}
