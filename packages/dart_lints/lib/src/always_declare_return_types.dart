import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

class AlwaysDeclareReturnTypes extends LintRule {
  static const id = 'always_declare_return_types';

  String functionMessage(String functionName) =>
      "The function $functionName should have a return type but doesn't.";
  static const functionCorrection = 'Try adding a return type to the function.';

  String methodMessage(String functionName) =>
      "The method $functionName should have a return type but doesn't.";
  static const methodCorrection = 'Try adding a return type to the method.';

  @override
  LintCode get code => const LintCode(id, package: kPackageId, url: kUri + id);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry
      ..addFunctionDeclaration(this)
      ..addFunctionTypeAlias(this)
      ..addMethodDeclaration(this);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (!node.isSetter && node.returnType == null) {
      reportLint(node.name2,
          message: functionMessage(node.name2.lexeme),
          correction: functionCorrection);
    }
  }

  @override
  void visitFunctionTypeAlias(FunctionTypeAlias node) {
    if (node.returnType != null) return;

    reportLint(node.name2,
        message: functionMessage(node.name2.lexeme),
        correction: functionCorrection);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (!node.isSetter &&
        node.returnType == null &&
        node.name2.type != TokenType.INDEX_EQ) {
      reportLint(node.name2,
          message: methodMessage(node.name2.lexeme),
          correction: methodCorrection);
    }
  }
}
