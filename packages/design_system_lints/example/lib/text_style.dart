import 'package:design_system_annotations/design_system_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ref.watch(someProvider).color,
    );
  }
}

final someProvider = Provider((ref) => MyTextTheme());

@designSystem
class MyTextTheme {
  final color = Color(0x000);
}
