import 'package:flutter/material.dart';

final someString = 'a declaration of a hardcoded string';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final url = 'https://myserver.aws.com';

    return Column(
      children: [
        Text('some hardcoded string'), // LINT: hardcoded_text_string
        Text(someString), // LINT: hardcoded_text_string
      ],
    );
  }
}
