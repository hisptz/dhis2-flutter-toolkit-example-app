import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2ProgramRepository extends BaseRepository<D2Program> {
  D2ProgramRepository(super.db);

  @override
  D2Program? getByUid(String uid) {
    Query<D2Program> query = box.query(D2Program_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Program mapper(Map<String, dynamic> json) {
    return D2Program.fromMap(db, json);
  }

  D2ProgramRepository byIdentifiableToken(String keyword) {
    queryConditions = D2Program_.uid
        .equals(keyword)
        .or(D2Program_.name.contains(keyword, caseSensitive: false))
        .or(D2Program_.shortName.contains(keyword, caseSensitive: false));
    return this;
  }
}
