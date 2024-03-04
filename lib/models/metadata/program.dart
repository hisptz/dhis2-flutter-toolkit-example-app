import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programTrackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnit.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:objectbox/objectbox.dart';

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

  String programType;
  bool? onlyEnrollOnce;

  bool? selectEnrollmentDatesInFuture;

  final organisationUnits = ToMany<D2OrgUnit>();

  @Backlink("program")
  final programStages = ToMany<D2ProgramStage>();
  @Backlink("program")
  final programSections = ToMany<D2ProgramSection>();

  @Backlink("program")
  final programTrackedEntityAttributes =
      ToMany<D2ProgramTrackedEntityAttribute>();

  @Backlink()
  final events = ToMany<D2Event>();

  D2Program(
      this.created,
      this.lastUpdated,
      this.uid,
      this.accessLevel,
      this.name,
      this.shortName,
      this.programType,
      this.onlyEnrollOnce,
      this.displayName);

  D2Program.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        displayName = json["displayName"],
        accessLevel = json["accessLevel"],
        name = json["name"],
        shortName = json["shortName"],
        programType = json["programType"] {
    id = D2ProgramRepository(db).getIdByUid(json["id"]) ?? 0;
    List<D2OrgUnit?> programOrgUnits = json["organisationUnits"]
        .cast<Map>()
        .map<D2OrgUnit?>(
            (Map orgUnit) => D2OrgUnitRepository(db).getByUid(orgUnit["id"]))
        .toList();

    List<D2OrgUnit> orgUnits = programOrgUnits
        .where((D2OrgUnit? element) => element != null)
        .toList()
        .cast<D2OrgUnit>();
    organisationUnits.addAll(orgUnits);
  }

  @override
  String? displayName;
}
