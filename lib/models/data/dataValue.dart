import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';

import '../../objectbox.g.dart';

final d2DataValueBox = db.store.box<D2DataValue>();

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
      : lastUpdated = DateTime.parse(json["lastUpdated"]),
        created = DateTime.parse(json["created"]),
        uid = json["dataElement"],
        value = json["value"],
        providedElsewhere = json["providedElsewhere"];
}