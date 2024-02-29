import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

Map getRelationshipConstraints(Map json) {
  if (json["trackedEntity"] != null) {
    return {
      "type": "trackedEntity",
      "id": json["trackedEntity"]["trackedEntity"]
    };
  } else if (json["enrollment"] != null) {
    return {"type": "enrollment", "id": json["enrollment"]["enrollment"]};
  } else if (json["event"] != null) {
    return {"type": "event", "id": json["event"]["event"]};
  } else {
    return {};
  }
}

@Entity()
class D2Relationship extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  @Unique()
  String uid;
  String relationshipName;
  bool bidirectional;
  String relationshipType;

  late String fromType;

  late String fromId;

  late String toType;
  late String toId;

  D2Relationship({
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
    required this.relationshipName,
    required this.relationshipType,
    required this.bidirectional,
    required this.fromId,
    required this.fromType,
    required this.toType,
    required this.toId,
  });

  D2Relationship.fromMap(ObjectBox db, Map json)
      : createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        uid = json["relationship"],
        relationshipName = json["relationshipName"],
        relationshipType = json["relationshipType"],
        bidirectional = json["bidirectional"] {
    id = RelationshipRepository(db).getIdByUid(json["relationship"]) ?? 0;

    Map from = json["from"];
    Map to = json["to"];

    Map fromData = getRelationshipConstraints(from);
    fromType = fromData["type"];
    fromId = fromData["id"];

    Map toData = getRelationshipConstraints(to);
    toType = toData["type"];
    toId = toData["id"];
  }
}
