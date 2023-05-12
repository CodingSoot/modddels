import 'package:modddels/src/core/templates/declaration_template.dart';

/// In the context of a Union of modddels, the fields of the mixins may have
/// different types across the different case-modddels. To avoid type mismatch
/// between fields during multi-inheritance using mixins, the mixins don't
/// contain the fields themselves, but rather they implement an interface (an
/// abstract class) that contains those fields. We call this kind of interfaces
/// a **FieldsInterface**.
///
/// The [FieldsInterfaceTemplate] is a template for a FieldsInterface, followed
/// by the declaration of the mixin [mixinDeclaration].
///
/// For example :
///
/// ```dart
/// abstract class _$InvalidWeatherValueFields {
///   num get temperature;
///   WeatherHabitableFailure get habitableFailure;
/// }
///
/// mixin InvalidWeatherValue
///     implements InvalidWeather, _$InvalidWeatherValueFields
/// ```
///
/// If the [fields] is an empty string (after being trimmed), the
/// FieldsInterface is not needed, thus the template will only contain the
/// [mixinDeclaration].
///
/// ```dart
/// mixin InvalidWeatherValue implements InvalidWeather
/// ```
///
class FieldsInterfaceTemplate {
  FieldsInterfaceTemplate.wrapDeclaration({
    required this.mixinDeclaration,
    required this.fields,
  });

  /// The declaration of the mixin.
  ///
  final MixinDeclarationTemplate mixinDeclaration;

  /// The [fields] of the mixin that should be held inside the
  /// "FieldsInterface".
  ///
  /// If it's an empty string (after being trimmed), the FieldsInterface is not
  /// needed, thus the template will only contain the [mixinDeclaration].
  ///
  final String fields;

  /// The name of the mixin.
  ///
  String get mixinName => mixinDeclaration.className;

  /// The name of the FieldsInterface.
  ///
  String get interfaceName => '_\$${mixinName}Fields';

  @override
  String toString() {
    if (fields.trim().isEmpty) {
      return mixinDeclaration.toString();
    }

    final declaration = mixinDeclaration.appendImplementsClass(interfaceName);

    return '''
    abstract class $interfaceName {
      $fields
    }

    $declaration
    ''';
  }
}
