import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:dhis2_flutter_toolkit_example_app/modules/controlled_form/control_buttons.dart';
import 'package:dhis2_flutter_toolkit_example_app/modules/controlled_form/form_values.dart';
import 'package:flutter/material.dart';

class ControlledFormExample extends StatefulWidget {
  ControlledFormExample({super.key});

  @override
  State<ControlledFormExample> createState() => _ControlledFormExampleState();
}

class _ControlledFormExampleState extends State<ControlledFormExample> {
  final Color color = Colors.blue;

  final D2Form form = D2Form(sections: [
    FormSection(id: "1", title: "Personal Information", fields: [
      D2TextInputFieldConfig(
          label: "First Name",
          type: D2InputFieldType.text,
          name: "firstName",
          mandatory: true),
      D2TextInputFieldConfig(
          label: "Last Name",
          type: D2InputFieldType.text,
          name: "lastName",
          mandatory: true),
      D2TextInputFieldConfig(
          label: "Email",
          type: D2InputFieldType.email,
          name: "email",
          mandatory: true),
    ]),
    FormSection(id: "2", title: "History", fields: [
      D2DateInputFieldConfig(
          label: "Date of Birth",
          type: D2InputFieldType.date,
          name: "dob",
          mandatory: true),
      D2DateRangeInputFieldConfig(
          label: "Date Range",
          type: D2InputFieldType.date,
          name: "dob-range",
          mandatory: true),
    ])
  ], title: "Controlled Form Example");

  final D2FormController controller = D2FormController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controlled Form Example"),
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FormValuesViewer(controller: controller),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
              ControlButtons(controller: controller),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
              D2ControlledForm(form: form, controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
