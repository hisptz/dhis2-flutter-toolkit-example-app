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
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;
  String relationshipName;
  bool bidirectional;
  String relationshipType;

  final from = ToOne<FromRelationship>();
  final to = ToOne<ToRelationship>();

  Relationship({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.relationshipName,
    required this.relationshipType,
    required this.bidirectional,
  });

  Relationship.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["relationship"],
        relationshipName = json["relationshipName"],
        relationshipType = json["relationshipType"],
        bidirectional = json["bidirectional"];
}
