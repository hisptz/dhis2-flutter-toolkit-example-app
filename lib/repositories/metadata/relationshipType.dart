import 'package:dhis2_flutter_toolkit/models/metadata/relationshipType.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2RelationshipTypeBox = db.store.box<D2RelationshipType>();

class D2RelationshipTypeRepository extends BaseRepository<D2RelationshipType> {
  D2RelationshipTypeRepository() : super(d2RelationshipTypeBox);

  @override
  D2RelationshipType? getByUid(String uid) {
    Query<D2RelationshipType> query = d2RelationshipTypeBox
        .query(D2RelationshipType_.uid.equals(uid))
        .build();
    return query.findFirst();
  }
}
