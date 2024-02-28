import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnitLevel.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2OrgUnitLevelRepository extends BaseRepository<D2OrganisationUnitLevel> {
  D2OrgUnitLevelRepository(super.db);

  @override
  D2OrganisationUnitLevel? getByUid(String uid) {
    Query<D2OrganisationUnitLevel> query =
        box.query(D2OrganisationUnitLevel_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2OrganisationUnitLevel mapper(Map<String, dynamic> json) {
    return D2OrganisationUnitLevel.fromMap(db, json);
  }
}
