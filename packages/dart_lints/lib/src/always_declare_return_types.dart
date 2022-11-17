import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

final kAlwaysDeclareReturnTypesCode =
    LintCode('always_declare_return_types', package: kPackageId);

class AlwaysDeclareReturnTypes extends LintRule with LintVisitor {
  @override
  RuleCode get code => kAlwaysDeclareReturnTypesCode;

  @override
  Uri get url => kDartUri;

  @override
  SidecarVisitor initializeVisitor(NodeRegistry registry) {
    final visitor = _Visitor();
    registry
      ..addFunctionDeclaration(this, visitor)
      ..addMethodDeclaration(this, visitor)
      ..addFunctionTypeAlias(this, visitor);
    return visitor;
  }
}

class _Visitor extends SidecarVisitor {
  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (!node.isSetter && node.returnType == null) {
      reportToken(node.name2,
          message:
              'The function ${node.name2.lexeme} should have a return type but doesn\'t.',
          correction: 'Try adding a return type to the function.');
    }
  }

  @override
  void visitFunctionTypeAlias(FunctionTypeAlias node) {
    if (node.returnType == null) {
      reportToken(node.name2,
          message:
              'The function ${node.name2.lexeme} should have a return type but doesn\'t.',
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
              'The method ${node.name2.lexeme} should have a return type but doesn\'t.',
          correction: 'Try adding a return type to the method.');
    }
  }
}
