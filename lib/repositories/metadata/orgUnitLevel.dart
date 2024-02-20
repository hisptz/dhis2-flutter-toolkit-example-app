import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnitLevel.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2OrgUnitLevelBox = db.store.box<D2OrganisationUnitLevel>();

class D2OrgUnitLevelRepository extends BaseRepository<D2OrganisationUnitLevel> {
  D2OrgUnitLevelRepository() : super(d2OrgUnitLevelBox);

  @override
  D2OrganisationUnitLevel? getByUid(String uid) {
    Query<D2OrganisationUnitLevel> query = d2OrgUnitLevelBox
        .query(D2OrganisationUnitLevel_.uid.equals(uid))
        .build();
    return query.findFirst();
  }

  @override
  D2OrganisationUnitLevel mapper(Map<String, dynamic> json) {
    return D2OrganisationUnitLevel.fromMap(json);
  }
}
