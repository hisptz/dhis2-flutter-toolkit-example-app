import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

class EventRepository extends BaseRepository<D2Event> {
  EventRepository(super.db);

  @override
  D2Event? getByUid(String uid) {
    Query<D2Event> query = box.query(D2Event_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Event mapper(Map<String, dynamic> json) {
    return D2Event.fromMap(json);
  }
}
