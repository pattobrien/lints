// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

const desc = 'Put required named parameters first.';

const details = '''
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

class AlwaysPutRequiredNamedParametersFirst extends LintRule {
  static const id = 'always_put_required_named_parameters_first';
  static const _message =
      'Required named parameters should be before optional named parameters.';
  static const _correction =
      'Try moving the required named parameter to be before any optional '
      'named parameters.';

  @override
  LintCode get code => const LintCode(id, package: kPackageId, url: kUri + id);

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addFormalParameterList(this);
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    var nonRequiredSeen = false;
    for (final param in node.parameters.where((p) => p.isNamed)) {
      final element = param.declaredElement;
      if (element != null && (element.hasRequired || element.isRequiredNamed)) {
        if (nonRequiredSeen) {
          final name = param.name;
          if (name != null) {
            reportLint(name, message: _message, correction: _correction);
          }
        }
      } else {
        nonRequiredSeen = true;
      }
    }
  }
}
