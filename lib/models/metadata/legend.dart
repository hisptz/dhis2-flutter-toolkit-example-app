import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2Legend extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String name;
  double startValue;
  double endValue;
  String color;
  String displayName;

  D2Legend(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.startValue,
      required this.endValue,
      required this.color,
      required this.displayName});

  D2Legend.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        startValue = json["startValue"].toDouble(),
        endValue = json["endValue"].toDouble(),
        color = json["color"],
        displayName = json["displayName"];
}
