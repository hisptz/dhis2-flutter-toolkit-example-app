import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/base.dart';

import '../../objectbox.g.dart';

class D2DataValueRepository extends BaseDataRepository<D2DataValue> {
  D2DataValueRepository(super.db);

  @override
  D2DataValue? getByUid(String uid) {
    return box.query(D2DataValue_.uid.equals(uid)).build().findFirst();
  }

  @override
  D2DataValue mapper(Map<String, dynamic> json) {
    return D2DataValue.fromMap(db, json, "");
  }

  D2DataValueRepository byEvent(int id) {
    queryConditions = D2DataValue_.event.equals(id);
    return this;
  }

  Future<List<D2DataValue>> getByEvent(D2Event event) async {
    queryConditions = D2DataValue_.dataElement.equals(event.id);
    return query.findAsync();
  }

  @override
  Future saveEntities(List<D2DataValue> entities) async {
    return box.putManyAsync(entities);
  }
}
