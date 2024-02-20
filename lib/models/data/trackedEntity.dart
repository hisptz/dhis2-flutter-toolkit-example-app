import 'dart:convert';

import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
<<<<<<< HEAD
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';
=======
import 'package:objectbox/objectbox.dart';
>>>>>>> feature/metadata-models

final trackedEntityBox = db.store.box<TrackedEntity>();

@Entity()
class TrackedEntity extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;
  String trackedEntityType;

  String featureType;
<<<<<<< HEAD
  String programOwners;
=======

  // List<Map<String, dynamic>> programOwners;
>>>>>>> feature/metadata-models
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
      required this.created,
      required this.lastUpdated,
      required this.deleted,
      required this.potentialDuplicate,
      required this.featureType,
      required this.inactive});

  TrackedEntity.fromMap(Map json)
      : uid = json["trackedEntityInstance"],
        trackedEntityType = json["trackedEntityType"],
        orgUnit = json["orgUnit"],
        createdAtClient = DateTime.parse(json["createdAtClient"]),
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        deleted = json["deleted"],
        potentialDuplicate = json["potentialDuplicate"],
        featureType = json["featureType"],
<<<<<<< HEAD
        programOwners = jsonEncode(json["programOwners"]),
=======
>>>>>>> feature/metadata-models
        inactive = json["inactive"] {
    List<D2Enrollment> enrollment =
        json["enrollments"].map(D2Enrollment.fromMap);

    enrollments.addAll(enrollment);

    List<D2TrackedEntityAttributeValue> attributeValue =
        json["attributes"].map(D2TrackedEntityAttributeValue.fromMap);

    attributes.addAll(attributeValue);

    List<Relationship> relationship =
        json["relationships"].map(Relationship.fromMap);

    relationships.addAll(relationship);
  }
}
