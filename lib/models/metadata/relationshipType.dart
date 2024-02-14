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
      this.created,
      this.lastUpdated,
      this.uid,
      this.name,
      this.code,
      this.bidirectional,
      this.referral,
      this.fromToName,
      this.toFromName);
}
