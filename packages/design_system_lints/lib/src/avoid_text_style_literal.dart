import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/services.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded text styles.
class AvoidTextStyleLiteral extends SidecarAstVisitor with Lint, QuickFix {
  @override
  LintCode get code =>
      LintCode('avoid_text_style_literal', package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (textStyleType.isAssignableFromType(element?.returnType)) {
      reportAstNode(node,
          message: 'Avoid TextStyle literal.',
          correction: 'Use design system spec instead.',
          editsComputer: () async {
        return [
          EditResult(
            message: 'test change',
            sourceChanges: [
              SourceFileEdit(filePath: unit.path, edits: [
                SourceEdit.simple(unit.unit.length - 1, 1,
                    sourceUri: unit.uri, replacement: '// test')
              ])
            ],
          )
        ];
      });
    }
    super.visitInstanceCreationExpression(node);
  }
}
