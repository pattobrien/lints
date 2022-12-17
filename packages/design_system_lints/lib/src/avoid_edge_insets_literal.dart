import 'package:analyzer/dart/ast/ast.dart';
import 'package:design_system_lints/src/utils.dart';
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
      final arguments = node.argumentList.arguments;

      for (var argument in arguments) {
        if (argument is Literal) {
          reportAstNode(argument, message: _message, correction: _correction);
        }

        if (argument is NamedExpression) {
          final expression = argument.expression;

          if (isDesignSystemExpression(expression) ?? true) continue;

          reportAstNode(expression, message: _message, correction: _correction);
        }
      }
    }
  }
}
