import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/systemInfo.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox.g.dart';

class SystemInfoRepository extends BaseRepository<D2SystemInfo> {
  SystemInfoRepository() : super(systemInfoBox);

  D2SystemInfo? get() {
    Query<D2SystemInfo> query = box.query().build();
    return query.findFirst();
  }
}
