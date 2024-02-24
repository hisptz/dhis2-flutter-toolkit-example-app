import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2TrackedEntityAttributeValue extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  @override
  String uid;
  String displayName;
  String code;
  String value;
  String valueType;

  D2TrackedEntityAttributeValue({
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
    required this.displayName,
    required this.code,
    required this.value,
    required this.valueType,
  });

  D2TrackedEntityAttributeValue.fromMap(Map json)
      : createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        uid = json["attribute"],
        displayName = json["displayName"],
        code = json["code"] ?? "",
        value = json["value"],
        valueType = json["valueType"];
}
