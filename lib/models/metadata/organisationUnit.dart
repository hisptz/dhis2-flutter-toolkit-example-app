import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()

class OrganisationUnit implements DHIS2MetadataResource {


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


  OrganisationUnit(
      {required this.name,
      required this.uid,
      required this.shortName,
      required this.path,
      required this.level,
      required this.created,
      required this.lastUpdated});

  OrganisationUnit.fromMap(Map json)
      : uid = json["id"],
        name = json["name"],
        shortName = json["shortName"],
        path = json["path"],
        level = json["level"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]);
}
