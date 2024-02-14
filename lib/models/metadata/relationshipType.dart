import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/relationshipConstraint.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class RelationshipType extends DHIS2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;
  String name;
  String code;
  bool bidirectional;
  bool referral;
  String fromToName;
  String toFromName;

  final fromConstraint = ToOne<RelationshipConstraint>();
  final toConstraint = ToOne<RelationshipConstraint>();

  RelationshipType(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.code,
      required this.bidirectional,
      required this.referral,
      required this.fromToName,
      required this.toFromName});

  RelationshipType.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"],
        bidirectional = json["bidirectional"],
        referral = json["referral"],
        fromToName = json["fromToName"],
        toFromName = json["toFromName"];
}
