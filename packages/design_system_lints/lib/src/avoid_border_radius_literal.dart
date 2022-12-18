import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid hardcoding BorderRadius.
class AvoidBorderRadiusLiteral extends Rule with Lint {
  static const _id = 'avoid_border_radius_literal';
  static const _message = 'Avoid hardcoded BorderRadius values';
  static const _correction = 'Use values in design system spec instead';

  @override
  LintCode get code => LintCode(_id, package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final returnType = node.constructorName.staticElement?.returnType;

    if (!borderRadiusType.isAssignableFromType(returnType)) return;

    reportAstNode(node, message: _message, correction: _correction);
  }
}
