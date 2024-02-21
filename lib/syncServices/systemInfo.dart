import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/syncServices/singleBase.dart';

class SystemInfoSync extends BaseSingleSyncService<D2SystemInfo> {
  SystemInfoSync()
      : super(
            fields: ["*"],
            resource: "system/info",
            box: systemInfoBox,
            label: "System Information");

  @override
  D2SystemInfo mapper(Map<String, dynamic> json) {
    return D2SystemInfo.fromMap(json);
  }
}
