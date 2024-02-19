import 'package:dhis2_flutter_toolkit/models/metadata/programTrackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramTrackedEntityAttributeBox =
    db.store.box<D2ProgramTrackedEntityAttribute>();

class D2ProgramTrackedEntityAttributeRepository
    extends BaseRepository<D2ProgramTrackedEntityAttribute> {
  D2ProgramTrackedEntityAttributeRepository()
      : super(d2ProgramTrackedEntityAttributeBox);

  @override
  D2ProgramTrackedEntityAttribute? getByUid(String uid) {
    Query<D2ProgramTrackedEntityAttribute> query =
        d2ProgramTrackedEntityAttributeBox
            .query(D2ProgramTrackedEntityAttribute_.uid.equals(uid))
            .build();
    return query.findFirst();
  }
}
