import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/systemInfo.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2SystemInfo extends DHIS2Resource {
  int id = 0;

  String version;
  String revision;
  String calendar;
  String dateFormat;
  String contextPath;
  @Unique()
  String systemId;
  @Index()
  String systemName;

  D2SystemInfo(
      {required this.version,
      required this.revision,
      required this.calendar,
      required this.dateFormat,
      required this.contextPath,
      required this.systemId,
      required this.systemName});

  D2SystemInfo.fromMap(Map json)
      : calendar = json["calendar"],
        revision = json["revision"],
        dateFormat = json["dateFormat"],
        version = json["version"],
        contextPath = json["contextPath"],
        systemName = json["systemName"],
        systemId = json["systemId"] {
    id = SystemInfoRepository().getIdByUid(json["systemId"]) ?? 0;
  }
}
