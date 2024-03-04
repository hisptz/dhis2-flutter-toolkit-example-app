import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnitGroup.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2OrgUnitGroupRepository extends BaseRepository<D2OrgUnitGroup> {
  D2OrgUnitGroupRepository(super.db);

  @override
  D2OrgUnitGroup? getByUid(String uid) {
    Query<D2OrgUnitGroup> query =
        box.query(D2OrgUnitGroup_.uid.equals(uid)).build();

    return query.findFirst();
  }

  @override
  D2OrgUnitGroup mapper(Map<String, dynamic> json) {
    return D2OrgUnitGroup.fromMap(db, json);
  }
}
