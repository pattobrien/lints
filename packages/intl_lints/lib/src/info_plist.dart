// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:flutter_analyzer_utils/foundation.dart';
// import 'package:intl_lints/src/constants.dart';
// import 'package:sidecar/sidecar.dart';

// class InfoPlist extends Rule with Lint {
//   @override
//   LintCode get code => LintCode('info_plist', package: packageId);

//   @override
//   void initializeVisitor(NodeRegistry registry) {
//     registry.addInstanceCreationExpression(this);
//   }

//   @override
//   void visitInstanceCreationExpression(InstanceCreationExpression node) {
//     if (themeDataType.isAssignableFromType(node.staticType)) {
//       reportAstNode(node, message: 'Found ThemeData.');
//     }
//   }

//   //
// }
