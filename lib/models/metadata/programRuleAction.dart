import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRule.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleVariable.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
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

  final programRule = ToOne<D2ProgramRule>();
  final dataElement = ToOne<D2DataElement>();
  final programStageSection = ToOne<D2ProgramStageSection>();
  final programSection = ToOne<D2ProgramSection>();
  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();

  D2ProgramRuleAction(
      this.id,
      this.displayName,
      this.created,
      this.lastUpdated,
      this.uid,
      this.programRuleActionType,
      this.content,
      this.data,
      this.location);

  D2ProgramRuleAction.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        programRuleActionType = json["programRuleActionType"],
        content = json["content"],
        data = json["data"],
        displayName = json["displayName"],
        location = json["location"] {
    id = D2ProgramRuleVariableRepository(db).getIdByUid(json["id"]) ?? 0;

    programRule.target =
        D2ProgramRuleRepository(db).getByUid(json["programRule"]["id"]);

    if (json["dataElement"] != null) {
      dataElement.target =
          D2DataElementRepository(db).getByUid(json["dataElement"]["id"]);
    }
    if (json["trackedEntityAttribute"] != null) {
      trackedEntityAttribute.target = D2TrackedEntityAttributeRepository(db)
          .getByUid(json["trackedEntityAttribute"]["id"]);
    }
    if (json["programStageSection"] != null) {
      programStageSection.target = D2ProgramStageSectionRepository(db)
          .getByUid(json["programStageSection"]["id"]);
    }
    if (json["programSection"] != null) {
      programSection.target =
          D2ProgramSectionRepository(db).getByUid(json["programSection"]["id"]);
    }
  }

  @override
  String? displayName;
}
