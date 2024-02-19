import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleVariable.dart';
import 'package:objectbox/objectbox.dart';

import 'programRule.dart';

@Entity()
class D2ProgramRuleAction extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String programRuleActionType;
  String? content;
  String? data;
  String? location;

//TODO: Add the one 2 one relationships to the constructor
  final programRule = ToOne<D2ProgramRule>();
  final dataElement = ToOne<D2DataElement>();
  final programStageSection = ToOne<D2ProgramStageSection>();
  final programSection = ToOne<D2ProgramSection>();
  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();

  D2ProgramRuleAction(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.programRuleActionType,
      this.content,
      this.data,
      this.location});

  D2ProgramRuleAction.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        programRuleActionType = json["programRuleActionType"],
        content = json["content"],
        data = json["data"],
        location = json["location"] {
    id = D2ProgramRuleVariableRepository().getIdByUid(json["id"]) ?? 0;
  }
}
