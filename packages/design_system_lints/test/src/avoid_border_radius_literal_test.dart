import 'package:design_system_lints/design_system_lints.dart';
import 'package:test/test.dart';
import 'package:sidecar/test.dart';

void main() {
  group('avoid_border_radius_literal:', () {
    setUpRules([AvoidBorderRadiusLiteral()]);
    ruleTest('no design system', contentBasic, [
      ExpectedText('BorderRadius.circular(10.0)'),
    ]);
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
