import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/sync.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2DataValue extends D2DataResource implements SyncableData {
  @override
  int id = 0;
  @override
  DateTime createdAt;
  @override
  DateTime updatedAt;

  String? value;
  bool providedElsewhere;

  final event = ToOne<D2Event>();

  final dataElement = ToOne<D2DataElement>();

  D2DataValue(this.id, this.createdAt, this.updatedAt, this.value,
      this.providedElsewhere, this.synced);

  D2DataValue.fromMap(ObjectBox db, Map json, String eventId)
      : updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        value = json["value"],
        providedElsewhere = json["providedElsewhere"] {
    event.target = D2EventRepository(db).getByUid(eventId);

    dataElement.target =
        D2DataElementRepository(db).getByUid(json["dataElement"]);
  }

  @override
  bool synced = true;

  @override
  Future<Map<String, dynamic>> toMap({ObjectBox? db}) async {
    return {"dataElement": dataElement.target?.uid, "value": value};
  }
}
