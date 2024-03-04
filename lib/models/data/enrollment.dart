import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/sync.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnit.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2Enrollment extends D2DataResource implements SyncableData {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  @Unique()
  String uid;
  DateTime enrolledAt;
  bool deleted;
  bool followup;
  DateTime occurredAt;
  String status;
  String? notes;

  @Backlink()
  final events = ToMany<D2Event>();

  final relationships = ToMany<D2Relationship>();

  final trackedEntity = ToOne<D2TrackedEntity>();

  final orgUnit = ToOne<D2OrganisationUnit>();

  final program = ToOne<D2Program>();

  D2Enrollment(
      {required this.uid,
      required this.updatedAt,
      required this.createdAt,
      required this.enrolledAt,
      required this.followup,
      required this.deleted,
      required this.occurredAt,
      required this.status,
      required this.notes,
      required this.synced});

  D2Enrollment.fromMap(ObjectBox db, Map json)
      : uid = json["enrollment"],
        updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        enrolledAt = DateTime.parse(json["enrolledAt"]),
        followup = json["followUp"],
        deleted = json["deleted"],
        occurredAt = DateTime.parse(json["occurredAt"]),
        status = json["status"],
        synced = true,
        notes = jsonEncode(json["notes"]) {
    id = D2EnrollmentRepository(db).getIdByUid(json["enrollment"]) ?? 0;

    trackedEntity.target =
        D2TrackedEntityRepository(db).getByUid(json["trackedEntity"]);
    orgUnit.target = D2OrgUnitRepository(db).getByUid(json["orgUnit"]);
    program.target = D2ProgramRepository(db).getByUid(json["program"]);
  }

  @override
  bool synced;

  @override
  Future<Map<String, dynamic>> toMap({ObjectBox? db}) async {
    if (db == null) {
      throw "ObjectBox instance is required";
    }

    Map<String, dynamic> payload = {
      "orgUnit": orgUnit.target?.uid,
      "program": program.target?.uid,
      "trackedEntity": trackedEntity.target?.uid,
      "enrollment": uid,
      "enrolledAt": enrolledAt.toIso8601String(),
      "deleted": deleted,
      "occurredAt": occurredAt.toIso8601String(),
      "status": status,
      "notes": jsonDecode(notes ?? "[]"),
    };

    return payload;
  }
}
