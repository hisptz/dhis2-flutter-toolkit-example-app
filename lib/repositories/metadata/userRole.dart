import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2UserRoleBox = db.store.box<DHIS2UserRole>();

class D2UserRoleRepository extends BaseRepository<DHIS2UserRole> {
  D2UserRoleRepository() : super(d2UserRoleBox);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  DHIS2UserRole? getByUid(String uid) {
    Query<DHIS2UserRole> query =
        d2UserRoleBox.query(DHIS2UserRole_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
