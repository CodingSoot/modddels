import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:checks/checks.dart';
import 'package:collection/collection.dart';

import 'integration_test_utils.dart';

/* -------------------------------------------------------------------------- */
/*                 Resolving Libraries for Integration Testing                */
/* -------------------------------------------------------------------------- */

final _rootPackage = 'modddels';

/// Resolves the source code of a temporary Dart library in an integration test
/// environment. The temporary library is created from the provided [main] Dart
/// code string, and is located in the folder
/// "test/integration_test/integration/". Returns a [Future] containing the
/// resolved [LibraryElement] object.
///
/// Example usage:
///
/// ```dart
/// final library = await resolveMain('''
///   // Located in the "test/integration_test/integration/" folder
///   import 'my_library.dart';
///
///   class MyClass {
///     final myObject = MyObject();
///   }
/// ''');
///
/// expect(library.units.first.types.first.name, 'MyClass');
/// ```
///
Future<LibraryElement> resolveMain(String main) async {
  final result = await resolveSources({
    '$_rootPackage|test/integration_test/integration/main.dart': '''
    library main;
    $main
    ''',
  }, (resolver) => resolver.findLibraryByName('main'));

  return result!;
}

/// Resolves the source code of a library with the specified [importName] in an
/// integration test environment. The [importName] must be the name of a file
/// located in the folder "test/integration_test/integration/". Returns a
/// [Future] containing the resolved [LibraryElement] object.
///
/// Example usage:
///
/// ```dart
/// final library = await resolveIntegrationImport('my_library');
///
/// expect(library.units.first.types.first.name, 'MyObject');
/// ```
///
Future<LibraryElement> resolveIntegrationImport(String importName) async {
  final result = await resolveSources(
      {
        '$_rootPackage|test/integration_test/integration/$importName.dart':
            useAssetReader,
      },
      (resolver) => resolver.libraries
          .firstWhere((lib) => lib.source.toString().contains(importName)));

  return result;
}

/* -------------------------------------------------------------------------- */
/*                                   Checks                                   */
/* -------------------------------------------------------------------------- */

extension ErrorChecks<E extends Error> on Subject<E> {
  void isLateInitializationError() =>
      has((e) => e.toString(), 'toString').contains('LateInitializationError');
}

/// Checks that [object] equals [other].
///
/// If [object] and [other] are iterables or maps, deep equality is used.
///
void checkEqualsOrDeepEquals(Object? object, Object? other) {
  if (object is Iterable && other is Iterable) {
    check(object).deepEquals(other);
    return;
  }
  if (object is Map && other is Map) {
    check(object).deepEquals(other);
    return;
  }
  check(object).equals(other);
}

/* -------------------------------------------------------------------------- */
/*                                   Helpers                                  */
/* -------------------------------------------------------------------------- */

/// Mixin for TestHelpers for accessing the different generated elements of a
/// solo modddel.
///
mixin ElementsSoloTestHelperMixin<P extends SampleParamsBase,
    O extends SampleOptionsBase> on TestHelperBase<P, O> {
  // ** Names **

  String get modddelName;

  List<String> get vStepsNames;

  String get topLevelMixinName => '_\$$modddelName';

  String get createMethodName => '_create';

  String get validUnionCaseName => 'Valid$modddelName';

  String get invalidAbstractUnionCaseName => 'Invalid$modddelName';

  String get dependenciesClassName => '_\$${modddelName}Dependencies';

  String get modddelParamsClassName => '${modddelName}Params';

  String getInvalidStepUnionCaseName(int vStepIndex) =>
      'Invalid$modddelName${vStepsNames[vStepIndex]}';

  String getHolderClassName(int vStepIndex) =>
      '_\$$modddelName${vStepsNames[vStepIndex]}Holder';

  String getSubholderClassName(String validationName) =>
      '_Validate$modddelName${validationName.capitalize()}';

  // ** Elements **

  MixinElement getTopLevelMixin(LibraryElement library) {
    return library
        .getTopLevelElementOfTypeAndNamed<MixinElement>(topLevelMixinName);
  }

  MethodElement getCreateMethod(LibraryElement library) {
    final topLevelMixin = getTopLevelMixin(library);

    return topLevelMixin.methods
        .firstWhere((element) => element.name == createMethodName);
  }

  ClassElement getValidUnionCaseClass(LibraryElement library) {
    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(validUnionCaseName);
  }

  MixinElement getInvalidAbstractUnionCaseMixin(LibraryElement library) {
    return library.getTopLevelElementOfTypeAndNamed<MixinElement>(
        invalidAbstractUnionCaseName);
  }

  ClassElement getInvalidStepUnionCaseClass(
    LibraryElement library, {
    required int vStepIndex,
  }) {
    final invalidStepUnionCaseName = getInvalidStepUnionCaseName(vStepIndex);
    return library.getTopLevelElementOfTypeAndNamed<ClassElement>(
        invalidStepUnionCaseName);
  }

  String getInvalidStepCallbackName(int vStepIndex) =>
      'invalid${vStepsNames[vStepIndex]}';

  ClassElement getHolderClass(
    LibraryElement library, {
    required int vStepIndex,
  }) {
    final holderClassName = getHolderClassName(vStepIndex);
    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(holderClassName);
  }

  ClassElement getSubholderClass(
    LibraryElement library, {
    required String validationName,
  }) {
    final subholderClassName = getSubholderClassName(validationName);

    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(subholderClassName);
  }

  ClassElement getDependenciesClass(LibraryElement library) {
    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(dependenciesClassName);
  }

  ClassElement getModddelParamsClass(LibraryElement library) {
    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(modddelParamsClassName);
  }
}

/// Mixin for TestHelpers for accessing the different generated elements of a
/// ssealed modddel.
///
mixin ElementsSSealedTestHelperMixin<P extends SampleParamsBase,
    O extends SampleOptionsBase> on TestHelperBase<P, O> {
  // ** Names **

  String get sSealedName;

  List<String> get vStepsNames;

  String get caseModddelName;

  String get topLevelMixinName => '_\$$sSealedName';

  String get createMethodName => '_create$caseModddelName';

  String get mapModddelsMethodName => 'map$sSealedName';

  String get caseModddelCallbackName => caseModddelName.uncapitalize();

  String get sSealedValidMixinName => 'Valid$sSealedName';

  String get modddelValidUnionCaseName => 'Valid$caseModddelName';

  String get sSealedInvalidMixinName => 'Invalid$sSealedName';

  String get modddelInvalidAbstractUnionCaseName => 'Invalid$caseModddelName';

  String get modddelDependenciesClassName =>
      '_\$${caseModddelName}Dependencies';

  String get sSealedModddelParamsClassName => '${sSealedName}Params';

  String get modddelModddelParamsClassName => '_${caseModddelName}Params';

  String getModddelHolderClassName(int vStepIndex) =>
      '_\$$caseModddelName${vStepsNames[vStepIndex]}Holder';

  String getSSealedSubholderClassName(String validationName) =>
      '_Validate$sSealedName${validationName.capitalize()}';

  String getModddelSubholderClassName(String validationName) =>
      '_Validate$caseModddelName${validationName.capitalize()}';

  String getSSealedInvalidStepMixinName(int vStepIndex) =>
      'Invalid$sSealedName${vStepsNames[vStepIndex]}';

  String getModddelInvalidStepUnionCaseName(int vStepIndex) =>
      'Invalid$caseModddelName${vStepsNames[vStepIndex]}';

  String getInvalidStepCallbackName(int vStepIndex) =>
      'invalid${vStepsNames[vStepIndex]}';

  // ** Elements **

  MixinElement getTopLevelMixin(LibraryElement library) =>
      library.getTopLevelElementOfTypeAndNamed<MixinElement>(topLevelMixinName);

  MixinElement getBaseCaseModddelMixin(LibraryElement library) {
    return library
        .getTopLevelElementOfTypeAndNamed<MixinElement>(caseModddelName);
  }

  MethodElement getCreateMethod(LibraryElement library) {
    final topLevelMixin = getTopLevelMixin(library);

    return topLevelMixin.methods
        .firstWhere((element) => element.name == createMethodName);
  }

  MixinElement getSSealedValidMixin(LibraryElement library) {
    return library
        .getTopLevelElementOfTypeAndNamed<MixinElement>(sSealedValidMixinName);
  }

  ClassElement getModddelValidUnionCaseClass(LibraryElement library) {
    return library.getTopLevelElementOfTypeAndNamed<ClassElement>(
        modddelValidUnionCaseName);
  }

  MixinElement getSSealedInvalidMixin(LibraryElement library) {
    return library.getTopLevelElementOfTypeAndNamed<MixinElement>(
        sSealedInvalidMixinName);
  }

  MixinElement getModddelInvalidAbstractUnionCaseMixin(LibraryElement library) {
    return library.getTopLevelElementOfTypeAndNamed<MixinElement>(
        modddelInvalidAbstractUnionCaseName);
  }

  ClassElement getModddelDependenciesClass(LibraryElement library) {
    return library.getTopLevelElementOfTypeAndNamed<ClassElement>(
        modddelDependenciesClassName);
  }

  ClassElement getSSealedModddelParamsClass(LibraryElement library) {
    return library.getTopLevelElementOfTypeAndNamed<ClassElement>(
        sSealedModddelParamsClassName);
  }

  ClassElement getModddelModddelParamsClass(LibraryElement library) {
    return library.getTopLevelElementOfTypeAndNamed<ClassElement>(
        modddelModddelParamsClassName);
  }

  ClassElement getModddelHolderClass(LibraryElement library,
      {required int vStepIndex}) {
    final holderClassName = getModddelHolderClassName(vStepIndex);

    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(holderClassName);
  }

  ClassElement getSSealedSubholderClass(LibraryElement library,
      {required String validationName}) {
    final subholderClassName = getSSealedSubholderClassName(validationName);

    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(subholderClassName);
  }

  ClassElement getModddelSubholderClass(LibraryElement library,
      {required String validationName}) {
    final subholderClassName = getModddelSubholderClassName(validationName);

    return library
        .getTopLevelElementOfTypeAndNamed<ClassElement>(subholderClassName);
  }

  MixinElement getSSealedInvalidStepMixin(LibraryElement library,
      {required int vStepIndex}) {
    final invalidStepMixinName = getSSealedInvalidStepMixinName(vStepIndex);

    return library
        .getTopLevelElementOfTypeAndNamed<MixinElement>(invalidStepMixinName);
  }

  ClassElement getModddelInvalidStepUnionCaseClass(LibraryElement library,
      {required int vStepIndex}) {
    final invalidStepUnionCaseName =
        getModddelInvalidStepUnionCaseName(vStepIndex);

    return library.getTopLevelElementOfTypeAndNamed<ClassElement>(
        invalidStepUnionCaseName);
  }
}

/* -------------------------------------------------------------------------- */
/*                                    Other                                   */
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
}

extension GetElementFromLibrary on LibraryElement {
  /// Returns the top-level element in this library that is named
  /// [name] and is of type [T].
  ///
  /// Throws if no element found, or more than one element is found.
  ///
  T getTopLevelElementOfTypeAndNamed<T extends Element>(String name) {
    return topLevelElements
        .whereType<T>()
        .singleWhere((element) => element.name == name);
  }
}

extension GetElementFromClassOrMixin on InterfaceElement {
  /// Returns the FieldsInterface class that is implemented by this class /
  /// mixin, or null if no FieldsInterface class is found.
  ///
  InterfaceElement? getFieldsInterface() {
    final fieldsInterfaceName = '_\$${name}Fields';

    return interfaces
        .firstWhereOrNull(
            (element) => element.element.name == fieldsInterfaceName)
        ?.element;
  }

  /// Returns the getter with the specified [name] from this class / mixin.
  /// If no getter with the given name is found, returns null.
  ///
  PropertyAccessorElement? getGetter(String name) {
    return accessors
        .where((element) => element.isGetter)
        .firstWhereOrNull((element) => element.name == name);
  }

  /// Returns the property with the specified [name] from this class / mixin.
  /// If no property with the given name is found, returns null.
  ///
  FieldElement? getProperty(String name) {
    return fields.firstWhereOrNull((element) => element.name == name);
  }
}
