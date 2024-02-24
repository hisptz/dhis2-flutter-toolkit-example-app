import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';

import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2DataValue extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  @override
  String uid;

  String value;
  bool providedElsewhere;

  D2DataValue(
      {required this.updatedAt,
      required this.createdAt,
      required this.uid,
      required this.value,
      required this.providedElsewhere});

  D2DataValue.fromMap(Map json)
      : updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        uid = json["dataElement"],
        value = json["value"] ?? "",
        providedElsewhere = json["providedElsewhere"];
}
