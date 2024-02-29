import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/singleBase.dart';

class SystemInfoSync extends BaseSingleSyncService<D2SystemInfo> {
  SystemInfoSync(ObjectBox db, DHIS2Client client)
      : super(
            fields: ["*"],
            resource: "system/info",
            db: db,
            client: client,
            label: "System Information");

  @override
  D2SystemInfo mapper(Map<String, dynamic> json) {
    return D2SystemInfo.fromMap(db, json);
  }
}
