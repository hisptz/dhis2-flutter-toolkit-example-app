import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/sync.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2TrackedEntity extends D2DataResource implements SyncableData {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  @Unique()
  String uid;
  String trackedEntityType;

  String programOwners;
  String orgUnit;
  DateTime createdAtClient;
  bool potentialDuplicate;
  bool deleted;
  bool inactive;

  @Backlink()
  final enrollments = ToMany<D2Enrollment>();

  final relationships = ToMany<D2Relationship>();

  final attributes = ToMany<D2TrackedEntityAttributeValue>();

  @Backlink()
  final events = ToMany<D2Event>();

  D2TrackedEntity(
      {required this.uid,
      required this.trackedEntityType,
      required this.orgUnit,
      required this.createdAtClient,
      required this.createdAt,
      required this.updatedAt,
      required this.deleted,
      required this.potentialDuplicate,
      required this.inactive,
      required this.programOwners,
      required this.synced});

  D2TrackedEntity.fromMap(ObjectBox db, Map json)
      : uid = json["trackedEntity"],
        trackedEntityType = json["trackedEntityType"],
        orgUnit = json["orgUnit"],
        createdAtClient = DateTime.parse(json["createdAtClient"]),
        createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        deleted = json["deleted"],
        synced = true,
        potentialDuplicate = json["potentialDuplicate"],
        programOwners = jsonEncode(json["programOwners"] ?? ""),
        inactive = json["inactive"] {
    id = D2TrackedEntityRepository(db).getIdByUid(json["trackedEntity"]) ?? 0;
  }

  @override
  bool synced;

  @override
  Future<Map<String, dynamic>> toMap({ObjectBox? db}) async {
    if (db == null) {
      throw "ObjectBox instance is required";
    }

    List<D2TrackedEntityAttributeValue> attributes =
        await D2TrackedEntityAttributeValueRepository(db)
            .byTrackedEntity(id)
            .findAsync();

    List<Map<String, dynamic>> attributesPayload = await Future.wait(attributes
        .map<Future<Map<String, dynamic>>>((e) => e.toMap())
        .toList());

    Map<String, dynamic> payload = {
      "orgUnit": orgUnit,
      "trackedEntity": uid,
      "trackedEntityType": trackedEntityType,
      "attributes": attributesPayload,
    };

    return payload;
  }
}
