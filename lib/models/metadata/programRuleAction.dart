import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'programRule.dart';

@Entity()
class ProgramRuleAction extends DHIS2MetadataResource {
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

  final programRule = ToOne<ProgramRule>();
  final dataElement = ToOne<DataElement>();
  final programStageSection = ToOne<ProgramStageSection>();
  final programSection = ToOne<ProgramSection>();
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();

  ProgramRuleAction(this.created, this.lastUpdated, this.uid,
      this.programRuleActionType, this.content, this.data, this.location);
}
