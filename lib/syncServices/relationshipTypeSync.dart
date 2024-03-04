import 'package:dhis2_flutter_toolkit/models/metadata/relationshipType.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class D2RelationshipTypeSync extends BaseSyncService<D2RelationshipType> {
  D2RelationshipTypeSync({required super.db, required super.client})
      : super(
            resource: "relationshipTypes",
            fields: ["*"],
            label: "Relationship Types");

  @override
  D2RelationshipType mapper(Map<String, dynamic> json) {
    return D2RelationshipType.fromMap(db, json);
  }
}
