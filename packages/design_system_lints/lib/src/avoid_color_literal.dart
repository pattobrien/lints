import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidColorLiteral extends LintRule with LintVisitor {
  @override
  RuleCode get code =>
      LintCode('avoid_color_literal', package: kDesignSystemPackageId);

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
    // if (colorType.isAssignableFromType(element?.returnType)) {
    //   reportAstNode(
    //     node,
    //     message: 'Avoid Color literal',
    //     correction: 'Use design system spec instead.',
    //   );
    // }

    super.visitInstanceCreationExpression(node);
  }
}
