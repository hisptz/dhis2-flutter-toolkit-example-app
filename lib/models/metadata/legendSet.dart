import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

import 'legend.dart';

@Entity()
class LegendSet implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String code;

  final legends = ToMany<Legend>();

  LegendSet({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.name,
    required this.code,
  });

  LegendSet.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"] {
    List<Legend> allLegends = json["legends"].map(LegendSet.fromMap);
    legends.addAll(allLegends);
  }
}
