import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox.g.dart';

class SystemInfoRepository extends BaseRepository<SystemInfo> {
  SystemInfoRepository() : super(systemInfoBox);

  SystemInfo? get() {
    Query<SystemInfo> query = box.query().build();
    return query.findFirst();
  }
}
