import 'package:dhis2_flutter_toolkit/models/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramSectionBox = db.store.box<D2ProgramSection>();

class D2ProgramSectionRepository extends BaseRepository<D2ProgramSection> {
  D2ProgramSectionRepository(super.box);

  @override
  D2ProgramSection? getByUid(String uid) {
    Query<D2ProgramSection> query =
        d2ProgramSectionBox.query(D2ProgramSection_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
