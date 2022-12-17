import 'package:example/z_custom_widget.dart';
import 'package:example/system.dart';
import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  final double localValue = 100;

  @override
  Widget build(BuildContext context) {
    final anotherWidget = CustomWidget.named(1.0);
    return CustomWidget(10.0);
    // return Container(
    //   height: 100,
    //   width: 100,
    //   child: Column(
    //     children: [
    //       SizedBox(
    //         height: 100,
    //         width: MyDesignSystem.someValue,
    //       ),
    //       SizedBox(
    //         height: localValue,
    //         width: SomeOtherClass.someOtherValue,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(
    //           top: 8.0,
    //           left: SomeOtherClass.someOtherValue,
    //           bottom: MyDesignSystem.someValue,
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(8.0),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(MyDesignSystem.someValue),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.symmetric(
    //           vertical: 9.0,
    //           horizontal: 10,
    //         ),
    //       ),
    //       CustomWidget(10.0),
    //     ],
    //   ),
    // );
  }
}
