import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final systemInfoBox = db.store.box<D2SystemInfo>();

class SystemInfoRepository extends BaseRepository<D2SystemInfo> {
  SystemInfoRepository() : super(systemInfoBox);

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
        systemInfoBox.query(D2SystemInfo_.systemId.equals(uid)).build();
    return query.findFirst();
  }
}
