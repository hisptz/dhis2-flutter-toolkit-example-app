import 'package:dhis2_flutter_toolkit/models/metadata/legend.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2LegendBox = db.store.box<D2Legend>();

class D2LegendRepository extends BaseRepository<D2Legend> {
  D2LegendRepository() : super(d2LegendBox);

  @override
  D2Legend? getByUid(String uid) {
    Query<D2Legend> query =
        d2LegendBox.query(D2Legend_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Legend mapper(Map<String, dynamic> json) {
    return D2Legend.fromMap(json);
  }
}
