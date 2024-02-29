import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programRuleAction.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRule.dart';
import 'package:objectbox/objectbox.dart';

import 'program.dart';

@Entity()
class D2ProgramRule extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String name;
  String description;
  String condition;

  var program = ToOne<D2Program>();

  @Backlink("programRule")
  final programRuleActions = ToMany<D2ProgramRuleAction>();

  D2ProgramRule(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.description,
      required this.condition});

  D2ProgramRule.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        description = json["description"],
        condition = json["condition"] {
    id = D2ProgramRuleRepository(db).getIdByUid(json["id"]) ?? 0;

    program.target = D2ProgramRepository(db).getByUid(json["program"]["id"]);
  }
}
