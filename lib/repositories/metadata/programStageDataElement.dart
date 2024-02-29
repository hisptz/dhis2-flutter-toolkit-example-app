import 'package:dhis2_flutter_toolkit/models/metadata/programStageDataElement.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2ProgramStageDataElementRepository
    extends BaseRepository<D2ProgramStageDataElement> {
  D2ProgramStageDataElementRepository(super.db);

  @override
  D2ProgramStageDataElement? getByUid(String uid) {
    Query<D2ProgramStageDataElement> query =
        box.query(D2ProgramStageDataElement_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2ProgramStageDataElement mapper(Map<String, dynamic> json) {
    return D2ProgramStageDataElement.fromMap(db, json);
  }
}
