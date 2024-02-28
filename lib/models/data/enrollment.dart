import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
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

  @Unique()
  String uid;
  String program;

  String orgUnit;
  String orgUnitName;
  DateTime enrolledAt;
  bool deleted;
  bool followup;
  DateTime occurredAt;
  String status;
  String? notes;

  @Backlink()
  final events = ToMany<D2Event>();

  final relationships = ToMany<Relationship>();

  final trackedEntity = ToOne<TrackedEntity>();

  D2Enrollment({
    required this.uid,
    required this.program,
    required this.updatedAt,
    required this.createdAt,
    required this.createdAtClient,
    required this.orgUnit,
    required this.orgUnitName,
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
        enrolledAt = DateTime.parse(json["enrolledAt"]),
        followup = json["followUp"],
        deleted = json["deleted"],
        occurredAt = DateTime.parse(json["occurredAt"]),
        status = json["status"],
        notes = jsonEncode(json["notes"]) {
    id = D2EnrollmentRepository().getIdByUid(json["enrollment"]) ?? 0;

    trackedEntity.target =
        TrackedEntityRepository().getByUid(json["trackedEntity"]);
  }
}
