import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/services.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded text styles.
class AvoidTextStyleLiteral extends Rule with Lint {
  static const _id = 'avoid_text_style_literal';
  static const _message = 'Avoid hardcoded TextStyle values';
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

    if (!textStyleType.isAssignableFromType(returnType)) return;

    reportAstNode(node, message: _message, correction: _correction);
  }
}
