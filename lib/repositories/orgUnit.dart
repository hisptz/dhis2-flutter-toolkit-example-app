import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2OrgUnitBox = db.store.box<OrganisationUnit>();

class D2OrgUnitRepository extends BaseRepository<OrganisationUnit> {
  D2OrgUnitRepository() : super(d2OrgUnitBox);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  OrganisationUnit? getByUid(String uid) {
    Query<OrganisationUnit> query =
        d2OrgUnitBox.query(OrganisationUnit_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
