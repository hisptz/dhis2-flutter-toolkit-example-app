import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormValuesViewer extends StatelessWidget {
  final D2FormController controller;

  const FormValuesViewer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        String? firstName = controller.getValue("firstName");
        String? lastName = controller.getValue("lastName");
        String? email = controller.getValue("email");
        String? dob = controller.getValue("dob");

        return Column(
          children: [
            Row(
              children: [
                const Text(
                  "First Name: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(right: 16.0)),
                Expanded(
                  flex: 1,
                  child: Text(firstName ?? "N/A"),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Last Name: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(right: 16.0)),
                Expanded(
                  flex: 1,
                  child: Text(lastName ?? "N/A"),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "Email: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(right: 16.0)),
                Expanded(
                  flex: 1,
                  child: Text(email ?? "N/A"),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  "DOB: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(right: 16.0)),
                Expanded(
                  flex: 1,
                  child: Text(dob ?? "N/A"),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
