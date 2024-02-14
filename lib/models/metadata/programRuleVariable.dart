import 'dart:html';

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

  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();
  final dataElement = ToOne<DataElement>();
  final programStage = ToOne<ProgramStage>();
  final program = ToOne<Program>();

  ProgramRuleVariable(
      this.created,
      this.lastUpdated,
      this.uid,
      this.name,
      this.programRuleVariableSourceType,
      this.valueType,
      this.useCodeForOptionSet);
}
