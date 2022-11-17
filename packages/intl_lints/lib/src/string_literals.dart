import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

final kStringLiteralsCode =
    LintCode('string_literals', package: kDesignSystemPackageId);

class StringLiterals extends LintRule with LintVisitor {
  @override
  RuleCode get code => kStringLiteralsCode;

  @override
  Uri get url => kUri;

  @override
  SidecarVisitor initializeVisitor(NodeRegistry registry) {
    final visitor = _Visitor();
    registry.addSimpleStringLiteral(this, visitor);
    return visitor;
  }
}

class _Visitor extends SidecarVisitor {
  @override
  void visitStringLiteral(StringLiteral node) {
    reportAstNode(
      node,
      message: 'Avoid any hardcoded Strings.',
      correction: 'Use an intl message instead.',
    );
    super.visitStringLiteral(node);
  }
}
