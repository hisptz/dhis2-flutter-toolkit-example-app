import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final d2TrackedEntityAttributeValueBox =
    db.store.box<D2TrackedEntityAttributeValue>();

class D2TrackedEntityAttributeValueRepository
    extends BaseRepository<D2TrackedEntityAttributeValue> {
  D2TrackedEntityAttributeValueRepository()
      : super(d2TrackedEntityAttributeValueBox);

  @override
  D2TrackedEntityAttributeValue? getById(int id) {
    Query<D2TrackedEntityAttributeValue> query =
        d2TrackedEntityAttributeValueBox
            .query(D2TrackedEntityAttributeValue_.trackedEntityAttribute
                .equals(id))
            .build();
    return query.findFirst();
  }

  D2TrackedEntityAttributeValueRepository byTrackedEntity(int id) {
    queryConditions = D2TrackedEntityAttributeValue_.trackedEntity.equals(id);
    return this;
  }

  @override
  D2TrackedEntityAttributeValue? getByUid(String uid) {
    return null;
  }

  @override
  D2TrackedEntityAttributeValue mapper(Map<String, dynamic> json) {
    return D2TrackedEntityAttributeValue.fromMap(json, "");
  }
}
