import 'package:objectbox/objectbox.dart';

@Entity()
class SystemInfo {
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

  SystemInfo(this.id, this.version, this.revision, this.calendar,
      this.dateFormat, this.contextPath, this.systemId, this.systemName);

  SystemInfo.fromMap(Map json)
      : calendar = json["calendar"],
        revision = json["revision"],
        dateFormat = json["dateFormat"],
        version = json["version"],
        contextPath = json["contextPath"],
        systemName = json["systemName"],
        systemId = json["systemId"];
}
