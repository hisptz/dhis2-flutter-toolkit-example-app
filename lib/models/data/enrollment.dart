import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2Enrollment extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  DateTime createdAtClient;

  @override
  @Unique()
  String uid;
  String program;
  String trackedEntity;

  String orgUnit;
  String orgUnitName;
  DateTime enrolledAt;
  bool deleted;
  bool followup;
  DateTime occurredAt;
  String status;
  String? notes;

  final events = ToMany<D2Event>();
  final relationships = ToMany<Relationship>();
  final attributes = ToMany<D2TrackedEntityAttributeValue>();

  D2Enrollment({
    required this.uid,
    required this.program,
    required this.updatedAt,
    required this.createdAt,
    required this.createdAtClient,
    required this.orgUnit,
    required this.orgUnitName,
    required this.trackedEntity,
    required this.enrolledAt,
    required this.followup,
    required this.deleted,
    required this.occurredAt,
    required this.status,
    required this.notes,
  });

  D2Enrollment.fromMap(Map json)
      : uid = json["enrollment"],
        program = json["program"],
        updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        createdAtClient = DateTime.parse(json["createdAtClient"]),
        orgUnit = json["orgUnit"],
        orgUnitName = json["orgUnitName"],
        trackedEntity = json["trackedEntity"],
        enrolledAt = DateTime.parse(json["enrolledAt"]),
        followup = json["followUp"],
        deleted = json["deleted"],
        occurredAt = DateTime.parse(json["occurredAt"]),
        status = json["status"],
        notes = jsonEncode(json["notes"]) {
    List<D2Event?> allEvents = json["events"]
        .cast<Map>()
        .map<D2Event?>(
            (Map event) => D2EventRepository().getByUid(event["enrollment"]))
        .toList();

    List<D2Event> event = allEvents
        .where((D2Event? element) => element != null)
        .toList()
        .cast<D2Event>();

    events.addAll(event);

    List<Relationship?> relationship = json["relationships"]
        .cast<Map>()
        .map<Relationship?>((Map relation) =>
            RelationshipRepository().getByUid(relation["relationship"]))
        .toList();

    List<Relationship> relations = relationship
        .where((Relationship? element) => element != null)
        .toList()
        .cast<Relationship>();

    relationships.addAll(relations);

    List<D2TrackedEntityAttributeValue> attribute = json["attributes"]
        .cast<Map>()
        .map<D2TrackedEntityAttributeValue>(
            D2TrackedEntityAttributeValue.fromMap)
        .toList()
        .cast<D2TrackedEntityAttributeValue>();

    attributes.addAll(attribute);
  }
}
