import 'package:design_system_lints/design_system_lints.dart';
import 'package:sidecar/test.dart';
import 'package:test/test.dart';

void main() {
  group('avoid_box_shadow_literal:', () {
    setUpRules([AvoidBoxShadowLiteral()]);
    ruleTest('no design system', contentBasic, [
      ExpectedText('BoxShadow()'),
    ]);
  });
}

const contentBasic = '''
import 'package:flutter/material.dart';

final x = BoxShadow();
''';
