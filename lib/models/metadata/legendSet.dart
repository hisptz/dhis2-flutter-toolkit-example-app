import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/legendSet.dart';
import 'package:objectbox/objectbox.dart';

import 'legend.dart';

@Entity()
class D2LegendSet extends D2MetadataResource {
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

  final legends = ToMany<D2Legend>();

  D2LegendSet({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.name,
    this.code,
  });

  D2LegendSet.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"] {
    List<D2Legend> allLegends = json["legends"]
        .cast<Map>()
        .map<D2Legend>((Map json) => D2Legend.fromMap(db, json))
        .toList();
    legends.addAll(allLegends);

    id = D2LegendSetRepository(db).getIdByUid(json["id"]) ?? 0;
  }
}
