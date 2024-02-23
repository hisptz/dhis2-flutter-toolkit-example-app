import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2OrgUnitBox = db.store.box<D2OrganisationUnit>();

class D2OrgUnitRepository extends BaseRepository<D2OrganisationUnit> {
  D2OrgUnitRepository() : super(d2OrgUnitBox);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2OrganisationUnit? getByUid(String uid) {
    Query<D2OrganisationUnit> query =
        d2OrgUnitBox.query(D2OrganisationUnit_.uid.equals(uid)).build();
    return query.findFirst();
  }

  D2OrganisationUnit getDefaultOrgUnit() {
    Query<D2OrganisationUnit> query =
        d2OrgUnitBox.query(D2OrganisationUnit_.level.equals(1)).build();

    Query query2 = box.query().build();

    return query.findFirst() ?? query2.findFirst();
  }

  @override
  D2OrganisationUnit mapper(Map<String, dynamic> json) {
    return D2OrganisationUnit.fromMap(json);
  }
}
