import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final d2DataValueBox = db.store.box<D2DataValue>();

class DataValueRepository extends BaseRepository<D2DataValue> {
  DataValueRepository() : super(d2DataValueBox);

  @override
  D2DataValue? getByUid(String uid) {
    return null;
  }

  @override
  D2DataValue mapper(Map<String, dynamic> json) {
    return D2DataValue.fromMap(json, "");
  }
}
