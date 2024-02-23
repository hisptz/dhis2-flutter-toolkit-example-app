import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';

import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2DataValue extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String value;
  bool providedElsewhere;

  D2DataValue(
      {required this.lastUpdated,
      required this.created,
      required this.uid,
      required this.value,
      required this.providedElsewhere});

  D2DataValue.fromMap(Map json)
      : lastUpdated = DateTime.parse(json["updatedAt"]),
        created = DateTime.parse(json["createdAt"]),
        uid = json["dataElement"],
        value = json["value"],
        providedElsewhere = json["providedElsewhere"];
}
