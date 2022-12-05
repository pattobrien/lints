// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

class AlwaysRequireNonNullNamedParameters extends Rule with Lint {
  static const _id = 'always_require_non_null_named_parameters';
  @override
  LintCode get code =>
      const LintCode(_id, package: kPackageId, url: kUri + _id);

  @override
  void initializeVisitor(NodeRegistry registry) {
    if (!unit.session.analysisContext.analysisOptions.contextFeatures
        .isEnabled(Feature.non_nullable)) {
      registry.addFormalParameterList(this);
    }
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    List<DefaultFormalParameter> getParams() {
      final params = <DefaultFormalParameter>[];
      for (final p in node.parameters) {
        // Only named parameters
        if (p.isNamed) {
          final parameter = p as DefaultFormalParameter;
          // Without a default value or marked required
          if (parameter.defaultValue == null) {
            final declaredElement = parameter.declaredElement;
            if (declaredElement != null && !declaredElement.hasRequired) {
              params.add(parameter);
            }
          }
        }
      }
      return params;
    }

    final parent = node.parent;
    if (parent is FunctionExpression) {
      _checkParams(getParams(), parent.body);
    } else if (parent is ConstructorDeclaration) {
      _checkInitializerList(getParams(), parent.initializers);
      _checkParams(getParams(), parent.body);
    } else if (parent is MethodDeclaration) {
      _checkParams(getParams(), parent.body);
    }
  }

  void _checkAssert(
    Expression assertExpression,
    List<DefaultFormalParameter> params,
  ) {
    for (final param in params) {
      final name = param.name;
      if (name != null && _hasAssertNotNull(assertExpression, name.lexeme)) {
        reportToken(name, message: _desc);
        params.remove(param);
        return;
      }
    }
  }

  void _checkInitializerList(List<DefaultFormalParameter> params,
      NodeList<ConstructorInitializer> initializers) {
    for (final initializer in initializers) {
      if (initializer is AssertInitializer) {
        _checkAssert(initializer.condition, params);
      }
    }
  }

  void _checkParams(List<DefaultFormalParameter> params, FunctionBody body) {
    if (body is BlockFunctionBody) {
      for (final statement in body.block.statements) {
        if (statement is AssertStatement) {
          _checkAssert(statement.condition, params);
        } else {
          // Bail on first non-assert.
          return;
        }
      }
    }
  }

  bool _hasAssertNotNull(Expression node, String name) {
    bool hasSameName(Expression rawExpression) {
      final expression = rawExpression.unParenthesized;
      return expression is SimpleIdentifier && expression.name == name;
    }

    final expression = node.unParenthesized;
    if (expression is BinaryExpression) {
      if (expression.operator.type == TokenType.AMPERSAND_AMPERSAND) {
        return _hasAssertNotNull(expression.leftOperand, name) ||
            _hasAssertNotNull(expression.rightOperand, name);
      }
      if (expression.operator.type == TokenType.BANG_EQ) {
        final operands = [expression.leftOperand, expression.rightOperand];
        return operands.any((e) => e.unParenthesized is NullLiteral) &&
            operands.any(hasSameName);
      }
    }
    return false;
  }

  static const _desc =
      'Specify `@required` on named parameters without defaults.';

  static const details = '''

**DO** specify `@required` on named parameters without a default value on which 
an `assert(param != null)` is done.

**GOOD:**
```dart
m1({@required a}) {
  assert(a != null);
}

m2({a: 1}) {
  assert(a != null);
}
```

**BAD:**
```dart
m1({a}) {
  assert(a != null);
}
```

NOTE: Only asserts at the start of the bodies will be taken into account.

''';
}
