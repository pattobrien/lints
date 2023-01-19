import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget(this.widgetHeight);

  const CustomWidget.unnamed(
    this.widgetHeight,
  );

  const CustomWidget.named({
    required this.widgetHeight,
  });

  @designSystemMember
  final double widgetHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widgetHeight,
    );
  }
}
