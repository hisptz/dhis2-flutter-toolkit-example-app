import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';

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

  @override
  @Unique()
  String uid;
  DateTime scheduledAt;
  String program;
  String programStage;
  String orgUnit;
  String enrollment;
  String? trackedEntity;
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

  D2Event({
    required this.attributeCategoryOptions,
    required this.attributeOptionCombo,
    required this.enrollment,
    required this.program,
    required this.updatedAt,
    required this.createdAt,
    required this.createdAtClient,
    required this.orgUnit,
    required this.orgUnitName,
    required this.trackedEntity,
    required this.followup,
    required this.deleted,
    required this.status,
    required this.notes,
    required this.scheduledAt,
    required this.uid,
    required this.programStage,
    required this.occurredAt,
  });

  D2Event.fromMap(Map json)
      : attributeCategoryOptions = json["attributeCategoryOptions"],
        attributeOptionCombo = json["attributeOptionCombo"],
        enrollment = json["enrollment"],
        program = json["program"],
        updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        createdAtClient = DateTime.parse(json["createdAt"]),
        orgUnit = json["orgUnit"],
        orgUnitName = json["orgUnitName"],
        trackedEntity = json["trackedEntity"],
        followup = json["followup"],
        deleted = json["deleted"],
        status = json["status"],
        notes = jsonEncode(json["notes"]),
        scheduledAt = DateTime.parse(json["scheduledAt"]),
        uid = json["event"],
        programStage = json["programStage"],
        occurredAt = DateTime.parse(json["occurredAt"] ?? "2000-01-01T00:00") {
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

    List<D2DataValue> dataValue = json["dataValues"]
        .cast<Map>()
        .map<D2DataValue>(D2DataValue.fromMap)
        .toList()
        .cast<D2DataValue>();

    dataValues.addAll(dataValue);
  }
}
