import 'package:dhis2_flutter_toolkit/models/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2LegendSetBox = db.store.box<D2LegendSet>();

class D2LegendSetRepository extends BaseRepository<D2LegendSet> {
  D2LegendSetRepository() : super(d2LegendSetBox);

  @override
  D2LegendSet? getByUid(String uid) {
    Query<D2LegendSet> query =
        d2LegendSetBox.query(D2LegendSet_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2LegendSet mapper(Map<String, dynamic> json) {
    return D2LegendSet.fromMap(json);
  }
}
