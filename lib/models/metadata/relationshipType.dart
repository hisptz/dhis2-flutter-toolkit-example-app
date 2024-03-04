import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityType.dart';
import 'package:objectbox/objectbox.dart';

enum RelationshipEntity {
  PROGRAM_STAGE_INSTANCE,
  PROGRAM_INSTANCE,
  TRACKED_ENTITY_INSTANCE
}

@Entity()
class D2RelationshipType extends D2MetadataResource {
  int id = 0;
  String name;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @Unique()
  @override
  String uid;

  @override
  String? displayName;
  String fromToName;
  String toFromName;
  String fromToDisplayName;
  String toFromDisplayName;
  bool referral;

  String fromRelationshipEntity;
  String toRelationshipEntity;

  final fromTrackedEntityType = ToOne<D2TrackedEntityType>();
  final fromProgram = ToOne<D2Program>();
  final fromProgramStage = ToOne<D2ProgramStage>();

  final toTrackedEntityType = ToOne<D2TrackedEntityType>();
  final toProgram = ToOne<D2Program>();
  final toProgramStage = ToOne<D2ProgramStage>();

  void getFromConstraints(ObjectBox db, Map constraints) {
    if (constraints["program"] != null) {
      fromProgram.target =
          D2ProgramRepository(db).getByUid(constraints["program"]["id"]);
    }
    if (constraints["programStage"] != null) {
      fromProgramStage.target = D2ProgramStageRepository(db)
          .getByUid(constraints["programStage"]["id"]);
    }
    if (constraints["trackedEntityType"] != null) {
      fromTrackedEntityType.target = D2TrackedEntityTypeRepository(db)
          .getByUid(constraints["trackedEntityType"]["id"]);
    }
  }

  void getToConstraints(ObjectBox db, Map constraints) {
    if (constraints["program"] != null) {
      toProgram.target =
          D2ProgramRepository(db).getByUid(constraints["program"]["id"]);
    }
    if (constraints["programStage"] != null) {
      toProgramStage.target = D2ProgramStageRepository(db)
          .getByUid(constraints["programStage"]["id"]);
    }
    if (constraints["trackedEntityType"] != null) {
      toTrackedEntityType.target = D2TrackedEntityTypeRepository(db)
          .getByUid(constraints["trackedEntityType"]["id"]);
    }
  }

  D2RelationshipType(
      this.id,
      this.name,
      this.displayName,
      this.fromToName,
      this.toFromName,
      this.fromToDisplayName,
      this.toFromDisplayName,
      this.referral,
      this.fromRelationshipEntity,
      this.toRelationshipEntity,
      this.lastUpdated,
      this.created,
      this.uid);

  D2RelationshipType.fromMap(ObjectBox db, Map json)
      : name = json["name"],
        uid = json["id"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        displayName = json["displayName"],
        fromToDisplayName = json["fromToDisplayName"],
        toFromDisplayName = json["toFromDisplayName"],
        fromToName = json["fromToName"],
        toFromName = json["toFromName"],
        referral = json["referral"],
        fromRelationshipEntity = json["fromConstraint"]["relationshipEntity"],
        toRelationshipEntity = json["toConstraint"]["relationshipEntity"] {
    Map fromConstraint = json["fromConstraint"];
    Map toConstraint = json["toConstraint"];

    getFromConstraints(db, fromConstraint);
    getToConstraints(db, toConstraint);
  }
}
