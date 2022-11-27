import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded Icons.
class AvoidIconLiteral extends SidecarAstVisitor with Lint {
  @override
  LintCode get code =>
      LintCode('avoid_icon_literal', package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addPrefixedIdentifier(this);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    // final isIconData = _isIconData(node.prefix.staticElement);
    // final type = node.identifier.staticType;
    // if (iconDataType.isAssignableFromType(type)) {
    //   final matchingAnnotation = node.thisOrAncestorMatching((astNode) {
    //     final isMatch = astNode is AnnotatedNode &&
    //         astNode.metadata.isNotEmpty &&
    //         annotatedNodes.any((annotation) {
    //           final isSameSource =
    //               annotation.annotatedNode.toSourceSpan(unit) ==
    //                   astNode.toSourceSpan(unit);
    //           return isSameSource &&
    //               annotation.input.packageName == kDesignSystemPackageId;
    //         });
    //     return isMatch;
    //   });

    //   if (matchingAnnotation == null) {
    //     reportAstNode(
    //       node,
    //       message: 'Avoid IconData literal.',
    //       correction: 'Use design system spec instead.',
    //     );
    //   }
    // }

    return super.visitPrefixedIdentifier(node);
  }
}
