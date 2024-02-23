import 'package:dhis2_flutter_toolkit/components/DetailsRow.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:flutter/material.dart';

class TeiDetails extends StatelessWidget {
  const TeiDetails({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tracked Entity Id is required",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Center(
          child: Text("You must specify an Instance ID"),
        ),
      );
    }

    TrackedEntityRepository repository = TrackedEntityRepository();
    TrackedEntity? teiInstance = repository.getById(int.parse(id!));

    if (teiInstance == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Instance not found",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Center(
          child: Text("The requested Instance does not exist offline"),
        ),
      );
    }

    List<D2Enrollment> enrollments =
        D2EnrollmentRepository().byTrackedEntity(teiInstance.uid).find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          teiInstance.uid,
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
              DetailsRow(label: "UID", value: teiInstance.uid),
              DetailsRow(
                label: "Enrollments",
                value: enrollments
                    .map((enrollment) => enrollment.uid)
                    .toList()
                    .join(", "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
