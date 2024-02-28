import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnitGroup.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2OrgUnitGroupRepository extends BaseRepository<D2OrganisationUnitGroup> {
  D2OrgUnitGroupRepository(super.db);

  @override
  D2OrganisationUnitGroup? getByUid(String uid) {
    Query<D2OrganisationUnitGroup> query =
        box.query(D2OrganisationUnitGroup_.uid.equals(uid)).build();

    return query.findFirst();
  }

  @override
  D2OrganisationUnitGroup mapper(Map<String, dynamic> json) {
    return D2OrganisationUnitGroup.fromMap(db, json);
  }
}
