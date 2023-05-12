import 'package:modddels/src/core/templates/class_members/getter.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';

/// This class represents a property of a class.
///
/// In this package, a [Property] is always a final instance variable (since
/// we're only dealing with immutable classes).
///
class Property {
  Property({
    required this.name,
    required this.type,
    required this.decorators,
    required this.doc,
    required this.isLate,
  });

  factory Property.fromParameter(Parameter parameter, {bool isLate = false}) {
    return Property(
      name: parameter.name,
      type: parameter.type,
      decorators: parameter.decorators,
      doc: parameter.doc,
      isLate: isLate,
    );
  }

  /// The name of this property.
  ///
  final String name;

  /// The type of this property.
  ///
  final String type;

  /// The list of decorators of this property.
  ///
  final List<String> decorators;

  /// The documentation of this property.
  ///
  final String doc;

  /// Whether this property is late.
  ///
  final bool isLate;

  @override
  String toString() {
    final documentation = doc.trimRight();

    var declaration = 'final $type $name;';

    if (isLate) {
      declaration = 'late $declaration';
    }
    return '$documentation\n${decorators.join()} $declaration';
  }

  /// Returns a copy of this property with additional modifiers based on the
  /// specified parameters.
  ///
  /// If [addOverrideAnnotation] is true, the '@override' annotation will be
  /// added to the list of decorators. If [removeDoc] is true, the documentation
  /// will be cleared from the copied property.
  ///
  /// If both [addOverrideAnnotation] and [removeDoc] are false, then the
  /// returned property will be an exact copy of the original property.
  ///
  Property copyWithModifiers({
    bool addOverrideAnnotation = false,
    bool removeDoc = false,
  }) {
    return copyWith(
      decorators: [if (addOverrideAnnotation) '@override', ...decorators],
      doc: removeDoc ? '' : doc,
    );
  }

  /// Converts this property to a [Getter].
  ///
  /// You can provide the getter's [implementation], or keep it null if the
  /// getter doesn't have an implementation. See [Getter.implementation].
  ///
  Getter toGetter({required String? implementation}) => Getter(
        name: name,
        type: type,
        decorators: decorators,
        doc: doc,
        implementation: implementation,
      );

  /// **NB :** Copying with null values is not implemented.
  ///
  Property copyWith({
    String? name,
    String? type,
    List<String>? decorators,
    String? doc,
    bool? isLate,
  }) {
    return Property(
      name: name ?? this.name,
      type: type ?? this.type,
      decorators: decorators ?? this.decorators,
      doc: doc ?? this.doc,
      isLate: isLate ?? this.isLate,
    );
  }
}

extension PropretiesListAs on List<Property> {
  /// Returns a copy of this list of properties with additional modifiers based
  /// on the specified parameters.
  ///
  /// If [addOverrideAnnotation] is true, the '@override' annotation will be
  /// added to the [Property.decorators] of each copied property. If [removeDoc]
  /// is true, the documentation of each property will be cleared from the
  /// copied list of properties.
  ///
  /// If both [addOverrideAnnotation] and [removeDoc] are false, then the
  /// returned list of properties will be an exact copy of the original list of
  /// properties.
  ///
  List<Property> copyWithModifiers({
    bool addOverrideAnnotation = false,
    bool removeDoc = false,
  }) {
    return map((p) => p.copyWithModifiers(
        addOverrideAnnotation: addOverrideAnnotation,
        removeDoc: removeDoc)).toList();
  }
}
