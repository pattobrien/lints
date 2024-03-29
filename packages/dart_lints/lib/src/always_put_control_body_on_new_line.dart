import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

class AlwaysPutControlBodyOnNewLine extends LintRule {
  static const id = 'always_put_control_body_on_new_line';

  static const message = 'Statement should be on a separate line.';
  static const correction = 'Try moving the statement to a new line.';

  @override
  LintCode get code => const LintCode(id, package: kPackageId, url: kUri + id);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry
      ..addDoStatement(this)
      ..addForStatement(this)
      ..addIfStatement(this)
      ..addWhileStatement(this);
  }

  @override
  void visitDoStatement(DoStatement node) {
    _checkNodeOnNextLine(node.body, node.doKeyword.end);
  }

  @override
  void visitForStatement(ForStatement node) {
    _checkNodeOnNextLine(node.body, node.rightParenthesis.end);
  }

  @override
  void visitIfStatement(IfStatement node) {
    _checkNodeOnNextLine(node.thenStatement, node.rightParenthesis.end);
    final elseKeyword = node.elseKeyword;
    final elseStatement = node.elseStatement;
    if (elseKeyword != null && elseStatement is! IfStatement) {
      _checkNodeOnNextLine(elseStatement, elseKeyword.end);
    }
  }

  @override
  void visitWhileStatement(WhileStatement node) {
    _checkNodeOnNextLine(node.body, node.rightParenthesis.end);
  }

  void _checkNodeOnNextLine(AstNode? node, int controlEnd) {
    if (node == null || node is Block && node.statements.isEmpty) return;

    final unit = node.root as CompilationUnit;
    final offsetFirstStatement =
        node is Block ? node.statements.first.offset : node.offset;
    final lineInfo = unit.lineInfo;
    if (lineInfo.getLocation(controlEnd).lineNumber ==
        lineInfo.getLocation(offsetFirstStatement).lineNumber) {
      reportLint(node.beginToken, message: message, correction: correction);
    }
  }
}
