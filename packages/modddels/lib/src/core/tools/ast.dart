import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

/// Gets the [AstNode] associated with the [element]. The implementation is
/// taken from freezed.
///
Future<AstNode> tryGetAstNodeForElement(
  Element element,
  BuildStep buildStep,
) async {
  var library = element.library!;

  while (true) {
    try {
      final result = library.session.getParsedLibraryByElement(library)
          as ParsedLibraryResult?;

      return result!.getElementDeclaration(element)!.node;
    } on InconsistentAnalysisException {
      library = await buildStep.resolver.libraryFor(
        await buildStep.resolver.assetIdForElement(element.library!),
      );
    }
  }
}

/// This visitor visits a parameter AST node : either [SimpleFormalParameter] or
/// [DefaultFormalParameter].
///
/// If the parameter has a '@NullFailure' annotation which maskNb matches
/// [maskNb], it returns the source code of its field 'failure' as a String.
///
class NullFailureAstVisitor extends SimpleAstVisitor<String> {
  NullFailureAstVisitor({required this.maskNb, required this.annotatedElement});

  final int? maskNb;

  final Element annotatedElement;

  String? _result;

  @override
  String? visitSimpleFormalParameter(SimpleFormalParameter node) {
    // We visit the children nodes of this parameter, which includes its
    // annotations that will be visited by [visitAnnotation]
    node.visitChildren(this);
    return _result;
  }

  @override
  String? visitDefaultFormalParameter(DefaultFormalParameter node) {
    // We visit the children nodes of this parameter, which includes its
    // annotations that will be visited by [visitAnnotation]
    node.visitChildren(this);
    return _result;
  }

  /// We choose the 'NullFailure' annotation that has the same maskNb as
  /// [maskNb], and we store its 'failure' field in [_result]
  ///
  @override
  Null visitAnnotation(Annotation node) {
    if (node.name.name != 'NullFailure') {
      return null;
    }

    final arguments = node.childEntities.toList()[2] as ArgumentList;

    final maskNbArgument = arguments.childEntities
        .whereType<NamedExpression>()
        .firstWhereOrNull(
            (element) => element.name.label.name.trim() == 'maskNb');

    final maskNbValue = maskNbArgument?.expression;

    if (maskNbValue != null && maskNbValue is! IntegerLiteral) {
      throw InvalidGenerationSourceError(
        'The maskNb of the "@NullFailure" annotation, when provided, should be '
        'a literal positive integer, while "$maskNbValue" is not.',
        element: annotatedElement,
      );
    }

    final maskNb =
        maskNbValue != null ? (maskNbValue as IntegerLiteral).value : null;

    if (maskNb == this.maskNb) {
      final failure = arguments.childEntities.toList()[2];
      _result = failure.toString();
    }
    return null;
  }
}
