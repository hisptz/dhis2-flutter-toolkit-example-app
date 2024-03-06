import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/userGroup.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2UserGroup extends D2MetadataResource {
  @override
  int id = 0;
  @override
  @Unique()
  String uid;
  @Index()
  String name;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  D2UserGroup(this.id, this.uid, this.displayName, this.name, this.created,
      this.lastUpdated);

  D2UserGroup.fromMap(ObjectBox db, Map json)
      : uid = json["id"],
        name = json["name"],
        displayName = json["displayName"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]) {
    id = D2UserGroupRepository(db).getIdByUid(json["id"]) ?? 0;
  }

  @override
  String? displayName;
}
