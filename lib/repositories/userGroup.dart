import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../objectbox.g.dart';

final d2UserGroupBox = db.store.box<DHIS2UserGroup>();

class D2UserGroupRepository extends BaseRepository<DHIS2UserGroup> {
  D2UserGroupRepository() : super(d2UserGroupBox);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  DHIS2UserGroup? getByUid(String uid) {
    Query<DHIS2UserGroup> query =
        d2UserGroupBox.query(DHIS2UserGroup_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
