// Copyright (c) 2015, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_lints/src/utils/ascii_utils.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

const _desc = r'Specify type annotations.';

const _details = r'''
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

final _code = LintCode('always_specify_types', package: kPackageId);

class AlwaysSpecifyTypes extends SidecarSimpleAstVisitor with LintMixin {
  @override
  List<String> get incompatibleRules =>
      const ['avoid_types_on_closure_parameters', 'omit_local_variable_types'];

  @override
  LintCode get code => _code;

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
  void visitListLiteral(ListLiteral literal) {
    _checkLiteral(literal);
  }

  @override
  void visitNamedType(NamedType namedType) {
    var type = namedType.type;
    if (type is InterfaceType) {
      var element = namedType.name.staticElement;
      if (element is TypeParameterizedElement &&
          element.typeParameters.isNotEmpty &&
          namedType.typeArguments == null &&
          namedType.parent is! IsExpression &&
          !element.hasOptionalTypeArgs) {
        reportAstNode(namedType,
            message: 'Missing type annotation.',
            correction: 'Try adding a type annotation.');
      }
    }
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral literal) {
    _checkLiteral(literal);
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter param) {
    var name = param.name;
    if (name != null && param.type == null && !name.lexeme.isJustUnderscores) {
      if (param.keyword != null) {
        reportToken(param.keyword!,
            message: 'Missing type annotation.',
            correction: 'Try adding a type annotation.');
      } else {
        reportAstNode(param,
            message: 'Missing type annotation.',
            correction: 'Try adding a type annotation.');
      }
    }
  }

  @override
  void visitVariableDeclarationList(VariableDeclarationList list) {
    if (list.type == null) {
      reportToken(list.keyword!,
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
