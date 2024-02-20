import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramStageSectionBox = db.store.box<D2ProgramStageSection>();

class D2ProgramStageSectionRepository
    extends BaseRepository<D2ProgramStageSection> {
  D2ProgramStageSectionRepository() : super(d2ProgramStageSectionBox);

  @override
  D2ProgramStageSection? getByUid(String uid) {
    Query<D2ProgramStageSection> query = d2ProgramStageSectionBox
        .query(D2ProgramStageSection_.uid.equals(uid))
        .build();
    return query.findFirst();
  }

  @override
  D2ProgramStageSection mapper(Map<String, dynamic> json) {
    return D2ProgramStageSection.fromMap(json);
  }
}
