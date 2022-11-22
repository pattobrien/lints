import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

final kStringLiteralsCode =
    LintCode('string_literals', package: kDesignSystemPackageId, url: kUri);

class StringLiterals extends SidecarGeneralizingAstVisitor with LintMixin {
  @override
  LintCode get code => kStringLiteralsCode;

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addSimpleStringLiteral(this);
  }

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
