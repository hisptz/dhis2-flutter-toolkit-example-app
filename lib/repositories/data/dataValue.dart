import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final d2DataValueBox = db.store.box<D2DataValue>();

class DataValueRepository extends BaseRepository<D2DataValue> {
  DataValueRepository() : super(d2DataValueBox);

  @override
  D2DataValue? getByUid(String uid) {
    Query<D2DataValue> query =
        d2DataValueBox.query(D2DataValue_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2DataValue mapper(Map<String, dynamic> json) {
    return D2DataValue.fromMap(json);
  }
}
