import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

/// Avoid using hardcoded height and width in SizedBoxes.
class AvoidSizedBoxHeightWidthLiterals extends Rule with Lint {
  static const _id = 'avoid_sized_box_height_width_literals';
  static const _message = 'Avoid using hardcoded height or width values.';
  static const _correction = 'Use values in design system spec instead';
  @override
  LintCode get code => LintCode(_id, package: kPackageId, url: kUrl);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addInstanceCreationExpression(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final element = node.constructorName.staticElement;

    if (sizedBoxType.isAssignableFromType(element?.returnType)) {
      final args = node.argumentList.arguments
          .whereType<NamedExpression>()
          .where((e) =>
              e.name.label.name == 'width' || e.name.label.name == 'height');

      for (var arg in args) {
        final exp = arg.expression;
        if (exp is DoubleLiteral || exp is IntegerLiteral) {
          reportAstNode(exp, message: _message, correction: _correction);
        }
        if (exp is PrefixedIdentifier) {
          //TODO: handle expressions like "SomeClass.staticInteger"
          final annotatedElement = exp.identifier.staticElement;
          if (!isAnnotated(annotatedElement)) {
            reportAstNode(exp, message: _message, correction: _correction);
          }
        }
        if (exp is SimpleIdentifier) {
          if (!isAnnotated(exp.staticElement)) {
            reportAstNode(exp, message: _message, correction: _correction);
          }
        }
      }
    }
  }
}

bool isAnnotated(Element? element) {
  if (element == null) return false;
  return element.thisOrAncestorMatching((p0) {
        final meta = p0.metadata;
        return meta.any((m) {
          final annotationUri = Uri(
              scheme: 'package',
              path: 'design_system_annotations/design_system_annotations.dart');
          final isEqual = m.element?.librarySource?.uri == annotationUri;
          return isEqual;
        });
      }) !=
      null;
}
