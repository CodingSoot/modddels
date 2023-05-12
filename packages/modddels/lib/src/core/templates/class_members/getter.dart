import 'package:modddels/src/core/templates/parameters/parameter.dart';

enum ImplementationKind {
  regular,
  arrow,
}

/// This class represents a getter.
///
class Getter {
  Getter({
    required this.name,
    required this.type,
    required this.implementation,
    this.implementationKind = ImplementationKind.arrow,
    this.decorators = const [],
    this.doc = '',
  });

  factory Getter.fromParameter(
    Parameter parameter, {
    required String? implementation,
    ImplementationKind implementationKind = ImplementationKind.arrow,
  }) {
    return Getter(
      name: parameter.name,
      type: parameter.type,
      decorators: parameter.decorators,
      doc: parameter.doc,
      implementation: implementation,
      implementationKind: implementationKind,
    );
  }

  /// The name of this getter.
  ///
  final String name;

  /// The return type of this getter.
  ///
  final String type;

  /// The list of decorators of this getter.
  ///
  final List<String> decorators;

  /// The documentation of this getter.
  ///
  final String doc;

  /// The body of the getter.
  ///
  /// If null, the getter has no implementation.
  ///
  final String? implementation;

  /// The kind of the [implementation]. It can either be :
  ///
  /// - [ImplementationKind.regular] : The [implementation] should be surrounded
  ///   by curly braces "{}".
  /// - [ImplementationKind.arrow] : The [implementation] uses the arrow syntax
  ///   "<=". This is the default.
  ///
  final ImplementationKind implementationKind;

  @override
  String toString() {
    final documentation = doc.trimRight();

    final res = '$documentation\n${decorators.join()} $type get $name';

    if (implementation == null) {
      return '$res;';
    }

    switch (implementationKind) {
      case ImplementationKind.regular:
        return '''
        $res {
          $implementation
        }
        ''';
      case ImplementationKind.arrow:
        return '$res => $implementation;';
    }
  }

  /// Returns a copy of this getter with additional modifiers based on the
  /// specified parameters.
  ///
  /// If [addOverrideAnnotation] is true, the '@override' annotation will be
  /// added to the list of decorators. If [removeDoc] is true, the documentation
  /// will be cleared from the copied getter.
  ///
  /// If both [addOverrideAnnotation] and [removeDoc] are false, then the
  /// returned getter will be an exact copy of the original getter.
  ///
  Getter copyWithModifiers({
    bool addOverrideAnnotation = false,
    bool removeDoc = false,
  }) {
    return copyWith(
      decorators: [if (addOverrideAnnotation) '@override', ...decorators],
      doc: removeDoc ? '' : doc,
    );
  }

  /// **NB :** Copying with null values is not implemented.
  ///
  Getter copyWith({
    String? name,
    String? type,
    List<String>? decorators,
    String? doc,
    String? implementation,
    ImplementationKind? implementationKind,
  }) {
    return Getter(
      name: name ?? this.name,
      type: type ?? this.type,
      decorators: decorators ?? this.decorators,
      doc: doc ?? this.doc,
      implementation: implementation ?? this.implementation,
      implementationKind: implementationKind ?? this.implementationKind,
    );
  }
}

extension GettersListAs on List<Getter> {
  /// Returns a copy of this list of getters with additional modifiers based on
  /// the specified parameters.
  ///
  /// If [addOverrideAnnotation] is true, the '@override' annotation will be
  /// added to the [Getter.decorators] of each copied getter. If [removeDoc] is
  /// true, the documentation of each getter will be cleared from the copied
  /// list of getters.
  ///
  /// If both [addOverrideAnnotation] and [removeDoc] are false, then the
  /// returned list of getters will be an exact copy of the original list of
  /// getters.
  ///
  List<Getter> copyWithModifiers({
    bool addOverrideAnnotation = false,
    bool removeDoc = false,
  }) {
    return map((p) => p.copyWithModifiers(
        addOverrideAnnotation: addOverrideAnnotation,
        removeDoc: removeDoc)).toList();
  }
}
