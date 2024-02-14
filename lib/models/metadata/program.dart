import 'package:dhis2_flutter_toolkit/models/metadata/attributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Program extends DHIS2MetadataResource {
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

  final programTrackedEntityAttributes = ToMany<TrackedEntityAttribute>();

  Program({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.accessLevel,
    required this.name,
    required this.shortName,
  });

  Program.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        accessLevel = json["accessLevel"],
        name = json["name"],
        shortName = json["shortName"] {
    List<DHIS2AttributeValue> attributeValue =
        json["attributeValues"].map(DHIS2AttributeValue.fromMap);

    attributeValues.addAll(attributeValue);

    List<OrganisationUnit> orgUnits =
        json["organisationUnits"].map(OrganisationUnit.fromMap);
    organisationUnits.addAll(orgUnits);

    List<ProgramStage> programStage =
        json["programStages"].map(ProgramStage.fromMap);
    programStages.addAll(programStage);

    List<ProgramSection> programSection =
        json["programSections"].map(ProgramSection.fromMap);
    programSections.addAll(programSection);

    List<TrackedEntityAttribute> tei = json["programTrackedEntityAttributes"]
        .map(TrackedEntityAttribute.fromMap);
    programTrackedEntityAttributes.addAll(tei);
  }
}
