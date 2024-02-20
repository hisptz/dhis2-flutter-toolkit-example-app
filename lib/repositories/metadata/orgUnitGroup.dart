import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnitGroup.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2OrganisationUnitGroupBox = db.store.box<D2OrganisationUnitGroup>();

class D2OrgUnitGroupRepository extends BaseRepository<D2OrganisationUnitGroup> {
  D2OrgUnitGroupRepository() : super(d2OrganisationUnitGroupBox);

  @override
  D2OrganisationUnitGroup? getByUid(String uid) {
    Query<D2OrganisationUnitGroup> query = d2OrganisationUnitGroupBox
        .query(D2OrganisationUnitGroup_.uid.equals(uid))
        .build();

    return query.findFirst();
  }

  @override
  D2OrganisationUnitGroup mapper(Map<String, dynamic> json) {
    return D2OrganisationUnitGroup.fromMap(json);
  }
}
