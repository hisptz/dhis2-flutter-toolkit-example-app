import 'package:dhis2_flutter_toolkit/models/metadata/attributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programTrackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
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

  final attributeValues = ToMany<DHIS2AttributeValue>();

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
    List<DHIS2AttributeValue> attributeValue =
        json["attributeValues"].map(DHIS2AttributeValue.fromMap);

    attributeValues.addAll(attributeValue);

    List<OrganisationUnit> orgUnits = json["organisationUnits"]
        .map((Map orgUnit) => OrganisationUnit.getByUid(orgUnit["id"]));
    organisationUnits.addAll(orgUnits);

    List<ProgramStage> programStage =
        json["programStages"].map(ProgramStage.fromMap);
    programStages.addAll(programStage);

    List<ProgramSection> programSection =
        json["programSections"].map(ProgramSection.fromMap);
    programSections.addAll(programSection);

    List<ProgramTrackedEntityAttribute> ptea =
        json["programTrackedEntityAttributes"]
            .map(ProgramTrackedEntityAttribute.fromMap);
    programTrackedEntityAttributes.addAll(ptea);
  }
}
