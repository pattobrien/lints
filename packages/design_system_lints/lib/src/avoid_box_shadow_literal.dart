import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid hardcoding BoxShadows.
class AvoidBoxShadowLiteral extends Rule with Lint {
  static const _id = 'avoid_box_shadow_literal';
  static const _message = 'Avoid BoxShadow literal';
  static const _correction = 'Use values in design system spec instead';

  @override
  LintCode get code => LintCode(_id, package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (boxShadowType.isAssignableFromType(element?.returnType)) {
      reportAstNode(node, message: _message, correction: _correction);
    }
  }
}
