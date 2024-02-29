import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2UserRoleRepository extends BaseRepository<D2UserRole> {
  D2UserRoleRepository(super.db);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2UserRole? getByUid(String uid) {
    Query<D2UserRole> query = box.query(D2UserRole_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2UserRole mapper(Map<String, dynamic> json) {
    return D2UserRole.fromMap(db, json);
  }
}
