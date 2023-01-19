/* SNIPPET START */
import 'package:intl_lints/intl_lints.dart';
import 'package:sidecar/sidecar.dart';
import 'package:analyzer/dart/ast/ast.dart';

class BlocOutsideControllerLayer extends LintRule {
  static const _id = 'bloc_outside_controller_layer';
  @override
  LintCode get code => const LintCode(_id, package: packageId);
  /* SKIP */

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addCompilationUnit(this);
  }
  /* SKIP END */

  @override
  void visitCompilationUnit(CompilationUnit node) {
    final imports = node.directives.whereType<ImportDirective>();
    final blocImports = imports.where((element) => false);
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {}
}
/* SNIPPET END */