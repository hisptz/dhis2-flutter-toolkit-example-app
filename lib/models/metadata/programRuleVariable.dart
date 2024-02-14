import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'program.dart';
import 'programStage.dart';

@Entity()
class ProgramRuleVariable extends DHIS2MetadataResource {
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
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();
  final dataElement = ToOne<DataElement>();
  final programStage = ToOne<ProgramStage>();
  final program = ToOne<Program>();

  ProgramRuleVariable(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.programRuleVariableSourceType,
      required this.valueType,
      required this.useCodeForOptionSet});

  ProgramRuleVariable.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        programRuleVariableSourceType = json["programRuleVariableSourceType"],
        valueType = json["valueType"],
        useCodeForOptionSet = json["useCodeForOptionSet"];
}
