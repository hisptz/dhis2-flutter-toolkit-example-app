import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2TrackedEntityTypeBox = db.store.box<D2TrackedEntityType>();

class D2TrackedEntityTypeRepository
    extends BaseRepository<D2TrackedEntityType> {
  D2TrackedEntityTypeRepository() : super(d2TrackedEntityTypeBox);

  @override
  D2TrackedEntityType? getByUid(String uid) {
    Query<D2TrackedEntityType> query = d2TrackedEntityTypeBox
        .query(D2TrackedEntityType_.uid.equals(uid))
        .build();
    return query.findFirst();
  }

  @override
  D2TrackedEntityType mapper(Map<String, dynamic> json) {
    return D2TrackedEntityType.fromMap(json);
  }
}
