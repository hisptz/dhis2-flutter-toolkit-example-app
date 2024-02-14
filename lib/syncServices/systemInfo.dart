import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class SystemInfoRepository extends BaseSyncService<SystemInfo> {
  SystemInfoRepository()
      : super(
            fields: ["*"], resource: "system/info", mapper: SystemInfo.fromMap);

  @override
  Future<BaseSyncService<SystemInfo>> get() async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>();
    if (data == null) {
      return this;
    }
    entity = SystemInfo.fromMap(data);
    return this;
  }

  @override
  Future<BaseSyncService<SystemInfo>> save() async {
    return this;
  }
}
