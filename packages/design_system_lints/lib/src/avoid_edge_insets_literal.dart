import 'package:analyzer/dart/ast/ast.dart';
import 'package:design_system_lints/src/utils.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded EdgeInsets.
class AvoidEdgeInsetsLiteral extends Rule with Lint {
  static const _id = 'avoid_edge_insets_literal';
  static const _message = 'Avoid hardcoded EdgeInsets values';
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

    if (!edgeInsets.isAssignableFromType(returnType)) return;

    for (final arg in node.argumentList.arguments) {
      if (arg is Literal) {
        reportAstNode(arg, message: _message, correction: _correction);
        continue;
      }

      if (isDesignSystemExpression(arg) ?? true) continue;

      if (arg is NamedExpression) {
        reportAstNode(arg.expression,
            message: _message, correction: _correction);
      } else {
        reportAstNode(arg, message: _message, correction: _correction);
      }
    }
  }
}
