import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleVariable.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
import 'package:objectbox/objectbox.dart';

import 'program.dart';
import 'programStage.dart';

@Entity()
class D2ProgramRuleVariable extends D2MetadataResource {
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
  String programRuleVariableSourceType;
  String valueType;
  bool useCodeForOptionSet;

//TODO: Add the one 2 one relationships to the constructor
  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();
  final dataElement = ToOne<D2DataElement>();
  final programStage = ToOne<D2ProgramStage>();
  final program = ToOne<D2Program>();

  D2ProgramRuleVariable(
      this.displayName,
      this.id,
      this.created,
      this.lastUpdated,
      this.uid,
      this.name,
      this.programRuleVariableSourceType,
      this.valueType,
      this.useCodeForOptionSet);

  D2ProgramRuleVariable.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        displayName = json["displayName"],
        programRuleVariableSourceType = json["programRuleVariableSourceType"],
        valueType = json["valueType"],
        useCodeForOptionSet = json["useCodeForOptionSet"] {
    id = D2ProgramRuleVariableRepository(db).getIdByUid(json["id"]) ?? 0;

    if (json["trackedEntityAttribute"] != null) {
      trackedEntityAttribute.target = D2TrackedEntityAttributeRepository(db)
          .getByUid(json["trackedEntityAttribute"]["id"]);
    }

    if (json["dataElement"] != null) {
      dataElement.target =
          D2DataElementRepository(db).getByUid(json["dataElement"]["id"]);
    }
    if (json["programStage"] != null) {
      programStage.target =
          D2ProgramStageRepository(db).getByUid(json["programStage"]["id"]);
    }
    program.target = D2ProgramRepository(db).getByUid(json["program"]["id"]);
  }

  @override
  String? displayName;
}
