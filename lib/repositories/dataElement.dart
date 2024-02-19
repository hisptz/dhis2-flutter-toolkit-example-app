import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2DataElementBox = db.store.box<DataElement>();

class D2DataElementRepository extends BaseRepository<DataElement> {
  D2DataElementRepository() : super(d2DataElementBox);

  @override
  DataElement? getByUid(String uid) {
    Query<DataElement> query =
        d2DataElementBox.query(DataElement_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }
}
