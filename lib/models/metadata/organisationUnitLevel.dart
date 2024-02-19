import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
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

  D2OrganisationUnitLevel(
      {required this.name,
      required this.uid,
      required this.level,
      required this.created,
      required this.lastUpdated});

  D2OrganisationUnitLevel.fromMap(Map json)
      : name = json["name"],
        uid = json["id"],
        level = json["level"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
