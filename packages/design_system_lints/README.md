

A collection of lints and code edits enforcing UI standards throughout a codebase. 

> This analyzer rule package was built using [Sidecar](https://pub.dev/packages/sidecar) 

## Overview

As a project scales, UI consistency becomes more difficult to maintain if a centralized source of design elements is not set in place. No matter how subtle the differences are, inconsistent widget sizes or colors become more apparent and user satisfaction inevitably declines.

The concept of a design system is simple: define the basic UI building blocks for your product or brand in one central location, and reference them from anywhere in your codebase. By sticking to a system, clients or designers can maintain visual styles in one place, making it effortless for developers to implement beautiful UIs throughout the application.

For more info on the benefits of using a design system, take a look at [this great article by supernova.io](https://www.supernova.io/blog/what-is-a-design-system), a design system service built with Flutter.

## Available Rules

- Colors (rule: `avoid_color_literal`)
- Icons (rule: `avoid_icon_literal`)
- SizedBox width and height (rule: `avoid_sized_box_height_width_literals`)
- EdgeInsets (i.e. Padding and Margins) (rule: `avoid_sized_box_height_width_literals`)
- TextStyle widgets (rule: `avoid_text_style_literal`)
- Border Radius (rule: `avoid_border_radius_literal`)
- Box Shadows (rule: `avoid_box_shadow_literal`)

## Usage

To enable the above rules in your project, follow the usage guide over at [sidecaranalyzer.dev](https://sidecaranalyzer.dev/docs/usage/intial_setup).

Once the rules are enabled, the lints are designed to show info messages wherever design system rules are not properly followed. For example, the `avoid_edge_insets_literal` rule enforces a standard usage of padding and margins by locating `EdgeInsets` code uses sizes defined outside of a design system.

```dart
import 'package:flutter/material.dart';

final large = 12.0;

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // appears for hardcoded integer or double values
      padding: EdgeInsets.only(left: 11.0, right: 9.0), // lint: avoid_edge_insets_literal

      // also appears when using variables that are declared
      // outside of a design system
      margin: EdgeInsets.all(large), // lint: avoid_edge_insets_literal
    );
  }
}
```

Instead of using any variable for your padding, which is hard to maintain as your application scales, its better to define any sizing by either using `Theme` or static variables.

The package [`design_system_annotations`](https://pub.dev/packages/design_system_annotations) allows you to annotate your size variables with `@designSystem`, and permits their use throughout your codebase.

```dart
import 'package:design_system_annotations/design_system_annotations.dart';

// create your design system values
// the below values happen to follow the concept of an 8pt scale
// see: https://medium.com/swlh/the-comprehensive-8pt-grid-guide-aa16ff402179
@designSystem
class DesignSystem {
  static const xsmall = 2.0;
  static const small = 4.0
  static const medium = 8.0;
  static const large = 12.0;
  static const xlarge = 16.0;
}

// use the design system anywhere throughout your codebase
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DesignSystem.large), // no lint
    );
  }
}
```
The above design system was defined using whats known as the [8pt system](https://medium.com/swlh/the-comprehensive-8pt-grid-guide-aa16ff402179), which just about guarantees a consistent and perfectly flexible UI in your Flutter app.

Enforcing use of a highly maintainable UI system is as easy as that!

You additionally can use `design_system_lints` to enforce many different types of parameters,
including `SizedBox` and `Container` height and width values, `Color` values, `Icon` values,
and more.

## Further resources

Sidecar is a new package that allows anyone to create custom rules for their codebase. Since this
is a relatively new concept, further questions and feedback are expected and encouraged.
We encourage you to join the conversation on [discord](https://discord.com/invite/YhFS6V26Vg) and follow the [sidecar project](https://github.com/pattobrien/sidecar).

