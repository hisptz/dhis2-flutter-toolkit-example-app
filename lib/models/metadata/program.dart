import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programTrackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnit.dart';
import 'package:objectbox/objectbox.dart';

final programBox = db.store.box<D2Program>();

@Entity()
class D2Program extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String shortName;
  String accessLevel;

  final organisationUnits = ToMany<D2OrganisationUnit>();

  final programStages = ToMany<D2ProgramStage>();

  final programSections = ToMany<D2ProgramSection>();

  final programTrackedEntityAttributes =
      ToMany<D2ProgramTrackedEntityAttribute>();

  D2Program({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.accessLevel,
    required this.name,
    required this.shortName,
  });

  D2Program.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        accessLevel = json["accessLevel"],
        name = json["name"],
        shortName = json["shortName"] {
    List<D2OrganisationUnit?> programOrgUnits = json["organisationUnits"]
        .cast<Map>()
        .map<D2OrganisationUnit?>(
            (Map orgUnit) => D2OrgUnitRepository().getByUid(orgUnit["id"]))
        .toList();

    List<D2OrganisationUnit> orgUnits = programOrgUnits
        .where((D2OrganisationUnit? element) => element != null)
        .toList()
        .cast<D2OrganisationUnit>();
    organisationUnits.addAll(orgUnits);

    List<D2ProgramStage> ps = json["programStages"]
        .cast<Map>()
        .map<D2ProgramStage>(D2ProgramStage.fromMap)
        .toList();
    programStages.addAll(ps);

    List<D2ProgramSection> programSection = json["programSections"]
        .cast<Map>()
        .map<D2ProgramSection>(D2ProgramSection.fromMap)
        .toList();
    programSections.addAll(programSection);

    List<D2ProgramTrackedEntityAttribute> ptea =
        json["programTrackedEntityAttributes"]
            .cast<Map>()
            .map<D2ProgramTrackedEntityAttribute>(
                D2ProgramTrackedEntityAttribute.fromMap)
            .toList();
    programTrackedEntityAttributes.addAll(ptea);
  }
}
