import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';


class DHIS2UserGroup implements DHIS2MetadataResource {

@Entity()

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
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
