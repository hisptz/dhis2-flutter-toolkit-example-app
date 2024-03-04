import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
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

  D2SystemInfo(this.id, this.version, this.revision, this.calendar,
      this.dateFormat, this.contextPath, this.systemId, this.systemName);

  D2SystemInfo.fromMap(ObjectBox db, Map json)
      : calendar = json["calendar"],
        revision = json["revision"],
        dateFormat = json["dateFormat"],
        version = json["version"],
        contextPath = json["contextPath"],
        systemName = json["systemName"],
        systemId = json["systemId"] {
    id = SystemInfoRepository(db).getIdByUid(json["systemId"]) ?? 0;
  }
}
