import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/sync.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2Event extends D2DataResource implements SyncableData {
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

  final relationships = ToMany<D2Relationship>();
  final dataValues = ToMany<D2DataValue>();
  final enrollment = ToOne<D2Enrollment>();
  final trackedEntity = ToOne<D2TrackedEntity>();
  final program = ToOne<D2Program>();
  final programStage = ToOne<D2ProgramStage>();

  D2Event(
      {required this.attributeCategoryOptions,
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
      required this.synced});

  D2Event.fromMap(ObjectBox db, Map json)
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
        synced = true,
        notes = jsonEncode(json["notes"]),
        scheduledAt = DateTime.parse(json["scheduledAt"] ?? "1999-01-01T00:00"),
        uid = json["event"],
        occurredAt = DateTime.parse(json["occurredAt"] ?? "1999-01-01T00:00") {
    id = D2EventRepository(db).getIdByUid(json["event"]) ?? 0;
    enrollment.target =
        D2EnrollmentRepository(db).getByUid(json["enrollment"] ?? "");

    if (json["trackedEntity"] != null) {
      trackedEntity.target =
          TrackedEntityRepository(db).getByUid(json["trackedEntity"]);
    }

    program.target = D2ProgramRepository(db).getByUid(json["program"]);

    programStage.target =
        D2ProgramStageRepository(db).getByUid(json["programStage"]);
  }

  @override
  bool synced;

  @override
  Future<Map<String, dynamic>> toMap({ObjectBox? db}) async {
    if (db == null) {
      throw "ObjectBox instance is required";
    }

    List<D2DataValue> dataValues =
        await D2DataValueRepository(db).getByEvent(this);
    List<Map<String, dynamic>> dataValuesPayload = await Future.wait(dataValues
        .map<Future<Map<String, dynamic>>>((e) => e.toMap())
        .toList());

    //TODO: Check if an event has an enrollment
    return {
      "enrollment": enrollment.target?.uid,
      "dataValues": dataValuesPayload
    };
  }
}
