import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
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

  String? value;
  bool providedElsewhere;

  final event = ToOne<D2Event>();

  final dataElement = ToOne<D2DataElement>();

  D2DataValue(
      {required this.updatedAt,
      required this.createdAt,
      required this.value,
      required this.providedElsewhere});

  D2DataValue.fromMap(ObjectBox db, Map json, String eventId)
      : updatedAt = DateTime.parse(json["updatedAt"]),
        createdAt = DateTime.parse(json["createdAt"]),
        value = json["value"],
        providedElsewhere = json["providedElsewhere"] {
    event.target = D2EventRepository(db).getByUid(eventId);

    dataElement.target =
        D2DataElementRepository(db).getByUid(json["dataElement"]);
  }
}
