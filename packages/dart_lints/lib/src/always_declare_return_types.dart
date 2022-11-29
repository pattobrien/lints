import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

class AlwaysDeclareReturnTypes extends Rule with Lint {
  @override
  LintCode get code => LintCode(
        'always_declare_return_types',
        package: kPackageId,
        url: kDartUri,
      );

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
      reportToken(
        node.name2,
        message:
            "The function ${node.name2.lexeme} should have a return type but doesn't.",
        correction: 'Try adding a return type to the function.',
      );
    }
  }

  @override
  void visitFunctionTypeAlias(FunctionTypeAlias node) {
    if (node.returnType == null) {
      reportToken(node.name2,
          message:
              "The function ${node.name2.lexeme} should have a return type but doesn't.",
          correction: 'Try adding a return type to the function.');
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (!node.isSetter &&
        node.returnType == null &&
        node.name2.type != TokenType.INDEX_EQ) {
      reportToken(node.name2,
          message:
              "The method ${node.name2.lexeme} should have a return type but doesn't.",
          correction: 'Try adding a return type to the method.');
    }
  }
}
