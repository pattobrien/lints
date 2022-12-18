import 'package:analyzer/dart/ast/ast.dart';
import 'package:design_system_lints/src/utils.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded Icons.
class AvoidIconLiteral extends Rule with Lint {
  static const _id = 'avoid_icon_literal';
  static const _message = 'Avoid using Icons or IconData literals';
  static const _correction = 'Use values in design system spec instead';

  @override
  LintCode get code => const LintCode(_id, package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addPrefixedIdentifier(this);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    if (!iconDataType.isAssignableFromType(node.staticType)) return;

    if (hasDesignSystemAnnotation(node.staticElement) ?? true) return;

    reportAstNode(node, message: _message, correction: _correction);
  }
}
