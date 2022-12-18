import 'package:example/z_custom_widget.dart';
import 'package:example/system.dart';
import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  final double localValue = 100;

  final localIcon = Icons.abc;

  static final x = Color(000);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            // color: Colors.red,
            color: Color(000),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            // expectLint(avoid_sized_box_height_width_literals)
            height: 100,
            width: MyDesignSystem.someValue,
          ),
          SizedBox(
            height: localValue,
            width: SomeOtherClass.someOtherValue,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              left: SomeOtherClass.someOtherValue,
              bottom: MyDesignSystem.someValue,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Padding(
            padding: EdgeInsets.all(MyDesignSystem.someValue),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 9.0,
              horizontal: 10.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0),
          ),
          CustomWidget(10.0),
          Text(
            'data',
            style: TextStyle(),
          ),
          Text(
            'data',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Icon(Icons.abc),
          Icon(MyDesignSystem.someIcon),
          Icon(localIcon),
        ],
      ),
    );
  }
}

class Example2 extends StatelessWidget {
  const Example2({super.key});

  final double localValue = 100;

  @override
  Widget build(BuildContext context) {
    final anotherWidget = CustomWidget.unnamed(localValue);
    final anotherWidget3 = CustomWidget.named(
      widgetHeight: MyDesignSystem.someValue,
    );
    final anotherWidget4 = CustomWidget.named(
      widgetHeight: localValue,
    );
    final anotherWidget2 = CustomWidget.unnamed(
      MyDesignSystem.someValue,
    );
    return CustomWidget(10.0);
  }
}
