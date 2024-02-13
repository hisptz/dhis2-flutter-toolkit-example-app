import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/relationshipConstraint.dart';
import 'package:objectbox/objectbox.dart';

class RelationshipType implements DHIS2MetadataResource {
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
