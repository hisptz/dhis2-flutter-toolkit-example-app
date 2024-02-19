import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleVariable.dart';
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
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.programRuleVariableSourceType,
      required this.valueType,
      required this.useCodeForOptionSet});

  D2ProgramRuleVariable.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        programRuleVariableSourceType = json["programRuleVariableSourceType"],
        valueType = json["valueType"],
        useCodeForOptionSet = json["useCodeForOptionSet"] {
    id = D2ProgramRuleVariableRepository().getIdByUid(json["id"]) ?? 0;
  }
}
