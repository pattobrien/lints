import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:example/example.dart';
import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({super.key});
  final double x = 100;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: MyDesignSystem.someValue,
          ),
          SizedBox(
            height: x,
            width: SomeOtherClass.someOtherValue,
          ),
        ],
      ),
    );
  }
}
