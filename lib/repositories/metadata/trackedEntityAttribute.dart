import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2TrackedEntityAttributeBox = db.store.box<TrackedEntityAttribute>();

class D2TrackedEntityAttributeRepository
    extends BaseRepository<TrackedEntityAttribute> {
  D2TrackedEntityAttributeRepository() : super(d2TrackedEntityAttributeBox);

  @override
  TrackedEntityAttribute? getByUid(String uid) {
    Query<TrackedEntityAttribute> query = d2TrackedEntityAttributeBox
        .query(TrackedEntityAttribute_.uid.equals(uid))
        .build();

    return query.findFirst();
  }

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }
}
