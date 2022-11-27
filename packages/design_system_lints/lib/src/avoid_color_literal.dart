import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidColorLiteral extends SidecarAstVisitor with Lint {
  @override
  LintCode get code => LintCode('avoid_color_literal', package: kPackageId);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

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
