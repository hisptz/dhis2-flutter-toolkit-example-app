import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/syncServices/singleBase.dart';

class SystemInfoSync extends BaseSingleSyncService<SystemInfo> {
  SystemInfoSync()
      : super(
            fields: ["*"],
            resource: "system/info",
            box: systemInfoBox,
            label: "System Information");

  @override
  SystemInfo mapper(Map<String, dynamic> json) {
    return SystemInfo.fromMap(json);
  }
}
