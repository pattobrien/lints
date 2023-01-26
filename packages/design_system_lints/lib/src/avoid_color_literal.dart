import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:design_system_lints/src/utils.dart';
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
  void initializeVisitor(NodeRegistry registry) => registry
    ..addInstanceCreationExpression(this)
    ..addVariableDeclarationStatement(this)
    ..addPrefixedIdentifier(this)
    ..addVariableDeclaration(this)
    ..addArgumentList(this)
    ..addDefaultFormalParameter(this);

  // @override
  // void visitVariableDeclarationStatement(VariableDeclarationStatement node) {
  //   final returnType = node.variables.type?.type;

  //   if (color.isNotAssignableFromType(returnType)) return;

  //   // if (isDesignSystemExpression(node.) ?? true) return;

  //   reportLint(node, message: _message, correction: _correction);
  // }

  @override
  void visitArgumentList(ArgumentList node) {
    // final visitor = ExpressionVisitor();
    for (final argument in node.arguments) {
      if (color.isNotAssignableFromType(argument.staticType)) continue;

      if (isDesignSystemExpression(argument) ?? true) continue;

      // final results = argument.accept(visitor) ?? [];
      // for (final x in results) {
      reportLint(argument, message: _message);
      // }
    }
  }

  @override
  void visitDefaultFormalParameter(DefaultFormalParameter node) {
    if (color.isNotAssignableFromType(node.defaultValue?.staticType)) return;

    if (isDesignSystemExpression(node.defaultValue) ?? true) return;

    reportLint(node.defaultValue!, message: _message);
  }

  // @override
  // void visitVariableDeclaration(VariableDeclaration node) {
  //   if (color.isNotAssignableFromType(node.declaredElement2?.type)) return;
  //   final val = isDesignSystemExpression(node.initializer);
  //   if (val ?? true) return;

  //   if (hasDesignSystemAnnotation(node.declaredElement2) ?? true) return;

  //   reportLint(node, message: _message);
  // }

  // @override
  // void visitPrefixedIdentifier(PrefixedIdentifier node) {
  //   if (color.isNotAssignableFromType(node.staticType)) return;

  //   if (isDesignSystemExpression(node) ?? true) return;

  //   // reportLint(node, message: _message, correction: _correction);
  // }

  // @override
  // void visitInstanceCreationExpression(InstanceCreationExpression node) {
  //   final returnType = node.constructorName.staticElement?.returnType;

  //   if (color.isNotAssignableFromType(returnType)) return;

  //   if (isDesignSystemExpression(node) ?? true) return;

  //   reportLint(node, message: _message, correction: _correction);
  // }
}
