import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final d2UserGroupBox = db.store.box<D2UserGroup>();

class D2UserGroupRepository extends BaseRepository<D2UserGroup> {
  D2UserGroupRepository() : super(d2UserGroupBox);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2UserGroup? getByUid(String uid) {
    Query<D2UserGroup> query =
        d2UserGroupBox.query(D2UserGroup_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
