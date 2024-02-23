import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final trackedEntityBox = db.store.box<TrackedEntity>();

class TrackedEntityRepository extends BaseRepository<TrackedEntity> {
  TrackedEntityRepository() : super(trackedEntityBox);

  @override
  TrackedEntity? getByUid(String uid) {
    Query<TrackedEntity> query =
        trackedEntityBox.query(TrackedEntity_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  TrackedEntity mapper(Map<String, dynamic> json) {
    return TrackedEntity.fromMap(json);
  }

  TrackedEntityRepository byIdentifiableToken(String keyword) {
    queryConditions = TrackedEntity_.uid
        .equals(keyword)
        .or(TrackedEntity_.uid.contains(keyword, caseSensitive: false));
    return this;
  }
}
