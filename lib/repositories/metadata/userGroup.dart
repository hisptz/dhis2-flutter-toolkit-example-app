import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

class D2UserGroupRepository extends BaseRepository<D2UserGroup> {
  D2UserGroupRepository(super.db);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2UserGroup? getByUid(String uid) {
    Query<D2UserGroup> query = box.query(D2UserGroup_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2UserGroup mapper(Map<String, dynamic> json) {
    return D2UserGroup.fromMap(db, json);
  }
}
