import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramStageBox = db.store.box<D2ProgramStage>();

class D2ProgramStageRepository extends BaseRepository<D2ProgramStage> {
  D2ProgramStageRepository() : super(d2ProgramStageBox);

  @override
  D2ProgramStage? getByUid(String uid) {
    Query<D2ProgramStage> query =
        d2ProgramStageBox.query(D2ProgramStage_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2ProgramStage mapper(Map<String, dynamic> json) {
    return D2ProgramStage.fromMap(json);
  }

  D2ProgramStageRepository byProgram(int programId) {
    queryConditions = D2ProgramStage_.program.equals(programId);
    return this;
  }
}
