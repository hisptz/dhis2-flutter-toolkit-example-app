import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnitGroup.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2OrganisationUnitGroup implements D2MetadataResource {
  @override
  int id = 0;
  String name;
  @override
  @Unique()
  String uid;

  final organisationUnits = ToMany<D2OrganisationUnit>();

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  D2OrganisationUnitGroup(
      {required this.name,
      required this.uid,
      required this.created,
      required this.lastUpdated});

  D2OrganisationUnitGroup.fromMap(ObjectBox db, Map json)
      : name = json["name"],
        uid = json["id"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]) {
    List<D2OrganisationUnit> orgUnits =
        json["organisationUnits"].map(D2OrganisationUnit.fromMap);
    organisationUnits.addAll(orgUnits);
    id = D2OrgUnitGroupRepository(db).getIdByUid(json["id"]) ?? 0;
  }
}
