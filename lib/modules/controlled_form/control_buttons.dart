import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final D2FormController controller;

  const ControlButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              controller.setError("firstName", "First name is invalid");
            },
            child: Text("Show errors")),
        TextButton(
            onPressed: () {
              controller.clearError("firstName");
            },
            child: const Text("Clear error")),
        TextButton(
            onPressed: () {
              controller.toggleFieldVisibility("firstName");
            },
            child: const Text("Toggle field visibility")),
      ],
    );
  }
}
