import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnitLevel.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2OrganisationUnitLevel implements D2MetadataResource {
  @override
  int id = 0;

  String name;
  @override
  @Unique()
  String uid;
  int level;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  D2OrganisationUnitLevel(this.id, this.displayName, this.name, this.uid,
      this.level, this.created, this.lastUpdated);

  D2OrganisationUnitLevel.fromMap(ObjectBox db, Map json)
      : name = json["name"],
        uid = json["id"],
        level = json["level"],
        displayName = json["displayName"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]) {
    id = D2OrgUnitLevelRepository(db).getIdByUid(json["id"]) ?? 0;
  }

  @override
  String? displayName;
}
