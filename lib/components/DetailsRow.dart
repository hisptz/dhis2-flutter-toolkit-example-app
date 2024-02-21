import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailsRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
        Expanded(child: Text(value))
      ],
    );
  }
}
