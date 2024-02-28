import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/relationshipConstraint.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/relationshipType.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2RelationshipType extends D2MetadataResource {
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

  final fromConstraint = ToOne<D2RelationshipConstraint>();
  final toConstraint = ToOne<D2RelationshipConstraint>();

  D2RelationshipType(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.code,
      required this.bidirectional,
      required this.referral,
      required this.fromToName,
      required this.toFromName});

  D2RelationshipType.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"],
        bidirectional = json["bidirectional"],
        referral = json["referral"],
        fromToName = json["fromToName"],
        toFromName = json["toFromName"] {
    id = D2RelationshipTypeRepository(db).getIdByUid(json["id"]) ?? 0;
  }
}
