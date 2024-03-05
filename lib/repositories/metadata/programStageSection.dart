import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/base.dart';

class D2ProgramStageSectionRepository
    extends BaseMetaRepository<D2ProgramStageSection> {
  D2ProgramStageSectionRepository(super.db);

  @override
  D2ProgramStageSection? getByUid(String uid) {
    Query<D2ProgramStageSection> query =
        box.query(D2ProgramStageSection_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2ProgramStageSection mapper(Map<String, dynamic> json) {
    return D2ProgramStageSection.fromMap(db, json);
  }
}
