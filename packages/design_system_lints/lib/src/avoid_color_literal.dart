import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid hardcoding Color literals.
class AvoidColorLiteral extends LintRule {
  static const _id = 'avoid_color_literal';
  static const _message = 'Avoid Color literal';
  static const _correction = 'Use design system spec instead.';

  @override
  LintCode get code => const LintCode(_id, package: kPackageId);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    final returnType = node.variables.type?.type;

    if (!color.isAssignableFromType(returnType)) return;

    reportLint(node, message: _message, correction: _correction);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final returnType = node.constructorName.staticElement?.returnType;

    if (!color.isAssignableFromType(returnType)) return;

    reportLint(node, message: _message, correction: _correction);
  }
}
