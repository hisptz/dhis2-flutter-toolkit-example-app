import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class SystemInfoSync extends BaseSyncService<SystemInfo> {
  SystemInfoSync()
      : super(
            fields: ["*"],
            resource: "system/info",
            box: systemInfoBox,
            label: "System Information");

  @override
  Future<BaseSyncService<SystemInfo>> get() async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>();
    if (data == null) {
      return this;
    }
    entity = SystemInfo.fromMap(data);
    return this;
  }
}
