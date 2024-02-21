import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:objectbox/objectbox.dart';

final d2DataElementBox = db.store.box<D2DataElement>();

class D2DataElementRepository extends BaseRepository<D2DataElement> {
  D2DataElementRepository() : super(d2DataElementBox);

  @override
  D2DataElement? getByUid(String uid) {
    Query<D2DataElement> query =
        d2DataElementBox.query(D2DataElement_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2DataElement mapper(Map<String, dynamic> json) {
    return D2DataElement.fromMap(json);
  }
}
