import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programRuleAction.dart';
import 'package:objectbox/objectbox.dart';

import 'program.dart';

@Entity()
class ProgramRule extends D2MetadataResource {
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
  final programRuleActions = ToMany<ProgramRuleAction>();

  ProgramRule(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.description,
      required this.condition});

  ProgramRule.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        description = json["description"],
        condition = json["condition"] {
    List<ProgramRuleAction> attributeValue =
        json["programRuleActions"].map(ProgramRuleAction.fromMap);

    programRuleActions.addAll(attributeValue);
  }
}
