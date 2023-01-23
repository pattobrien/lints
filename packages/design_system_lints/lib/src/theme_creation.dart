import 'package:design_system_lints/src/constants.dart';
import 'package:sidecar/sidecar.dart';
import 'package:analyzer/dart/ast/ast.dart';

class ThemeCreation extends LintRule {
  static const id = 'theme_creation';
  static const message = 'Message';

  @override
  LintCode get code => const LintCode(id, package: kPackageId);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final returnType = node.constructorName.staticElement?.returnType;
    if (!themeData.isAssignableFromType(returnType)) return;

    reportLint(node, message: message);
  }
}
