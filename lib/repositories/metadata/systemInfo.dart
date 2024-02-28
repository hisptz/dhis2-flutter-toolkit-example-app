import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

class SystemInfoRepository extends BaseRepository<D2SystemInfo> {
  SystemInfoRepository(super.db);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  D2SystemInfo? get() {
    Query<D2SystemInfo> query = box.query().build();
    return query.findFirst();
  }

  @override
  D2SystemInfo? getByUid(String uid) {
    Query<D2SystemInfo> query =
        box.query(D2SystemInfo_.systemId.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2SystemInfo mapper(Map<String, dynamic> json) {
    return D2SystemInfo.fromMap(db, json);
  }
}
