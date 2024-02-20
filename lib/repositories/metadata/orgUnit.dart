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

  @override
  D2OrganisationUnit mapper(Map<String, dynamic> json) {
    return D2OrganisationUnit.fromMap(json);
  }
}
