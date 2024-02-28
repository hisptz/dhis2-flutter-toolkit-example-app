import 'package:dhis2_flutter_toolkit/models/metadata/option.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2OptionRepository extends BaseRepository<D2Option> {
  D2OptionRepository(super.db);

  @override
  D2Option? getByUid(String uid) {
    Query<D2Option> query = box.query(D2Option_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Option mapper(Map<String, dynamic> json) {
    return D2Option.fromMap(db, json);
  }
}
