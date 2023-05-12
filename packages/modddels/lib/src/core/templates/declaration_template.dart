/// The [DeclarationTemplate] is a template that represents the declaration of
/// a class or a mixin.
///
abstract class DeclarationTemplate {
  /// The name of the declared class or mixin.
  ///
  String get className;

  /// The list of classes following the `implements` keyword.
  ///
  List<String> get implementsClasses;

  /// Adds the given [implementsClass] to the end of [implementsClasses].
  ///
  DeclarationTemplate appendImplementsClass(String implementsClass);
}

/* -------------------------------------------------------------------------- */
/*                                 Subclasses                                 */
/* -------------------------------------------------------------------------- */

/// The [ClassDeclarationTemplate] is a template that represents the declaration
/// of a class.
///
class ClassDeclarationTemplate extends DeclarationTemplate {
  ClassDeclarationTemplate({
    required this.className,
    required this.isAbstract,
    this.extendsClasses = const [],
    this.withClasses = const [],
    this.implementsClasses = const [],
  });

  /// The name of the declared class.
  ///
  @override
  final String className;

  @override
  final List<String> implementsClasses;

  /// Whether the declared class is abstract.
  ///
  final bool isAbstract;

  /// The list of classes following the `extends` keyword.
  ///
  final List<String> extendsClasses;

  /// The list of classes following the `with` keyword.
  ///
  final List<String> withClasses;

  @override
  String toString() {
    final buffer = StringBuffer();

    if (isAbstract) {
      buffer.write('abstract ');
    }

    buffer.write('class $className');

    if (extendsClasses.isNotEmpty) {
      buffer.write(' extends ');
      buffer.writeAll(extendsClasses, ', ');
    }

    if (withClasses.isNotEmpty) {
      buffer.write(' with ');
      buffer.writeAll(withClasses, ', ');
    }

    if (implementsClasses.isNotEmpty) {
      buffer.write(' implements ');
      buffer.writeAll(implementsClasses, ', ');
    }

    return buffer.toString();
  }

  @override
  ClassDeclarationTemplate appendImplementsClass(String implementsClass) {
    return copyWith(
      implementsClasses: [...implementsClasses, implementsClass],
    );
  }

  ClassDeclarationTemplate copyWith({
    String? className,
    List<String>? implementsClasses,
    bool? isAbstract,
    List<String>? extendsClasses,
    List<String>? withClasses,
  }) {
    return ClassDeclarationTemplate(
      className: className ?? this.className,
      implementsClasses: implementsClasses ?? this.implementsClasses,
      isAbstract: isAbstract ?? this.isAbstract,
      extendsClasses: extendsClasses ?? this.extendsClasses,
      withClasses: withClasses ?? this.withClasses,
    );
  }
}

/// The [MixinDeclarationTemplate] is a template that represents the declaration
/// of a mixin.
///
class MixinDeclarationTemplate extends DeclarationTemplate {
  MixinDeclarationTemplate({
    required this.className,
    this.implementsClasses = const [],
    this.onClasses = const [],
  });

  /// The name of the declared mixin.
  ///
  @override
  final String className;

  @override
  final List<String> implementsClasses;

  /// The list of classes following the `on` keyword.
  ///
  final List<String> onClasses;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write('mixin $className');

    if (onClasses.isNotEmpty) {
      buffer.write(' on ');
      buffer.writeAll(onClasses, ', ');
    }

    if (implementsClasses.isNotEmpty) {
      buffer.write(' implements ');
      buffer.writeAll(implementsClasses, ', ');
    }

    return buffer.toString();
  }

  @override
  MixinDeclarationTemplate appendImplementsClass(String implementsClass) {
    return copyWith(
      implementsClasses: [...implementsClasses, implementsClass],
    );
  }

  MixinDeclarationTemplate copyWith({
    String? className,
    List<String>? implementsClasses,
    List<String>? onClasses,
  }) {
    return MixinDeclarationTemplate(
      className: className ?? this.className,
      implementsClasses: implementsClasses ?? this.implementsClasses,
      onClasses: onClasses ?? this.onClasses,
    );
  }
}
