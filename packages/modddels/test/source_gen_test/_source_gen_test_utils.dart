import 'package:meta/meta.dart';
import 'package:modddels/src/modddels_generator.dart';
import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

/// Easily create a test group for testing a file using source_gen_test.
///
class TestSource {
  TestSource({
    required this.sourceDirectory,
    required this.fileName,
  });

  final String sourceDirectory;

  final String fileName;

  late final LibraryReader reader;

  Future<void> init() async {
    reader =
        await initializeLibraryReaderForDirectory(sourceDirectory, fileName);
  }

  @isTestGroup
  void testGroup(description) {
    // ignore: prefer_function_declarations_over_variables
    final body =
        () => testAnnotatedElements<Modddel>(reader, ModddelsGenerator());

    group(
      description,
      body,
    );
  }
}

Future<void> initializeReaders(List<TestSource> sourceTests) async {
  await Future.wait(sourceTests.map((s) => s.init()));
}
