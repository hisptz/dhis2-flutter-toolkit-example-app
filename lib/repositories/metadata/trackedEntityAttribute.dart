import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2TrackedEntityAttributeBox = db.store.box<D2TrackedEntityAttribute>();

class D2TrackedEntityAttributeRepository
    extends BaseRepository<D2TrackedEntityAttribute> {
  D2TrackedEntityAttributeRepository() : super(d2TrackedEntityAttributeBox);

  @override
  D2TrackedEntityAttribute? getByUid(String uid) {
    Query<D2TrackedEntityAttribute> query = d2TrackedEntityAttributeBox
        .query(D2TrackedEntityAttribute_.uid.equals(uid))
        .build();

    return query.findFirst();
  }

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  @override
  D2TrackedEntityAttribute mapper(Map<String, dynamic> json) {
    return D2TrackedEntityAttribute.fromMap(json);
  }
}
