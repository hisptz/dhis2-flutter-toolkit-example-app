import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/DetailsRow.dart';
import '../../state/client.dart';
import '../../state/db.dart';

class TeiDetails extends StatelessWidget {
  const TeiDetails({super.key, required this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DBProvider>(context, listen: false).db;
    final client =
        Provider.of<D2HttpClientProvider>(context, listen: false).client;
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

    D2TrackedEntityRepository repository = D2TrackedEntityRepository(db);
    D2TrackedEntity? teiInstance = repository.getById(int.parse(id!));

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

    List<D2Enrollment> enrollments = teiInstance.enrollments;

    List<D2Event> events = [];

    List<D2TrackedEntityAttributeValue> attributeValues =
        teiInstance.attributes;

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
          child: enrollments.isNotEmpty && events.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: enrollments.length,
                  itemBuilder: (item, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  DetailsRow(
                                    label: "Attributes",
                                    value: attributeValues
                                        .map((value) {
                                          return "${value.trackedEntityAttribute.target!.name}: ${value.value}";
                                        })
                                        .toList()
                                        .join(", "),
                                  ),
                                  DetailsRow(
                                    label: "Created At",
                                    value: enrollments
                                        .map((enrollment) =>
                                            enrollment.createdAt)
                                        .toList()
                                        .join(", "),
                                  ),
                                  DetailsRow(
                                    label: "Updated At",
                                    value: enrollments
                                        .map((enrollment) =>
                                            enrollment.updatedAt)
                                        .toList()
                                        .join(", "),
                                  ),
                                  DetailsRow(
                                    label: "Organisation Unit",
                                    value: enrollments
                                        .map((enrollment) =>
                                            enrollment.orgUnitName)
                                        .toList()
                                        .join(", "),
                                  ),
                                  DetailsRow(
                                      label: "Events",
                                      value: events.isNotEmpty
                                          ? events
                                              .map((event) {
                                                final programStageName = event
                                                        .programStage
                                                        .target
                                                        ?.name ??
                                                    "Unknown Program Stage";
                                                List<D2DataValue>? dataValues =
                                                    D2DataValueRepository(db)
                                                            .byEvent(event.id)
                                                            .find() ??
                                                        [];

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
                            PopupMenuButton<String>(
                              onSelected: (String value) async {
                                switch (value) {
                                  case "Events":
                                    final response = await D2EventRepository(db)
                                        .setupUpload(client)
                                        .upload();
                                    break;
                                  case "Relationships":
                                    final response =
                                        await D2RelationshipRepository(db)
                                            .setupUpload(client)
                                            .upload();

                                    break;

                                  case "Enrollments":
                                    final response =
                                        await D2EnrollmentRepository(db)
                                            .setupUpload(client)
                                            .upload();
                                    break;
                                  default:
                                }
                                print(value);
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Enrollments',
                                  child: Text('Enrollments'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Events',
                                  child: Text('Events'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Relationships',
                                  child: Text('Relationships'),
                                ),
                              ],
                              icon: const Icon(
                                Icons.sync,
                                color: Colors.blueAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsRow(
                      label: "Attributes",
                      value: attributeValues
                          .map((value) {
                            return "${value.trackedEntityAttribute.target!.name}: ${value.value}";
                          })
                          .toList()
                          .join(", "),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(child: Text("No Enrollments")),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(child: Text("No Events"))
                  ],
                ),
        ),
      ),
    );
  }
}
