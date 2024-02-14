import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class OrganisationUnitGroup implements DHIS2MetadataResource {
  @override
  int id = 0;
  String name;
  @override
  @Unique()
  String uid;

  final organisationUnits = ToMany<OrganisationUnit>();

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  OrganisationUnitGroup(
      {required this.name,
      required this.uid,
      required this.created,
      required this.lastUpdated});

  OrganisationUnitGroup.fromMap(Map json)
      : name = json["name"],
        uid = json["id"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]) {
    List<OrganisationUnit> orgUnits =
        json["organisationUnits"].map(OrganisationUnit.fromMap);

    organisationUnits.addAll(orgUnits);
  }
}
