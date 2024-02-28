import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';

import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2Event extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  DateTime createdAtClient;

  String uid;
  DateTime? scheduledAt;

  String orgUnit;

  DateTime? occurredAt;
  String orgUnitName;
  String status;
  String attributeCategoryOptions;
  bool deleted;
  bool followup;
  String attributeOptionCombo;
  String? notes;

  final relationships = ToMany<Relationship>();
  final dataValues = ToMany<D2DataValue>();
  final enrollment = ToOne<D2Enrollment>();
  final trackedEntity = ToOne<TrackedEntity>();
  final program = ToOne<D2Program>();
  final programStage = ToOne<D2ProgramStage>();

  D2Event({
    required this.attributeCategoryOptions,
    required this.attributeOptionCombo,
    required this.updatedAt,
    required this.createdAt,
    required this.createdAtClient,
    required this.orgUnit,
    required this.orgUnitName,
    required this.followup,
    required this.deleted,
    required this.status,
    required this.notes,
    required this.scheduledAt,
    required this.uid,
    required this.occurredAt,
  });

  D2Event.fromMap(Map json)
      : attributeCategoryOptions = json["attributeCategoryOptions"],
        attributeOptionCombo = json["attributeOptionCombo"],
        updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        createdAtClient = DateTime.parse(json["createdAt"]),
        orgUnit = json["orgUnit"],
        orgUnitName = json["orgUnitName"],
        followup = json["followup"],
        deleted = json["deleted"],
        status = json["status"],
        notes = jsonEncode(json["notes"]),
        scheduledAt = DateTime.parse(json["scheduledAt"] ?? "1999-01-01T00:00"),
        uid = json["event"],
        occurredAt = DateTime.parse(json["occurredAt"] ?? "1999-01-01T00:00") {
    id = D2EventRepository().getIdByUid(json["event"]) ?? 0;
    enrollment.target =
        D2EnrollmentRepository().getByUid(json["enrollment"] ?? "");

    if (json["trackedEntity"] != null) {
      trackedEntity.target =
          TrackedEntityRepository().getByUid(json["trackedEntity"]);
    }

    program.target = D2ProgramRepository().getByUid(json["program"]);

    programStage.target =
        D2ProgramStageRepository().getByUid(json["programStage"]);

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
  }
}
