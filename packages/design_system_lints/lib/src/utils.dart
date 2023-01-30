import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:sidecar/type_checker.dart';

bool? hasDesignSystemAnnotation(Element? element) {
  if (element == null) return null;
  return element.thisOrAncestorMatching((p0) {
        return p0.metadata.any((m) => designSystem.isAssignableFrom(m.element));
      }) !=
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
    return isDesignSystemExpression(exp.elseExpression);
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

Iterable<Expression> nonDesignSystemExpressions(CollectionElement? exp) sync* {
  if (exp is ListLiteral) {
    final arguments = exp.elements;
    for (final listItem in arguments) {
      yield* nonDesignSystemExpressions(listItem);
    }
  } else if (exp is Literal) {
    yield exp;
  }
  if (exp is ConditionalExpression) {
    yield* nonDesignSystemExpressions(exp.thenExpression);
    yield* nonDesignSystemExpressions(exp.elseExpression);
  }
  if (exp is BinaryExpression) {
    yield* nonDesignSystemExpressions(exp.leftOperand);
    yield* nonDesignSystemExpressions(exp.rightOperand);
  }
  if (exp is AssignmentExpression) {
    exp.writeElement;
  }
  if (exp is Identifier) {
    final staticElement = exp.staticElement?.nonSynthetic;
    if (staticElement is PropertyInducingElement) {
      if (hasAnnotatedProperty(staticElement)) yield exp;
    }
  }
  if (exp is PropertyAccess) {
    final staticElement = exp.propertyName.staticElement?.nonSynthetic;
    if (hasAnnotatedProperty(staticElement)) yield exp;
  }

  if (exp is NamedExpression) {
    yield* nonDesignSystemExpressions(exp.expression);
  }

  if (exp is InstanceCreationExpression) {
    yield exp;
  }
}

bool hasAnnotatedProperty(Element? staticElement) {
  if (staticElement is PropertyInducingElement) {
    if (staticElement.hasInitializer) {
      if (hasDesignSystemAnnotation(staticElement) == false) {
        return true;
      }
    }
  } else if (staticElement is PropertyAccessorElement) {
    if (staticElement.variable.hasInitializer) {
      if (hasDesignSystemAnnotation(staticElement) == false) {
        return true;
      }
    }
  } else {
    if (hasDesignSystemAnnotation(staticElement) == false) {
      return true;
    }
  }
  return false;
}

bool isAncestorDesignSystem(AstNode? node) {
  if (node == null) return false;
  final hasAncestor = node.thisOrAncestorMatching((p0) {
        if (p0 is Declaration) {
          if (hasDesignSystemAnnotation(p0.declaredElement) ?? false) {
            return true;
          }
        }
        return false;
      }) !=
      null;
  return hasAncestor;
}

const designSystemMember = TypeChecker.fromPackage(
  'designSystemMember',
  package: 'design_system_annotations',
);

const designSystem = TypeChecker.fromPackage(
  'designSystem',
  package: 'design_system_annotations',
);

// Iterable<Expression> checker(
//   TypeChecker checker,
//   DartType? type,
//   List<Expression> nodes,
// ) sync* {
//   for (final node in nodes) {
//     if (checker.isNotAssignableFromType(type)) continue;
//     if (isAncestorDesignSystem(node)) return;
//     if (isAncestorDesignSystem(node)) return;
//     yield* nonDesignSystemExpressions(node);
//   }
// }

// void fieldDeclaration(
//   TypeChecker checker,
//   FieldDeclaration node,
//   void Function(Expression exp) func,
// ) {
//   for (final v in node.fields.variables) {
//     if (checker.isNotAssignableFromType(v.declaredElement2?.type)) continue;
//     if (isAncestorDesignSystem(node)) return;
//     for (final expression in nonDesignSystemExpressions(v.name)) {
//       func(expression);
//     }
//   }
// }

bool isListOfType(TypeChecker checker, DartType? type) {
  if (listType.isNotAssignableFromType(type)) return false;
  if (type is! InterfaceType) return false;
  if (type.typeArguments.length != 1) return false;
  final typeArgument = type.typeArguments.first;
  if (checker.isNotAssignableFromType(typeArgument)) return false;
  return true;
}

const listType = TypeChecker.fromDart('List', package: 'core');
