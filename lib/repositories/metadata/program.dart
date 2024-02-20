import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramBox = db.store.box<D2Program>();

class D2ProgramRepository extends BaseRepository<D2Program> {
  D2ProgramRepository() : super(d2ProgramBox);

  @override
  D2Program? getByUid(String uid) {
    Query<D2Program> query =
        d2ProgramBox.query(D2Program_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Program mapper(Map<String, dynamic> json) {
    return D2Program.fromMap(json);
  }
}
