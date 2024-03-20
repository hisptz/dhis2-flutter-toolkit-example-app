import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/material.dart';

class UIComponents extends StatelessWidget {
  const UIComponents({super.key});

  final Color color = Colors.green;

  final String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text(
          "Input Fields",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                D2PeriodSelector(
                  d2onUpdate: () {},
                  d2showRange: true,
                  d2showFixed: true,
                  d2showRelative: true,
                  d2Color: color,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                InputFieldContainer(
                  color: color,
                  error: error,
                  value: "",
                  onChange: (value) {},
                  input: D2TextInputFieldConfig(
                      clearable: true,
                      label: "Text Field",
                      mandatory: true,
                      name: "textField",
                      type: D2InputFieldType.text),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                InputFieldContainer(
                  color: color,
                  error: error,
                  value: "",
                  onChange: (value) {},
                  input: D2TextInputFieldConfig(
                      icon: Icons.person,
                      label: "Text Field With Icon",
                      mandatory: true,
                      name: "textField",
                      clearable: true,
                      type: D2InputFieldType.text),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                InputFieldContainer(
                  color: color,
                  error: error,
                  value: "",
                  onChange: (value) {},
                  input: D2NumberInputFieldConfig(
                      clearable: true,
                      icon: Icons.numbers,
                      label: "Number Field With Icon",
                      mandatory: true,
                      name: "numberField",
                      type: D2InputFieldType.number),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                InputFieldContainer(
                  color: color,
                  error: error,
                  value: "One",
                  onChange: (value) {},
                  input: D2SelectInputFieldConfig(
                      clearable: true,
                      icon: Icons.opacity,
                      label: "Select",
                      mandatory: true,
                      name: "numberField",
                      options: [
                        D2InputFieldOption(code: "One", name: "One"),
                        D2InputFieldOption(code: "Two", name: "Two"),
                        D2InputFieldOption(code: "Three", name: "Three"),
                        D2InputFieldOption(code: "Four", name: "Four"),
                        D2InputFieldOption(code: "Done", name: "Done"),
                      ],
                      type: D2InputFieldType.text),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                InputFieldContainer(
                  color: color,
                  error: error,
                  value: "One",
                  onChange: (value) {},
                  input: D2DateInputFieldConfig(
                      label: "Date",
                      mandatory: true,
                      clearable: true,
                      name: "numberField",
                      type: D2InputFieldType.dateTime),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                InputFieldContainer(
                  color: color,
                  error: error,
                  value: "email@somewhere.com",
                  onChange: (value) {},
                  input: D2TextInputFieldConfig(
                      label: "Email",
                      mandatory: true,
                      clearable: true,
                      name: "email",
                      type: D2InputFieldType.email),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                InputFieldContainer(
                  color: color,
                  error: error,
                  value: "http://google.com",
                  onChange: (value) {},
                  input: D2TextInputFieldConfig(
                      label: "URL",
                      mandatory: true,
                      clearable: true,
                      name: "url",
                      type: D2InputFieldType.url),
                ),
              ],
            ),
          )),
    );
  }
}
