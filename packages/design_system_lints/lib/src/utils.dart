import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

bool? hasDesignSystemAnnotation(Element? element) {
  if (element == null) return null;
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

bool hasMemberAnnotation(Element? element) {
  if (element == null) return false;
  return element.metadata.any((m) {
    if (m.element?.name != 'designSystemMember') return false;
    final annotationUri = Uri(
        scheme: 'package',
        path: 'design_system_annotations/design_system_annotations.dart');
    final isEqual = m.element?.librarySource?.uri == annotationUri;
    return isEqual;
  });
}

bool? isDesignSystemExpression(Expression? exp) {
  if (exp is Literal) return false;

  if (exp is Identifier) {
    if (hasDesignSystemAnnotation(exp.staticElement) == false) {
      return false;
    }
  }

  if (exp is NamedExpression) {
    return isDesignSystemExpression(exp.expression);
  }

  return null;
}
