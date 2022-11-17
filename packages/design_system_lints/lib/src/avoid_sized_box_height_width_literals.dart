import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidSizedBoxHeightWidthLiterals extends LintRule with LintVisitor {
  @override
  RuleCode get code => LintCode('avoid_sized_box_height_width_literals',
      package: kDesignSystemPackageId);

  @override
  Uri get url => kUri;

  @override
  SidecarVisitor initializeVisitor(NodeRegistry registry) {
    final visitor = _Visitor();
    registry.addInstanceCreationExpression(this, visitor);
    return visitor;
  }
}

class _Visitor extends SidecarVisitor {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;

    if (sizedBoxType.isAssignableFromType(element?.returnType)) {
      final args = node.argumentList.arguments
          .whereType<NamedExpression>()
          .where((e) =>
              e.name.label.name == 'width' || e.name.label.name == 'height');

      for (var arg in args) {
        final exp = arg.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          reportAstNode(
            exp,
            message:
                'Avoid using height or width literals in SizedBox widgets.',
            correction: 'Use design system spec instead.',
          );
        }
        if (exp is PrefixedIdentifier) {
          //TODO: handle expressions like "SomeClass.staticInteger"
        }
        if (exp is SimpleIdentifier) {
          // final element = exp.staticElement;
          // final x = element;

          //TODO: handle variables that are not declared
          // within the allowed design system spec file
        }
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}
