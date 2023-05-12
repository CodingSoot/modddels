import 'package:fpdart/fpdart.dart';
import 'package:collection/collection.dart';
import 'package:modddels/src/core/info/parameters_info/_parameter_kind.dart';
import 'package:modddels/src/core/info/parameters_info/_unresolved_parameters_info_exception.dart';
import 'package:modddels/src/core/info/parameters_info/modddel/modddel_parameters_info.dart';
import 'package:modddels/src/core/info/parameters_info/ssealed/shared_parameter.dart';
import 'package:modddels/src/core/parsed_annotations/parsed_shared_prop.dart';
import 'package:modddels/src/core/templates/parameters/parameter.dart';

/// This is a resolver that creates the [SharedParameter]s of an annotated
/// super-sealed class, and splits them into shared dependency parameters and
/// shared member parameters.
///
class SSealedParametersInfoResolver {
  SSealedParametersInfoResolver._({
    required this.sharedParameters,
    required this.sharedDependencyParameters,
    required this.sharedMemberParameters,
  });

  /// Creates the [SharedParameter]s of the annotated super-sealed class and
  /// splits them into shared dependency parameters and shared member
  /// parameters.
  ///
  /// ## Parameters :
  ///
  /// - [caseModddelsParametersInfos] : A list that contains the
  ///   [ModddelParametersInfo] of each case-modddel.
  ///
  /// ## How it works :
  ///
  /// 1. We verify that the shared properties are unique.
  /// 2. We collect the parameters of all case-modddels from
  ///    [caseModddelsParametersInfos].
  /// 3. We verify that the shared properties (represented by
  ///    [parsedSharedProps]) have parameters in all case-modddels, and that
  ///    they are all of the same kind.
  /// 4. We create the [SharedParameter]s.
  /// 5. We split them by their kind.
  ///
  factory SSealedParametersInfoResolver.resolve({
    required List<ParsedSharedProp> parsedSharedProps,
    required List<ModddelParametersInfo> caseModddelsParametersInfos,
  }) {
    // 1.

    parsedSharedProps.forEachIndexed((index, parsedSharedProp) {
      final parsedSharedPropName = parsedSharedProp.name;
      if (parsedSharedProps.lastIndexWhere(
              (element) => element.name == parsedSharedPropName) !=
          index) {
        throw UnresolvedParametersInfoException(
            'There is more than one shared prop with the name '
            '"$parsedSharedPropName".');
      }
    });

    // 2.

    // A list of the list of parameters of each case-modddel.
    final List<List<_ParameterWithKind>> parametersLists =
        caseModddelsParametersInfos.map((parametersInfo) {
      final dependencyParameters =
          parametersInfo.dependencyParametersTemplate.allParameters;

      final memberParameters =
          parametersInfo.memberParametersTemplate.allParameters;

      return [
        ...dependencyParameters
            .map((p) => Tuple2(p, ParameterKind.dependencyParameter)),
        ...memberParameters
            .map((p) => Tuple2(p, ParameterKind.memberParameter)),
      ];
    }).toList();

    final sharedParameters = parsedSharedProps.map((parsedSharedProp) {
      // 3.

      // For each case-modddel, we check that there is a parameter for the
      // shared property, and we collect it.
      final List<_ParameterWithKind> caseParameters =
          parametersLists.map((params) {
        final caseParam = params
            .singleWhereOrNull((p) => p.first.name == parsedSharedProp.name);
        if (caseParam == null) {
          throw UnresolvedParametersInfoException(
              'The shared prop "${parsedSharedProp.name}" should be present in '
              'all case-modddels.');
        }
        return caseParam;
      }).toList();

      final parameterKind = _assertSameKind(
        caseParameters: caseParameters,
        parsedSharedProp: parsedSharedProp,
      );

      // 4.
      return SharedParameter(
        name: parsedSharedProp.name,
        type: parsedSharedProp.type,
        ignoreValidTransformation: parsedSharedProp.ignoreValidTransformation,
        ignoreNonNullTransformation:
            parsedSharedProp.ignoreNonNullTransformation,
        ignoreNullTransformation: parsedSharedProp.ignoreNullTransformation,
        caseParameters: caseParameters.map((p) => p.first).toList(),
        parameterKind: parameterKind,
      );
    }).toList();

    // 5.
    final groupedSharedParameters = sharedParameters
        .groupListsBy((sharedParam) => sharedParam.parameterKind);

    return SSealedParametersInfoResolver._(
      sharedParameters: sharedParameters,
      sharedDependencyParameters:
          groupedSharedParameters[ParameterKind.dependencyParameter] ?? [],
      sharedMemberParameters:
          groupedSharedParameters[ParameterKind.memberParameter] ?? [],
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
}

/// A parameter and its kind.
///
typedef _ParameterWithKind = Tuple2<Parameter, ParameterKind>;

/// Asserts that the [caseParameters] have the same [ParameterKind],
/// and returns it.
///
ParameterKind _assertSameKind({
  required List<_ParameterWithKind> caseParameters,
  required ParsedSharedProp parsedSharedProp,
}) {
  final paramKinds = caseParameters.map((p) => p.second).toSet();

  final paramKind = paramKinds.singleOrNull;

  if (paramKind == null) {
    throw UnresolvedParametersInfoException(
      'The shared prop "${parsedSharedProp.name}" should be of the same kind '
      'across all case-modddels.',
    );
  }
  return paramKind;
}
