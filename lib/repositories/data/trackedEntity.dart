import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

class TrackedEntityRepository extends BaseRepository<TrackedEntity> {
  TrackedEntityRepository(super.db);

  @override
  TrackedEntity? getByUid(String uid) {
    Query<TrackedEntity> query =
        box.query(TrackedEntity_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  TrackedEntity mapper(Map<String, dynamic> json) {
    return TrackedEntity.fromMap(json);
  }
}
