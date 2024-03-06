import 'package:dhis2_flutter_toolkit/models/data/base.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/uploadBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2DataValue extends D2DataResource implements SyncableData {
  @override
  int id = 0;
  @override
  DateTime createdAt;
  @override
  DateTime updatedAt;

  @Unique()
  String uid;

  String? value;
  bool providedElsewhere;

  final event = ToOne<D2Event>();

  final dataElement = ToOne<D2DataElement>();

  D2DataValue(this.uid, this.id, this.createdAt, this.updatedAt, this.value,
      this.providedElsewhere, this.synced);

  D2DataValue.fromMap(ObjectBox db, Map json, String eventId)
      : updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        uid = "$eventId-${json["dataElement"]}",
        value = json["value"],
        providedElsewhere = json["providedElsewhere"] {
    String uid = "$eventId-${json["dataElement"]}";
    id = D2DataValueRepository(db).getIdByUid(uid) ?? 0;

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
