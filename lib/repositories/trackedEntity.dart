import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox.g.dart';

class TrackedEntityRepository extends BaseRepository<TrackedEntity> {
  TrackedEntityRepository() : super(trackedEntityBox);

  List<TrackedEntity>? getAll() {
    Query query = box.query().build();
    return query.find() as List<TrackedEntity>;
  }

  TrackedEntity? get({id = String}) {
    Query query = box.query(TrackedEntity_.uid.equals(id)).build();
    return query.findFirst();
  }
}
