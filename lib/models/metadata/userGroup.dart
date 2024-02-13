import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

class DHIS2UserGroup implements DHIS2MetadataResource {
  @override
  @Unique()
  String uid;
  @Index()
  String code;
  @Index()
  String name;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DHIS2UserGroup(
      this.uid, this.code, this.name, this.created, this.lastUpdated);

  DHIS2UserGroup.fromMap(Map json)
      : uid = json["id"],
        code = json["code"],
        name = json["name"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
