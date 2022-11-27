// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

const _desc = r'Put required named parameters first.';

const _details = r'''
**DO** specify `required` on named parameter before other named parameters.
**BAD:**
```dart
m({b, c, required a}) ;
```
**GOOD:**
```dart
m({required a, b, c}) ;
```
**BAD:**
```dart
m({b, c, @required a}) ;
```
**GOOD:**
```dart
m({@required a, b, c}) ;
```
''';

final _code =
    LintCode('always_put_required_named_parameters_first', package: kPackageId);

class AlwaysPutRequiredNamedParametersFirst extends SidecarAstVisitor
    with Lint {
  @override
  LintCode get code => _code;

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addFormalParameterList(this);
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    var nonRequiredSeen = false;
    for (final param in node.parameters.where((p) => p.isNamed)) {
      var element = param.declaredElement;
      if (element != null && (element.hasRequired || element.isRequiredNamed)) {
        if (nonRequiredSeen) {
          final name = param.name;
          if (name != null) {
            reportToken(
              name,
              message:
                  'Required named parameters should be before optional named parameters.',
              correction:
                  'Try moving the required named parameter to be before any optional '
                  'named parameters.',
            );
          }
        }
      } else {
        nonRequiredSeen = true;
      }
    }
  }
}
