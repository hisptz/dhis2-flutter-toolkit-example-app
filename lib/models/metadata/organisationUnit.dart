import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class OrganisationUnit extends DHIS2MetadataResource {
  int id = 0;

  String name;
  String shortName;
  @override
  @Unique()
  String uid;
  String path;
  int level;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  OrganisationUnit(this.id, this.name, this.shortName, this.uid, this.path,
      this.level, this.created, this.lastUpdated);

  OrganisationUnit.fromMap(Map json)
      : name = json["name"],
        shortName = json["shortName"],
        uid = json["id"],
        path = json["path"],
        level = json["level"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
