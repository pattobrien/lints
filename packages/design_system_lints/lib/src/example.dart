// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:flutter_analyzer_utils/animation.dart';
// import 'package:sidecar/sidecar.dart';
// import 'package:sidecar/src/rules/rules.dart';
// import 'package:sidecar/src/analyzer/ast/ast.dart';

// class ExampleRegisteredLint extends RuleWithRegistry {
//   ExampleRegisteredLint(super.code, super.context);

//   @override
//   // TODO: implement code
//   String get code => throw UnimplementedError();

//   @override
//   // TODO: implement packageName
//   LintPackageId get packageName => throw UnimplementedError();

//   @override
//   void registerVisitor(NodeLintRegistry registry) {
//     final visitor = _Visitor(this);
//     registry
//       ..addInstanceCreationExpression(this, visitor)
//       ..addAdjacentStrings(this, visitor);
//     super.registerVisitor(registry);
//   }
//   //
// }

// class _Visitor extends SidecarRegistryVisitor {
//   _Visitor(super.rule, super.context);

//   @override
//   void visitInstanceCreationExpression(InstanceCreationExpression node) {
//     final element = node.constructorName.staticElement;
//     if (textStyleType.isAssignableFromType(element?.returnType)) {
//       reportAstNode(
//         node,
//         message: r'Avoid TextStyle literal.',
//         correction: 'Use design system spec instead.',
//       );
//     }
//     super.visitInstanceCreationExpression(node);
//   }
// }
