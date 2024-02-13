import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programRuleAction.dart';
import 'package:objectbox/objectbox.dart';

import 'program.dart';

class ProgramRule implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String name;
  String description;
  String condition;

  final program = ToOne<Program>();
  final programRuleActions = ToMany<ProgramRuleAction>();

  ProgramRule(this.created, this.lastUpdated, this.uid, this.name,
      this.description, this.condition);
}
