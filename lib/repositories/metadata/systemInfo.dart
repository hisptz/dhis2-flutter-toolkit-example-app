import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final systemInfoBox = db.store.box<SystemInfo>();

class SystemInfoRepository extends BaseRepository<SystemInfo> {
  SystemInfoRepository() : super(systemInfoBox);

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  SystemInfo? get() {
    Query<SystemInfo> query = box.query().build();
    return query.findFirst();
  }

  @override
  SystemInfo? getByUid(String uid) {
    Query<SystemInfo> query =
        systemInfoBox.query(SystemInfo_.systemId.equals(uid)).build();
    return query.findFirst();
  }
}
