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
  LintCode get code => const LintCode(_id, package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final returnType = node.constructorName.staticElement?.returnType;

    if (!boxShadowType.isAssignableFromType(returnType)) return;

    reportAstNode(node, message: _message, correction: _correction);
  }
}
