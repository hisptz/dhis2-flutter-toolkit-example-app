import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';

import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class TrackedEntity extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  @override
  @Unique()
  String uid;
  String trackedEntityType;

  String programOwners;
  String orgUnit;
  DateTime createdAtClient;
  bool potentialDuplicate;
  bool deleted;
  bool inactive;

  final enrollments = ToMany<D2Enrollment>();
  final relationships = ToMany<Relationship>();
  final attributes = ToMany<D2TrackedEntityAttributeValue>();

  TrackedEntity(
      {required this.uid,
      required this.trackedEntityType,
      required this.orgUnit,
      required this.createdAtClient,
      required this.createdAt,
      required this.updatedAt,
      required this.deleted,
      required this.potentialDuplicate,
      required this.inactive,
      required this.programOwners});

  TrackedEntity.fromMap(Map json)
      : uid = json["trackedEntity"],
        trackedEntityType = json["trackedEntityType"],
        orgUnit = json["orgUnit"],
        createdAtClient = DateTime.parse(json["createdAtClient"]),
        createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        deleted = json["deleted"],
        potentialDuplicate = json["potentialDuplicate"],
        programOwners = jsonEncode(json["programOwners"] ?? ""),
        inactive = json["inactive"] {
    // id = TrackedEntityRepository().getIdByUid(json["trackedEntity"]) ?? 0;
    List<D2Enrollment?> enrolls = json["enrollments"]
        .cast<Map>()
        .map<D2Enrollment?>((Map enrollment) =>
            D2EnrollmentRepository().getByUid(enrollment["enrollment"]))
        .toList();

    List<D2Enrollment> enrollment = enrolls
        .where((D2Enrollment? element) => element != null)
        .toList()
        .cast<D2Enrollment>();

    enrollments.addAll(enrollment);

    List<D2TrackedEntityAttributeValue> attribute = json["attributes"]
        .cast<Map>()
        .map<D2TrackedEntityAttributeValue>(
            D2TrackedEntityAttributeValue.fromMap)
        .toList()
        .cast<D2TrackedEntityAttributeValue>();

    attributes.addAll(attribute);

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
