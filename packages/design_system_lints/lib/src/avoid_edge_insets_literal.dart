import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded EdgeInsets.
class AvoidEdgeInsetsLiteral extends Rule with Lint {
  static const _id = 'avoid_edge_insets_literal';
  static const _message = 'Avoid hardcoded EdgeInsets values';
  static const _correction = 'Use values in design system spec instead';

  @override
  LintCode get code => LintCode(_id, package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (edgeInsetsType.isAssignableFromType(element?.returnType)) {
      final args = node.argumentList.arguments
          .whereType<NamedExpression>()
          .where((e) =>
              e.name.label.name == 'horizontal' ||
              e.name.label.name == 'vertical');

      for (var arg in args) {
        final exp = arg.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          reportAstNode(exp, message: _message, correction: _correction);
        }
        // e.g. CustomTheme.smallInsets()
        // if (exp is PrefixedIdentifier) {
        //   //TODO: dart question: should we be going from AST => Element => AST
        //   //to do this computation, or is there a way to do this via ASTs only?
        //   final ele = exp.staticElement!.declaration;
        //   if (ele is PropertyAccessorElement) {
        //     // final y = ele.declaration.constantInitializer;
        //     final x = ele.variable.isConstantEvaluated;
        //     final y = x;
        //   }
        //   if (ele is ParameterElement) {
        //     final x = ele;
        //   }
        //   final element = exp.staticType?.element2;
        //   final node = ele;
        //   // final x = ele.canonicalElement;
        //   //   final x =
        // }
        // // e.g. smallInsets()
        // if (exp is SimpleIdentifier) {
        //   final element = exp.staticType?.element2;
        //   // final x = element;

        // }
      }
    }
  }
}
