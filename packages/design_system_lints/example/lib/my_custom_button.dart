import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    required this.child,
    required this.onPressed,
    this.widgetHeight,
  });

  @designSystemMember
  final double? widgetHeight;

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widgetHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
