import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_analyzer_utils/painting.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded EdgeInsets.
class AvoidEdgeInsetsLiteral extends Rule with Lint {
  static const _id = 'avoid_edge_insets_literal';
  static const _message = 'Avoid hardcoded EdgeInsets values';
  static const _correction = 'Use values in design system spec instead';

  static const _sizeArgs = [
    'vertical',
    'horizontal',
    'left',
    'right',
    'top',
    'bottom'
  ];

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
          .where((e) => _sizeArgs.any((arg) => arg == e.name.label.name));

      for (var arg in args) {
        final exp = arg.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          reportAstNode(exp, message: _message, correction: _correction);
        }
        // e.g. CustomTheme.smallInsets()
        if (exp is PrefixedIdentifier) {
          //to do this computation, or is there a way to do this via ASTs only?
          final declaration = exp.staticElement?.declaration;
          if (declaration is PropertyAccessorElement) {
            // final y = ele.declaration.constantInitializer;
            final x = declaration.variable.isConstantEvaluated;
            final y = x;
          }
          if (declaration is ParameterElement) {
            final x = declaration;
          }
          final element = exp.staticType?.element2;
          final node = declaration;
          // final x = ele.canonicalElement;
          //   final x =
        }
        // e.g. smallInsets()
        if (exp is SimpleIdentifier) {
          final element = exp.staticType?.element2;
          // final x = element;

        }
      }
    }
  }
}
