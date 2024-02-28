import 'package:dhis2_flutter_toolkit/components/DetailsRow.dart';
import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';
import 'package:flutter/material.dart';

class TeiDetails extends StatelessWidget {
  const TeiDetails({super.key, required this.id});

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
        D2EnrollmentRepository().byTrackedEntity(int.parse(id!)).find();

    List<D2Event> events =
        D2EventRepository().byTrackedEntity(int.parse(id!)).find();

    List<D2TrackedEntityAttributeValue> attributeValues =
        D2TrackedEntityAttributeValueRepository()
            .byTrackedEntity(int.parse(id!))
            .find();

    final attribute = attributeValues.where((value) =>
        value.trackedEntityAttribute.target?.name == "First name" ||
        value.trackedEntityAttribute.target?.name == "Last name");
    String fullName =
        attribute.map((value) => value.value.toString()).join(" ");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          fullName,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: enrollments.length,
              itemBuilder: (item, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        DetailsRow(
                          label: "Created At",
                          value: enrollments
                              .map((enrollment) => enrollment.createdAt)
                              .toList()
                              .join(", "),
                        ),
                        DetailsRow(
                          label: "Updated At",
                          value: enrollments
                              .map((enrollment) => enrollment.updatedAt)
                              .toList()
                              .join(", "),
                        ),
                        DetailsRow(
                          label: "Organisation Unit",
                          value: enrollments
                              .map((enrollment) => enrollment.orgUnitName)
                              .toList()
                              .join(", "),
                        ),
                        DetailsRow(
                            label: "Events",
                            value: events.isNotEmpty
                                ? events
                                    .map((event) {
                                      final programStageName =
                                          event.programStage.target?.name ??
                                              "Unknown Program Stage";
                                      List<D2DataValue> dataValues =
                                          D2DataValueRepository()
                                              .byEvent(event.id)
                                              .find();

                                      final dataValueList =
                                          dataValues.isNotEmpty
                                              ? dataValues
                                                  .map((data) {
                                                    return "${data.dataElement.target?.name} :  ${data.value}";
                                                  })
                                                  .toList()
                                                  .join("\n ")
                                              : "No Data Values";
                                      return "Program Stage : $programStageName \n$dataValueList";
                                    })
                                    .toList()
                                    .join("\n\n")
                                : "None"),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
