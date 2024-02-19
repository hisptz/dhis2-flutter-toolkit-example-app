import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';

import '../../objectbox.g.dart';

final d2TrackedEntityAttributeValueBox =
    db.store.box<D2TrackedEntityAttributeValue>();

@Entity()
class D2TrackedEntityAttributeValue extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;
  String displayName;
  String code;
  String value;
  String valueType;

  D2TrackedEntityAttributeValue({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.displayName,
    required this.code,
    required this.value,
    required this.valueType,
  });

  D2TrackedEntityAttributeValue.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["attribute"],
        displayName = json["displayName"],
        code = json["code"],
        value = json["value"],
        valueType = json["valueType"];
}
