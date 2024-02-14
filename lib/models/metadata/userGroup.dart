import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

class DHIS2UserGroup implements DHIS2MetadataResource {
  @override
  @Unique()
  String uid;
  String code;
  String name;
  List<String> authorities;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DHIS2UserGroup(
      {required this.uid,
      required this.code,
      required this.name,
      required this.authorities,
      required this.created,
      required this.lastUpdated});

  DHIS2UserGroup.fromMap(Map json)
      : uid = json["id"],
        code = json["code"],
        name = json["name"],
        authorities = json["authorities"],
        created = json["created"],
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
