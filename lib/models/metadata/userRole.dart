import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

class DHIS2UserRole implements DHIS2MetadataResource {
  @Unique()
  String uid;
  String code;
  String name;
  List<String> authorities;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DHIS2UserRole(this.uid, this.code, this.name, this.authorities, this.created,
      this.lastUpdated);

  DHIS2UserRole.fromMap(Map json)
      : uid = json["id"],
        code = json["code"],
        name = json["name"],
        authorities = json["authorities"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
