import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2UserGroup extends DHIS2MetadataResource {
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

  DHIS2UserGroup(this.uid, this.name, this.created, this.lastUpdated);

  DHIS2UserGroup.fromMap(Map json)
      : uid = json["id"],
        name = json["name"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
