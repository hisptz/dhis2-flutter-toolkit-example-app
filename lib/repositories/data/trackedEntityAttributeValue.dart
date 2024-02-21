import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final d2TrackedEntityAttributeValueBox =
    db.store.box<D2TrackedEntityAttributeValue>();

class TrackedEntityAttributeValueRepository
    extends BaseRepository<D2TrackedEntityAttributeValue> {
  TrackedEntityAttributeValueRepository()
      : super(d2TrackedEntityAttributeValueBox);

  @override
  D2TrackedEntityAttributeValue? getByUid(String uid) {
    Query<D2TrackedEntityAttributeValue> query =
        d2TrackedEntityAttributeValueBox
            .query(D2TrackedEntityAttributeValue_.uid.equals(uid))
            .build();
    return query.findFirst();
  }

  @override
  D2TrackedEntityAttributeValue mapper(Map<String, dynamic> json) {
    return D2TrackedEntityAttributeValue.fromMap(json);
  }
}
