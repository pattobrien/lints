import 'package:design_system_lints/design_system_lints.dart';
import 'package:sidecar/test.dart';
import 'package:test/test.dart';

void main() {
  group('avoid_color_literal', () {
    setUpRules([AvoidColorLiteral()]);

    const content1 = '''
import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';

@designSystem
class MyColors {
  static const blue = Colors.blue;
}

class MyColorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: MyColors.blue);
  }
}
''';
    ruleTest('widget uses design system color', content1, []);

    const content1b = '''
import 'package:flutter/material.dart';

class MyColors {
  static const blue = Colors.blue;
}

class MyColorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: MyColors.blue);
  }
}
''';
    ruleTest('widget uses non design system color', content1b,
        [ExpectedText('color: MyColors.blue')]);
    // The field 'myColor' should be protected by default
    // and a lint should appear if we attempt to assign
    // a non-design system color to it.
    // Otherwise, no internal lint should appear
    const content2 = '''
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({required this.myColor});

  final Color myColor;

  @override
    Widget build(BuildContext context) {
      return Container(color: myColor);
    }
}
''';
    ruleTest('custom widget with Color field', content2, []);

    // since UserProfile is not marked as a designSystem
    // entity, then we should lint any color objects that are
    // assigned to it.
    // Otherwise, there should be no internal lints that appear,
    // because the model itself is not creating or assigning any colors
    const content3 = '''
import 'package:flutter/material.dart';

class UserProfile {
  const UserProfile(this.name, this.favoriteColor);
  final String name;
  final Color favoriteColor;
}
''';
    ruleTest('custom class', content3, []);

    // same as above test, but now we're trying to create an object of MyClass
    // with a new Color object
    const content3b = '''
import 'package:flutter/material.dart';

class UserProfile {
  const UserProfile(this.name, this.favoriteColor);
  final String name;
  final Color favoriteColor;
}

final classInstance = MyClass(Color(0x000));
''';
    ruleTest('custom class instance creation', content3b,
        [ExpectedText('Color(0x000)')]);
    // using a default value in the constructor should trigger a lint
    // as its not a design system value
    const content4 = '''
import 'package:flutter/material.dart';

class UserProfile {
  const UserProfile(this.name, {this.favoriteColor = const Color(0x000)});
  final String name;
  final Color favoriteColor;
}
''';
    ruleTest('default param', content4, [ExpectedText('const Color(0x000)')]);

    const content5 = '''
import 'package:flutter/material.dart';

class UserProfile {
  const UserProfile(this.name, {this.favoriteColor = const Color(0x000)});
  final String name;
  final Color favoriteColor;
}
''';
    ruleTest('default param from material colors', content5,
        [ExpectedText('const Color(0x000)')]);

    const content6 = '''
import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';

@designSystem
class MyColors {
  static const blue = Colors.blue;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: MyColors.blue,
        secondaryHeaderColor: Colors.red,
      ),
    );
  }
}
''';
    ruleTest('theme data using desing system and non design system', content6,
        [ExpectedText('secondaryHeaderColor: Colors.red')]);

    // CONDITIONAL EXPRESSIONS
    const content7 = '''
import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  const ConditionalWidget({
    required this.myColor,
    this.isValue = true,
  });

  final Color myColor;
  final bool isValue;

  @override
  Widget build(BuildContext context) {
    return Container(color: isValue ? myColor : Color(0x000));
  }
}

''';
    ruleTest(
        'conditional expression', content7, [ExpectedText('Color(0x000)')]);

    // tests todo:
    // - DTO that creates UserProfile to/from json
  });
}
