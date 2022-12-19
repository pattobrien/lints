import 'package:design_system_lints/design_system_lints.dart';
import 'package:test/test.dart';
import 'package:sidecar/test.dart';

void main() {
  group('avoid_border_radius_literal:', () {
    final rule = AvoidBorderRadiusLiteral();
    test('no design system', () async {
      await testLint(rule, contentBasic, [ExpectedLint(rule.code, 51, 27)]);
    });

    // test('with design system', () async {
    //   await testLint(rule, contentWithDesignSystem, []);
    // });
  });
}

const contentBasic = '''
import 'package:flutter/material.dart';

final x = BorderRadius.circular(10.0);
''';

const contentWithDesignSystem = '''
import 'package:flutter/material.dart';
import 'package:design_system_annotations/design_system_annotations.dart';

final x = BorderRadius.circular(MyDesignSystem.someValue);

@designSystem
class MyDesignSystem {
  static final someValue = 13.0;
}
''';
