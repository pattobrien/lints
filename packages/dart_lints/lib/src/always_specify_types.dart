// Copyright (c) 2015, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';
import 'utils/ascii_utils.dart';

const desc = 'Specify type annotations.';

const details = '''
From the [style guide for the flutter repo](https://flutter.dev/style-guide/):
**DO** specify type annotations.
Avoid `var` when specifying that a type is unknown and short-hands that elide
type annotations.  Use `dynamic` if you are being explicit that the type is
unknown.  Use `Object` if you are being explicit that you want an object that
implements `==` and `hashCode`.
**BAD:**
```dart
var foo = 10;
final bar = Bar();
const quux = 20;
```
**GOOD:**
```dart
int foo = 10;
final Bar bar = Bar();
String baz = 'hello';
const int quux = 20;
```
NOTE: Using the the `@optionalTypeArgs` annotation in the `meta` package, API
authors can special-case type variables whose type needs to by dynamic but whose
declaration should be treated as optional.  For example, suppose you have a
`Key` object whose type parameter you'd like to treat as optional.  Using the
`@optionalTypeArgs` would look like this:
```dart
import 'package:meta/meta.dart';
@optionalTypeArgs
class Key<T> {
 ...
}
main() {
  Key s = Key(); // OK!
}
```
''';

class AlwaysSpecifyTypes extends Rule with Lint {
  List<String> get incompatibleRules =>
      const ['avoid_types_on_closure_parameters', 'omit_local_variable_types'];

  @override
  LintCode get code => const LintCode(
        'always_specify_types',
        package: kPackageId,
      );

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry
      ..addDeclaredIdentifier(this)
      ..addListLiteral(this)
      ..addSetOrMapLiteral(this)
      ..addSimpleFormalParameter(this)
      ..addNamedType(this)
      ..addVariableDeclarationList(this);
  }

  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    if (node.type == null) {
      reportToken(node.keyword!,
          message: 'Missing type annotation.',
          correction: 'Try adding a type annotation.');
    }
  }

  @override
  void visitListLiteral(ListLiteral node) {
    _checkLiteral(node);
  }

  @override
  void visitNamedType(NamedType node) {
    final type = node.type;
    if (type is InterfaceType) {
      final element = node.name.staticElement;
      if (element is TypeParameterizedElement &&
          element.typeParameters.isNotEmpty &&
          node.typeArguments == null &&
          node.parent is! IsExpression &&
          !element.hasOptionalTypeArgs) {
        reportAstNode(node,
            message: 'Missing type annotation.',
            correction: 'Try adding a type annotation.');
      }
    }
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral node) {
    _checkLiteral(node);
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    final name = node.name;
    if (name != null && node.type == null && !name.lexeme.isJustUnderscores) {
      if (node.keyword != null) {
        reportToken(node.keyword!,
            message: 'Missing type annotation.',
            correction: 'Try adding a type annotation.');
      } else {
        reportAstNode(node,
            message: 'Missing type annotation.',
            correction: 'Try adding a type annotation.');
      }
    }
  }

  @override
  void visitVariableDeclarationList(VariableDeclarationList node) {
    if (node.type == null) {
      reportToken(node.keyword!,
          message: 'Missing type annotation.',
          correction: 'Try adding a type annotation.');
    }
  }

  void _checkLiteral(TypedLiteral literal) {
    if (literal.typeArguments == null) {
      reportToken(literal.beginToken,
          message: 'Missing type annotation.',
          correction: 'Try adding a type annotation.');
    }
  }
}
