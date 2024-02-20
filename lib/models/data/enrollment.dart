import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

final d2EnrollmentBox = db.store.box<D2Enrollment>();

@Entity()
class D2Enrollment extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DateTime createdAtClient;

  @override
  @Unique()
  String uid;
  String program;
  String trackedEntityInstance;
  String trackedEntityType;
  String orgUnit;
  String orgUnitName;
  DateTime enrollmentDate;
  bool deleted;
  bool followup;
  DateTime incidentDate;
  String status;
  String notes;

  final events = ToMany<D2Event>();
  final relationships = ToMany<Relationship>();
  final attributes = ToMany<D2TrackedEntityAttributeValue>();

  D2Enrollment({
    required this.uid,
    required this.program,
    required this.lastUpdated,
    required this.created,
    required this.createdAtClient,
    required this.orgUnit,
    required this.orgUnitName,
    required this.trackedEntityInstance,
    required this.trackedEntityType,
    required this.enrollmentDate,
    required this.followup,
    required this.deleted,
    required this.incidentDate,
    required this.status,
    required this.notes,
  });

  D2Enrollment.fromMap(Map json)
      : uid = json["enrollment"],
        program = json["program"],
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        created = DateTime.parse(json["created"]),
        createdAtClient = DateTime.parse(json["createdAtClient"]),
        orgUnit = json["orgUnit"],
        orgUnitName = json["orgUnitName"],
        trackedEntityInstance = json["trackedEntityInstance"],
        trackedEntityType = json["trackedEntityType"],
        enrollmentDate = DateTime.parse(json["enrollmentDate"]),
        followup = json["followup"],
        deleted = json["deleted"],
        incidentDate = DateTime.parse(json["incidentDate"]),
        status = json["status"],
        notes = jsonEncode(json["notes"]) {
    List<D2Event> event = json["events"].map(D2Event.fromMap);

    events.addAll(event);

    List<Relationship> relationship =
        json["relationships"].map(Relationship.fromMap);

    relationships.addAll(relationship);

    List<D2TrackedEntityAttributeValue> attributeValue =
        json["attributes"].map(D2TrackedEntityAttributeValue.fromMap);

    attributes.addAll(attributeValue);
  }
}
