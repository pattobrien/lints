import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidBorderRadiusLiteral extends SidecarSimpleAstVisitor with LintMixin {
  @override
  LintCode get code => LintCode('avoid_border_radius_literal',
      package: kDesignSystemPackageId, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

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
