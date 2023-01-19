import 'package:analyzer/dart/ast/ast.dart';
import 'package:dcm_lints/constants.dart';
import 'package:sidecar/sidecar.dart';

class NoEqualThenElse extends LintRule {
  @override
  LintCode get code => LintCode('no_equal_then_else', package: kPackage);

  static const _warningMessage = 'Then and else branches are equal.';

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry
      ..addIfStatement(this)
      ..addConditionalExpression(this);
  }

  @override
  void visitIfStatement(IfStatement node) {
    super.visitIfStatement(node);

    if (node.elseStatement != null &&
        node.elseStatement is! IfStatement &&
        node.thenStatement.toString() == node.elseStatement.toString()) {
      reportAstNode(node, message: _warningMessage);
    }
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    super.visitConditionalExpression(node);

    if (node.thenExpression.toString() == node.elseExpression.toString()) {
      reportAstNode(node, message: _warningMessage);
    }
  }
}
