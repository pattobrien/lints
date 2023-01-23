import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';

final large = 12.0;

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // appears for hardcoded integer or double values
//       padding: EdgeInsets.only(left: 12.0), // lint: avoid_edge_insets_literal

//       // also appears when using variables that are declared
//       // outside of a design system
//       margin: EdgeInsets.all(large), // lint: avoid_edge_insets_literal
//     );
//   }
// }

@designSystem
class DesignSystem {
  static const small = 2.0;
  static const medium = 4.0;
  static const large = 8.0;
  static const xlarge = 16.0;
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DesignSystem.large), // no lint
    );
  }
}
