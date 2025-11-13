import 'package:flutter/material.dart';

class GenderDot extends StatelessWidget {
  const GenderDot({super.key, required this.gender});

  final String gender;

  @override
  Widget build(BuildContext context) {
    final isFemale = gender.toLowerCase().startsWith('f');

    return Icon(isFemale ? Icons.female : Icons.male, size: 16);
  }
}
