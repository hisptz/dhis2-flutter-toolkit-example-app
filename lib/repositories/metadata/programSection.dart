import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2ProgramSectionRepository extends BaseRepository<D2ProgramSection> {
  D2ProgramSectionRepository(super.db);

  @override
  D2ProgramSection? getByUid(String uid) {
    Query<D2ProgramSection> query =
        box.query(D2ProgramSection_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2ProgramSection mapper(Map<String, dynamic> json) {
    return D2ProgramSection.fromMap(db, json);
  }
}
