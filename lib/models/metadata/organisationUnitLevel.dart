import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class OrganisationUnitLevel implements DHIS2MetadataResource {
  String name;
  @override
  @Unique()
  String uid;
  int level;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  OrganisationUnitLevel(
      {required this.name,
      required this.uid,
      required this.level,
      required this.created,
      required this.lastUpdated});

  OrganisationUnitLevel.fromMap(Map json)
      : name = json["name"],
        uid = json["id"],
        level = json["level"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
