import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final d2EventBox = db.store.box<D2Event>();

class EventRepository extends BaseRepository<D2Event> {
  EventRepository() : super(d2EventBox);

  @override
  D2Event? getByUid(String uid) {
    Query<D2Event> query = d2EventBox.query(D2Event_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Event mapper(Map<String, dynamic> json) {
    return D2Event.fromMap(json);
  }
}
