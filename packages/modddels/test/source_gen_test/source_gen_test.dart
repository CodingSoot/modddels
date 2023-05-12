import 'dart:async';
import 'package:source_gen_test/source_gen_test.dart';
import '_source_gen_test_utils.dart';

const sourceDirectory = 'test/source_gen_test/sources';

Future<void> main() async {
  final modddelAnnotationTestSource = TestSource(
      sourceDirectory: sourceDirectory,
      fileName: 'modddel_annotation_src.dart');

  final constructorsTestSource = TestSource(
      sourceDirectory: sourceDirectory, fileName: 'constructors_src.dart');

  final parametersTestSource = TestSource(
      sourceDirectory: sourceDirectory, fileName: 'parameters_src.dart');

  final typeTemplateTestSource = TestSource(
      sourceDirectory: sourceDirectory, fileName: 'type_template_src.dart');

  final validationInfoTestSource = TestSource(
      sourceDirectory: sourceDirectory, fileName: 'validation_info_src.dart');

  final typeAliasTestSource = TestSource(
      sourceDirectory: sourceDirectory, fileName: 'type_alias_src.dart');

  final sharedParametersTestSource = TestSource(
      sourceDirectory: sourceDirectory, fileName: 'shared_parameters_src.dart');

  await initializeReaders([
    modddelAnnotationTestSource,
    constructorsTestSource,
    parametersTestSource,
    typeTemplateTestSource,
    validationInfoTestSource,
    typeAliasTestSource,
    sharedParametersTestSource
  ]);

  initializeBuildLogTracking();

  modddelAnnotationTestSource.testGroup('Modddel Annotation -');

  constructorsTestSource.testGroup('Constructors -');

  parametersTestSource.testGroup('Parameters -');

  typeTemplateTestSource.testGroup('TypeTemplate - ');

  validationInfoTestSource.testGroup('Validation Info - ');

  typeAliasTestSource.testGroup('Type Alias - ');

  sharedParametersTestSource.testGroup('Shared Parameters - ');
}
