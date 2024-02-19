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

  final organisationUnits = ToMany<OrganisationUnit>();

  final programStages = ToMany<ProgramStage>();

  final programSections = ToMany<ProgramSection>();

  final programTrackedEntityAttributes =
      ToMany<ProgramTrackedEntityAttribute>();

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
    List<OrganisationUnit?> programOrgUnits = json["organisationUnits"]
        .cast<Map>()
        .map<OrganisationUnit?>(
            (Map orgUnit) => D2OrgUnitRepository().getByUid(orgUnit["id"]))
        .toList();

    List<OrganisationUnit> orgUnits = programOrgUnits
        .where((OrganisationUnit? element) => element != null)
        .toList()
        .cast<OrganisationUnit>();
    organisationUnits.addAll(orgUnits);

    List<ProgramStage> ps = json["programStages"]
        .cast<Map>()
        .map<ProgramStage>(ProgramStage.fromMap)
        .toList();
    programStages.addAll(ps);

    List<ProgramSection> programSection = json["programSections"]
        .cast<Map>()
        .map<ProgramSection>(ProgramSection.fromMap)
        .toList();
    programSections.addAll(programSection);

    List<ProgramTrackedEntityAttribute> ptea =
        json["programTrackedEntityAttributes"]
            .cast<Map>()
            .map<ProgramTrackedEntityAttribute>(
                ProgramTrackedEntityAttribute.fromMap)
            .toList();
    programTrackedEntityAttributes.addAll(ptea);
  }
}
