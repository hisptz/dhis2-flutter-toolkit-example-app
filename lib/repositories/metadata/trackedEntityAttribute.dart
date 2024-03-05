import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/base.dart';

class D2TrackedEntityAttributeRepository
    extends BaseMetaRepository<D2TrackedEntityAttribute> {
  D2TrackedEntityAttributeRepository(super.db);

  @override
  D2TrackedEntityAttribute? getByUid(String uid) {
    Query<D2TrackedEntityAttribute> query =
        box.query(D2TrackedEntityAttribute_.uid.equals(uid)).build();

    return query.findFirst();
  }

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2TrackedEntityAttribute mapper(Map<String, dynamic> json) {
    return D2TrackedEntityAttribute.fromMap(db, json);
  }
}
