import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityTypeAttribute.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/base.dart';

class D2TrackedEntityTypeAttributeRepository
    extends BaseMetaRepository<D2TrackedEntityTypeAttribute> {
  D2TrackedEntityTypeAttributeRepository(super.db);

  @override
  D2TrackedEntityTypeAttribute? getByUid(String uid) {
    Query<D2TrackedEntityTypeAttribute> query =
        box.query(D2TrackedEntityTypeAttribute_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2TrackedEntityTypeAttribute mapper(Map<String, dynamic> json) {
    return D2TrackedEntityTypeAttribute.fromMap(db, json);
  }
}
