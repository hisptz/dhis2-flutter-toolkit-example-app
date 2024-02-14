import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

final systemInfoBox = db.store.box<SystemInfo>();

@Entity()
class SystemInfo extends DHIS2Resource {
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

  SystemInfo(
      {required this.version,
      required this.revision,
      required this.calendar,
      required this.dateFormat,
      required this.contextPath,
      required this.systemId,
      required this.systemName});

  SystemInfo.fromMap(Map json)
      : calendar = json["calendar"],
        revision = json["revision"],
        dateFormat = json["dateFormat"],
        version = json["version"],
        contextPath = json["contextPath"],
        systemName = json["systemName"],
        systemId = json["systemId"];
}
