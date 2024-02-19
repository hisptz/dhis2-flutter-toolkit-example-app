import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:objectbox/objectbox.dart';

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

  // Map<String, dynamic> from; TODO: Setup actual relationship links
  // Map<String, dynamic> to;

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
