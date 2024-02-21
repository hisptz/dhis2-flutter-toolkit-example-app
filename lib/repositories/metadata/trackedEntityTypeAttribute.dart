import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityTypeAttribute.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2TrackedEntityTypeAttributeBox =
    db.store.box<D2TrackedEntityTypeAttribute>();

class D2TrackedEntityTypeAttributeRepository
    extends BaseRepository<D2TrackedEntityTypeAttribute> {
  D2TrackedEntityTypeAttributeRepository()
      : super(d2TrackedEntityTypeAttributeBox);

  @override
  D2TrackedEntityTypeAttribute? getByUid(String uid) {
    Query<D2TrackedEntityTypeAttribute> query = d2TrackedEntityTypeAttributeBox
        .query(D2TrackedEntityTypeAttribute_.uid.equals(uid))
        .build();
    return query.findFirst();
  }

  @override
  D2TrackedEntityTypeAttribute mapper(Map<String, dynamic> json) {
    return D2TrackedEntityTypeAttribute.fromMap(json);
  }
}
