import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/db.dart';

class ProgramFormExample extends StatefulWidget {
  final String programUid;

  const ProgramFormExample({super.key, required this.programUid});

  @override
  State<ProgramFormExample> createState() => _ProgramFormExampleState();
}

class _ProgramFormExampleState extends State<ProgramFormExample> {
  D2Program? program;
  late D2FormController controller;
  late D2TrackedEntity trackedEntity;

  @override
  void initState() {
    D2ObjectBox db = Provider.of<DBProvider>(context, listen: false).db;
    program = D2ProgramRepository(db).getById(int.parse(widget.programUid));
    controller = D2FormController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool registrationProgram = program?.programType == "WITH_REGISTRATION";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: program != null
              ? Column(
                  children: [
                    ListenableBuilder(
                        listenable: controller,
                        builder: (context, child) {
                          return Text(
                              "Values: ${controller.formValues.toString()}");
                        }),
                    registrationProgram
                        ? D2TrackerRegistrationForm(
                            color: Colors.blue,
                            controller: controller,
                            program: program!,
                            options: D2TrackerFormOptions(
                              showTitle: false,
                            ),
                          )
                        : D2TrackerEventForm(
                            color: Colors.blue,
                            controller: controller,
                            programStage: program!.programStages.first,
                            options: D2TrackerFormOptions(showTitle: true)),
                  ],
                )
              : Center(
                  child: Text(
                      "Program with id ${widget.programUid} could not be found"),
                ),
        ),
      ),
    );
  }
}
