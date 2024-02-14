import 'dart:html';

import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'programRule.dart';

class ProgramRuleAction implements DHIS2MetadataResource {
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
  final programRule = ToOne<ProgramRule>();
  final dataElement = ToOne<DataElement>();
  final programStageSection = ToOne<ProgramStageSection>();
  final programSection = ToOne<ProgramSection>();
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();

  ProgramRuleAction(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.programRuleActionType,
      this.content,
      this.data,
      this.location});

  ProgramRuleAction.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        programRuleActionType = json["programRuleActionType"],
        content = json["content"],
        data = json["data"],
        location = json["location"];
}
