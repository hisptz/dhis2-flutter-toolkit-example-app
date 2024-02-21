import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2UserRoleBox = db.store.box<D2UserRole>();

class D2UserRoleRepository extends BaseRepository<D2UserRole> {
  D2UserRoleRepository() : super(d2UserRoleBox);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2UserRole? getByUid(String uid) {
    Query<D2UserRole> query =
        d2UserRoleBox.query(D2UserRole_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2UserRole mapper(Map<String, dynamic> json) {
    return D2UserRole.fromMap(json);
  }
}
