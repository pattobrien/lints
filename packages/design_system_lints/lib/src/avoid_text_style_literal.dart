import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/services.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidTextStyleLiteral extends SidecarSimpleAstVisitor with LintMixin {
  @override
  LintCode get code => LintCode('avoid_text_style_literal',
      package: kDesignSystemPackageId, url: kUri);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  // @override
  // Future<List<EditResult>> computeQuickFixes(SourceSpan source) async {
  //   final unit = await getResolvedUnitResult(source.sourceUrl!.path);
  //   return Future.value([
  //     EditResult(message: 'HERES A FIX', sourceChanges: [
  //       SourceFileEdit(
  //           file: source.sourceUrl!,
  //           edits: [
  //             SourceEdit.simple(unit.unit.length - 1, 1,
  //                 sourceUri: unit.uri, replacement: '// test')
  //           ],
  //           fileStamp: DateTime.now())
  //     ])
  //   ]);
  // } {
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;
    if (textStyleType.isAssignableFromType(element?.returnType)) {
      reportAstNode(
        node,
        message: r'Avoid TextStyle literal.',
        correction: 'Use design system spec instead.',
      );
    }
    super.visitInstanceCreationExpression(node);
  }
}
