import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/fromRelationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/toRelationship.dart';

import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class Relationship extends D2DataResource {
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

  final from = ToOne<FromRelationship>();
  final to = ToOne<ToRelationship>();

  Relationship({
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
    required this.relationshipName,
    required this.relationshipType,
    required this.bidirectional,
  });

  Relationship.fromMap(Map json)
      : createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        uid = json["relationship"],
        relationshipName = json["relationshipName"],
        relationshipType = json["relationshipType"],
        bidirectional = json["bidirectional"] {
    FromRelationship from = FromRelationship.fromMap(json["from"]);
    ToRelationship to = ToRelationship.fromMap(json["to"]);
    fromRelationshipBox.putAndGetAsync(from);
    toRelationshipBox.putAndGetAsync(to);

    // from.target = FromRelationshipRepository().getByUid(json["from"]);
  }
}
