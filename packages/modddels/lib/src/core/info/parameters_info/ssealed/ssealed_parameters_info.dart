import 'package:analyzer/dart/element/element.dart';
import 'package:modddels/src/core/info/parameters_info/_unresolved_parameters_info_exception.dart';
import 'package:modddels/src/core/info/parameters_info/modddel/modddel_parameters_info.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/_ssealed_parameters_info_resolver.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/shared_parameter.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_shared_prop.dart';
import 'package:source_gen/source_gen.dart';

/// Holds information about the shared parameters (shared properties) of an
/// annotated super-sealed class.
///
class SSealedParametersInfo {
  SSealedParametersInfo._({
    required this.sharedParameters,
    required this.sharedDependencyParameters,
    required this.sharedMemberParameters,
  });

  /// ## Parameters :
  ///
  /// - [caseModddelsParametersInfos] : A list that contains the
  ///   [ModddelParametersInfo] of each case-modddel.
  ///
  factory SSealedParametersInfo.fromParsedSharedProps({
    required List<ParsedSharedProp> parsedSharedProps,
    required List<ModddelParametersInfo> caseModddelsParametersInfos,
    required ClassElement annotatedClass,
  }) {
    final SSealedParametersInfoResolver resolver;

    try {
      resolver = SSealedParametersInfoResolver.resolve(
        parsedSharedProps: parsedSharedProps,
        caseModddelsParametersInfos: caseModddelsParametersInfos,
      );
    } on UnresolvedParametersInfoException catch (exception) {
      throw InvalidGenerationSourceError(
        exception.toString(),
        element: annotatedClass,
      );
    }

    return SSealedParametersInfo._(
      sharedParameters: resolver.sharedParameters,
      sharedDependencyParameters: resolver.sharedDependencyParameters,
      sharedMemberParameters: resolver.sharedMemberParameters,
    );
  }

  /// Contains all shared parameters.
  ///
  final List<SharedParameter> sharedParameters;

  /// Contains shared dependency parameters.
  ///
  final List<SharedParameter> sharedDependencyParameters;

  /// Contains shared member parameters.
  ///
  final List<SharedParameter> sharedMemberParameters;

  /// Whether the annotated super-sealed class has any shared dependency
  /// parameters.
  ///
  bool get hasDependencyParameters => sharedDependencyParameters.isNotEmpty;

  /// Whether the parameter named [paramName] is a shared parameter.
  ///
  bool isSharedParam(String paramName) =>
      sharedParameters.any((sharedParam) => sharedParam.name == paramName);
}
