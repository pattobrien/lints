import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:sidecar/type_checker.dart';

bool? hasDesignSystemAnnotation(Element? element) {
  if (element == null) return null;
  return element.thisOrAncestorMatching((p0) =>
          p0.metadata.any((m) => designSystem.isAssignableFrom(m.element))) !=
      null;
}

bool hasMemberAnnotation(Element? element) {
  if (element == null) return false;
  return element.metadata
      .any((m) => designSystemMember.isAssignableFrom(m.element));
}

// need to change this function to return a list of expressions that are
// not design system expressions
bool? isDesignSystemExpression(Expression? exp) {
  if (exp is Literal) return false;
  if (exp is ConditionalExpression) {
    // exp.thenExpression;
  }
  if (exp is Identifier) {
    // we may have to implement something "hacky" here.
    // where we reject any identifier from the current package that doesnt have
    // an annotation,
    // and otherwise, if the colors are from Flutter, we reject those as well

    // or.. what if we dont check for annotation if the Identifier is coming
    // from an enclosing element ? this would solve the CustomWidget test case
    final fieldElement = exp.staticElement?.nonSynthetic;
    if (fieldElement is FieldElement) {
      if (!fieldElement.hasInitializer) {
        return null;
      }
    }
    if (hasDesignSystemAnnotation(exp.staticElement?.nonSynthetic) == false) {
      return false;
    }
  }
  if (exp is PropertyAccess) {
    // TODO: when this is true, we dont return true... therefore, for Enum marked with
    // @designSystem, we get the wrong lint response
    if (hasDesignSystemAnnotation(exp.propertyName.staticElement) == false) {
      return false;
    }
  }

  if (exp is NamedExpression) {
    return isDesignSystemExpression(exp.expression);
  }

  if (exp is InstanceCreationExpression) {
    return false;
  }

  return null;
}

class ExpressionVisitor extends GeneralizingAstVisitor<Iterable<Expression>> {
  @override
  Iterable<Expression>? visitSimpleIdentifier(SimpleIdentifier node) sync* {
    final stream = super.visitSimpleIdentifier(node);
    if (stream != null) yield* stream;
    if (hasDesignSystemAnnotation(node.staticElement) == false) {
      yield node;
    }
  }

  @override
  Iterable<Expression>? visitPropertyAccess(PropertyAccess node) sync* {
    final stream = super.visitPropertyAccess(node);
    if (stream != null) yield* stream;
    if (hasDesignSystemAnnotation(node.propertyName.staticElement) == false) {
      yield node.propertyName;
    }
  }

  @override
  Iterable<Expression>? visitConditionalExpression(
    ConditionalExpression node,
  ) sync* {
    final stream = super.visitConditionalExpression(node);
    if (stream != null) yield* stream;
  }

  @override
  Iterable<Expression>? visitInstanceCreationExpression(
    InstanceCreationExpression node,
  ) sync* {
    yield node;
  }

  @override
  Iterable<Expression>? visitNamedExpression(NamedExpression node) sync* {
    final stream = super.visitNamedExpression(node);
    if (stream != null) yield* stream;
    // if (isDesignSystemExpression(node.expression) ?? true) {
    //   yield node.expression;
    // }
  }
}

const designSystemMember = TypeChecker.fromPackage('designSystemMember',
    package: 'design_system_annotations');

const designSystem = TypeChecker.fromPackage('designSystem',
    package: 'design_system_annotations');
