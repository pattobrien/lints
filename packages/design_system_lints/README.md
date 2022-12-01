

A collection of lints and code edits to enforce UI standards within a codebase. 

> Powered by  [Sidecar](https://pub.dev/packages/sidecar)

## Overview

As a project scales, UI consistency becomes more difficult to maintain if a centralized source of design elements is not set in place. No matter how subtle the differences are, inconsistent widget sizes or colors become more apparent and user satisfaction inevitably declines.

The concept of a design system is simple: define the basic UI building blocks for your product or brand in one central location (e.g. 1 Dart file), and reference it from anywhere in your codebase. By sticking to this system, clients or designers can add or edit an entire set of Brand styles in one place, which makes it even easier for developers to implement beautiful UIs throughout the application.

## Rule Overview

This package includes rules that enforce use of a design system for the following Widgets:

- SizedBox width and height
- EdgeInsets (i.e. Padding and Margins)
- TextStyle widgets
- Border Radius
- Box Shadows
