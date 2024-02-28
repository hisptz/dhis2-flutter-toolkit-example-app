import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

class D2UserRepository extends BaseRepository<D2User> {
  D2UserRepository(super.db);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  D2User? get() {
    Query query = box.query().build();
    return query.findFirst();
  }

  @override
  D2User? getByUid(String uid) {
    Query<D2User> query = box.query(D2User_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2User mapper(Map<String, dynamic> json) {
    return D2User.fromMap(db, json);
  }
}
