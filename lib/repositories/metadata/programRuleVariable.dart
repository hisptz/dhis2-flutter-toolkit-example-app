import 'package:dhis2_flutter_toolkit/models/metadata/programRuleVariable.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramRuleVariableBox = db.store.box<D2ProgramRuleVariable>();

class D2ProgramRuleVariableRepository
    extends BaseRepository<D2ProgramRuleVariable> {
  D2ProgramRuleVariableRepository(super.box);

  @override
  D2ProgramRuleVariable? getByUid(String uid) {
    Query<D2ProgramRuleVariable> query = d2ProgramRuleVariableBox
        .query(D2ProgramRuleVariable_.uid.equals(uid))
        .build();
    return query.findFirst();
  }
}
