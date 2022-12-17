import 'package:analyzer/dart/ast/ast.dart';
import 'package:design_system_lints/src/utils.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded height and width in SizedBoxes.
class AvoidSizedBoxHeightWidthLiterals extends Rule with Lint {
  static const _id = 'avoid_sized_box_height_width_literals';
  static const _message = 'Avoid using hardcoded height or width values.';
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

    if (sizedBoxType.isAssignableFromType(element?.returnType)) {
      final argNames = ['width', 'height'];
      final arguments = node.argumentList.arguments
          .whereType<NamedExpression>()
          .where((exp) => argNames.any((name) => name == exp.name.label.name));

      for (var argument in arguments) {
        final exp = argument.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          reportAstNode(exp, message: _message, correction: _correction);
        } else if (exp is Identifier) {
          if (!hasDesignSystemAnnotation(exp.staticElement)) {
            reportAstNode(exp, message: _message, correction: _correction);
          }
        }
      }
    }
  }
}
