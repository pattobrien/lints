import 'package:design_system_lints/design_system_lints.dart';
import 'package:sidecar/test.dart';
import 'package:test/test.dart';

void main() {
  group('avoid_edge_insets_literal', () {
    setUpRules([AvoidEdgeInsetsLiteral()]);
    ruleTest('literal value', content1, [ExpectedText('1.0')]);
    // ruleTest('variable', content2, [ExpectedText('value')]);
  });
}

const content1 = '''
import 'package:flutter/material.dart';

final x = EdgeInsets.all(1.0);
''';

const content2 = '''
import 'package:flutter/material.dart';
final value = 1.0;
final x = EdgeInsets.all(value);
''';
