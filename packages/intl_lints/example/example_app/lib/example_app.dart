import 'package:flutter/material.dart';

final someString = 'this string should be linted.';
void main() {
  runApp(MaterialApp());
}

class SomePath extends StatelessWidget {
  const SomePath({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('test'),
        Text(someString),
        // ignore: intl_lints.hardcoded_text_string
        Text(someString),
      ],
    );
  }
}
