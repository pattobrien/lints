import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';

@designSystem
class MyDesignSystem {
  static final someValue = 13.0;
  static final color = Color(000000);
  static const someIcon = Icons.ice_skating;
}

class SomeOtherClass {
  static final someOtherValue = 12.0;
}
