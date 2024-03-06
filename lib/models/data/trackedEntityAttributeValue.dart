import 'package:dhis2_flutter_toolkit/models/data/base.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/data/uploadBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2TrackedEntityAttributeValue extends D2DataResource
    implements SyncableData {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @Unique()
  String uid;

  @override
  DateTime updatedAt;

  String value;

  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();
  final trackedEntity = ToOne<D2TrackedEntity>();

  D2TrackedEntityAttributeValue(
      this.uid, this.createdAt, this.updatedAt, this.value, this.synced);

  D2TrackedEntityAttributeValue.fromMap(
      ObjectBox db, Map json, String trackedEntityId)
      : createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        uid = "$trackedEntityId-${json["attribute"]}",
        synced = true,
        value = json["value"] {
    String uid = "$trackedEntityId-${json["attribute"]}";
    id = D2TrackedEntityAttributeRepository(db).getIdByUid(uid) ?? 0;

    trackedEntityAttribute.target =
        D2TrackedEntityAttributeRepository(db).getByUid(json["attribute"]);
    trackedEntity.target =
        D2TrackedEntityRepository(db).getByUid(trackedEntityId);
  }

  @override
  bool synced;

  @override
  Future<Map<String, dynamic>> toMap({ObjectBox? db}) async {
    return {"attribute": trackedEntityAttribute.target?.uid, "value": value};
  }
}
