import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

class DataValueRepository extends BaseRepository<D2DataValue> {
  DataValueRepository(super.db);

  @override
  D2DataValue? getByUid(String uid) {
    Query<D2DataValue> query = box.query(D2DataValue_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2DataValue mapper(Map<String, dynamic> json) {
    return D2DataValue.fromMap(json);
  }
}
