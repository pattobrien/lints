import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart' hide TypeChecker;
import 'package:sidecar_package_utilities/sidecar_package_utilities.dart';

import 'constants.dart';

/// Avoid hardcoding Color literals.
class AvoidColorLiteral extends Rule with Lint {
  static const _id = 'avoid_color_literal';
  static const _message = 'Avoid Color literal';
  static const _correction = 'Use design system spec instead.';

  @override
  LintCode get code => const LintCode(_id, package: kPackageId);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final typeChecker = TypeChecker.fromDartType('Color', dartPackage: 'ui');
    final returnType = node.constructorName.staticElement?.returnType;

    if (!typeChecker.isAssignableFromType(returnType)) return;

    reportAstNode(node, message: _message, correction: _correction);
  }
}
