import 'package:dhis2_flutter_toolkit/models/metadata/relationshipType.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2RelationshipTypeRepository extends BaseRepository<D2RelationshipType> {
  D2RelationshipTypeRepository(super.db);

  @override
  D2RelationshipType? getByUid(String uid) {
    Query<D2RelationshipType> query =
        box.query(D2RelationshipType_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2RelationshipType mapper(Map<String, dynamic> json) {
    return D2RelationshipType.fromMap(db, json);
  }
}
