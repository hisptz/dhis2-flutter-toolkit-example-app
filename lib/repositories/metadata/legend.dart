import 'package:dhis2_flutter_toolkit/models/metadata/legend.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2LegendRepository extends BaseRepository<D2Legend> {
  D2LegendRepository(super.db);

  @override
  D2Legend? getByUid(String uid) {
    Query<D2Legend> query = box.query(D2Legend_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Legend mapper(Map<String, dynamic> json) {
    return D2Legend.fromMap(db, json);
  }
}
