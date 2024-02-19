import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/userRole.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2UserRole extends D2MetadataResource {
  @override
  int id = 0;
  @override
  @Unique()
  String uid;
  String name;
  List<String> authorities;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DHIS2UserRole(
      this.uid, this.name, this.authorities, this.created, this.lastUpdated);

  DHIS2UserRole.fromMap(Map json)
      : uid = json["id"],
        name = json["name"],
        authorities = json["authorities"].cast<String>(),
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]) {
    id = D2UserRoleRepository().getIdByUid(json["id"]) ?? 0;
  }
}
