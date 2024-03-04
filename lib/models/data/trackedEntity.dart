import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/sync.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnit.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityType.dart';
import 'package:objectbox/objectbox.dart';

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
  bool potentialDuplicate;
  bool deleted;
  bool inactive;

  @Backlink("trackedEntity")
  final enrollments = ToMany<D2Enrollment>();

  //Disabled for now
  // final relationships = ToMany<D2Relationship>();

  final orgUnit = ToOne<D2OrgUnit>();

  @Backlink("trackedEntity")
  final attributes = ToMany<D2TrackedEntityAttributeValue>();

  final trackedEntityType = ToOne<D2TrackedEntityType>();

  @Backlink()
  final events = ToMany<D2Event>();

  D2TrackedEntity(this.uid, this.createdAt, this.updatedAt, this.deleted,
      this.potentialDuplicate, this.inactive, this.synced);

  D2TrackedEntity.fromMap(ObjectBox db, Map json)
      : uid = json["trackedEntity"],
        createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        deleted = json["deleted"],
        synced = true,
        potentialDuplicate = json["potentialDuplicate"],
        inactive = json["inactive"] {
    id = D2TrackedEntityRepository(db).getIdByUid(json["trackedEntity"]) ?? 0;
    orgUnit.target = D2OrgUnitRepository(db).getByUid(json["orgUnit"]);
    trackedEntityType.target =
        D2TrackedEntityTypeRepository(db).getByUid(json["trackedEntityType"]);
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
