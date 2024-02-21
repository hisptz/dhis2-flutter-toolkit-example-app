import 'package:dhis2_flutter_toolkit/models/metadata/programStageDataElement.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramStageDataElementBox = db.store.box<D2ProgramStageDataElement>();

class D2ProgramStageDataElementRepository
    extends BaseRepository<D2ProgramStageDataElement> {
  D2ProgramStageDataElementRepository() : super(d2ProgramStageDataElementBox);

  @override
  D2ProgramStageDataElement? getByUid(String uid) {
    Query<D2ProgramStageDataElement> query = d2ProgramStageDataElementBox
        .query(D2ProgramStageDataElement_.uid.equals(uid))
        .build();
    return query.findFirst();
  }

  @override
  D2ProgramStageDataElement mapper(Map<String, dynamic> json) {
    return D2ProgramStageDataElement.fromMap(json);
  }
}
