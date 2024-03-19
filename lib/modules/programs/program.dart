import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:dhis2_flutter_toolkit_example_app/components/DetailsRow.dart';
import 'package:dhis2_flutter_toolkit_example_app/state/db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProgramDetails extends StatelessWidget {
  const ProgramDetails({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DBProvider>(context, listen: false).db;
    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Program Id is required",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Center(
          child: Text("You must specify a project ID"),
        ),
      );
    }

    D2ProgramRepository repository = D2ProgramRepository(db);
    D2Program? program = repository.getById(int.parse(id!));

    if (program == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Program not found",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Center(
          child: Text("The requested program does not exist offline"),
        ),
      );
    }

    List<D2ProgramStage> programStages =
        D2ProgramStageRepository(db).byProgram(program.id).find();

    List<D2ProgramTrackedEntityAttribute> attributes =
        D2ProgramTrackedEntityAttributeRepository(db)
            .byProgram(program.id)
            .find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          program.name,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              DetailsRow(label: "Short Name", value: program.shortName),
              DetailsRow(label: "UID", value: program.uid),
              DetailsRow(
                  label: "Type",
                  value: program.programType == "WITH_REGISTRATION"
                      ? "Tracker Program"
                      : "Event Program"),
              DetailsRow(
                label: "Attributes",
                value: attributes
                    .map((D2ProgramTrackedEntityAttribute attribute) =>
                        attribute.trackedEntityAttribute.target?.name)
                    .toList()
                    .join(", "),
              ),
              DetailsRow(
                label: "Program Stages",
                value: programStages.map((e) => e.name).toList().join(", "),
              ),
              DetailsRow(
                label: "Organisation Units",
                value: program.organisationUnits.length.toString(),
              ),
              TextButton(
                  onPressed: () {
                    context.push("/programs/$id/registration-form");
                  },
                  child: const Text("Registration Form")),
              TextButton(
                  onPressed: () {
                    context.push(Uri(
                            path: "/tei",
                            queryParameters: {"program": program.id.toString()})
                        .toString());
                  },
                  child: const Text("Teis"))
            ],
          ),
        ),
      ),
    );
  }
}
