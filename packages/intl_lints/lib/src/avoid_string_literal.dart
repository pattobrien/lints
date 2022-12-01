import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Locates all strings.
///
/// Used as a simple lint rule for running automated tests on Sidecar package.
class AvoidStringLiteral extends Rule with Lint {
  static const _id = 'avoid_string_literal';
  static const _message = 'Avoid any hardcoded Strings in Text widgets';
  static const _correction = 'Prefer to use a translated Intl message instead.';

  @override
  LintCode get code => LintCode(_id, package: packageId, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addSimpleStringLiteral(this);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    reportAstNode(node, message: _message, correction: _correction);
  }
}
