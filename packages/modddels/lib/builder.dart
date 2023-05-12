import 'package:build/build.dart';
import 'package:modddels/src/modddels_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateModddel(BuilderOptions options) => PartBuilder(
      [ModddelsGenerator()],
      '.modddel.dart',
      header:
          '''
      // coverage:ignore-file
      // GENERATED CODE - DO NOT MODIFY BY HAND
      // ignore_for_file: type=lint
      // ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, prefer_void_to_null, invalid_use_of_protected_member, unnecessary_brace_in_string_interps, unnecessary_cast, unnecessary_null_comparison
      ''',
      options: options,
    );
