import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '',
        style: MyTextTheme.style,
      ),
    );
  }
}

@designSystem
class MyTextTheme {
  static const style = TextStyle();
}
