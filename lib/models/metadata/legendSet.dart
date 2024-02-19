import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

import 'legend.dart';

@Entity()
class LegendSet extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String? code;

  final legends = ToMany<Legend>();

  LegendSet({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.name,
    this.code,
  });

  LegendSet.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"] {
    List<Legend> allLegends =
        json["legends"].cast<Map>().map<Legend>(Legend.fromMap).toList();
    legends.addAll(allLegends);
  }
}
