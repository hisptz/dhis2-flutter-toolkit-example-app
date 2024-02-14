import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Legend implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String name;
  int startValue;
  int endValue;
  String color;
  String displayName;

  Legend(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.startValue,
      required this.endValue,
      required this.color,
      required this.displayName});

  Legend.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        startValue = json["startValue"],
        endValue = json["endValue"],
        color = json["color"],
        displayName = json["displayName"];
}
