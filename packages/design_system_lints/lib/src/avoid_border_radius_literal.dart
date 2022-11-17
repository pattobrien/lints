import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidBorderRadiusLiteral extends LintRule with LintVisitor {
  @override
  RuleCode get code =>
      LintCode('avoid_border_radius_literal', package: kDesignSystemPackageId);

  @override
  Uri get url => kUri;

  @override
  SidecarVisitor initializeVisitor(NodeRegistry registry) {
    final visitor = _Visitor();
    registry.addInstanceCreationExpression(this, visitor);
    return visitor;
  }
}

class _Visitor extends SidecarVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (borderRadiusType.isAssignableFromType(element?.returnType)) {
      reportAstNode(
        node,
        message: 'Avoid BorderRadius literal.',
        correction: 'Use design system spec instead.',
      );
    }
    super.visitInstanceCreationExpression(node);
  }
}
