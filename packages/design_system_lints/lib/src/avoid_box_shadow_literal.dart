import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

final _code =
    LintCode('avoid_box_shadow_literal', package: kPackageId, url: kUrl);

class AvoidBoxShadowLiteral extends SidecarAstVisitor with Lint {
  @override
  LintCode get code => _code;

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (boxShadowType.isAssignableFromType(element?.returnType)) {
      reportAstNode(
        node,
        message: 'Avoid BoxShadow literal',
        correction: 'Use design system spec instead.',
      );
    }
    super.visitInstanceCreationExpression(node);
  }
}
