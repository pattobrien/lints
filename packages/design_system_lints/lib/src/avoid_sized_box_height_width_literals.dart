import 'package:analyzer/dart/ast/ast.dart';
import 'package:design_system_lints/src/utils.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded height and width in SizedBoxes.
class AvoidSizedBoxHeightWidthLiterals extends LintRule {
  static const _id = 'avoid_sized_box_height_width_literals';
  static const _message = 'Avoid using hardcoded height or width values.';
  static const _correction = 'Use values in design system spec instead';

  @override
  LintCode get code => const LintCode(_id, package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final returnType = node.constructorName.staticElement?.returnType;
    final checkers = [sizedBox, container];
    if (!TypeChecker.any(checkers).isAssignableFromType(returnType)) return;

    final argNames = ['width', 'height'];
    final arguments = node.argumentList.arguments
        .whereType<NamedExpression>()
        .where((exp) => argNames.any((name) => name == exp.name.label.name));

    for (var arg in arguments) {
      if (isDesignSystemExpression(arg.expression) ?? true) continue;
      reportAstNode(arg.expression, message: _message, correction: _correction);
    }
  }
}
