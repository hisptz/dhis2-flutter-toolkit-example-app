import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2OrgUnitRepository extends BaseRepository<D2OrgUnit> {
  D2OrgUnitRepository(super.db);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2OrgUnit? getByUid(String uid) {
    Query<D2OrgUnit> query = box.query(D2OrgUnit_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2OrgUnit mapper(Map<String, dynamic> json) {
    return D2OrgUnit.fromMap(db, json);
  }
}
