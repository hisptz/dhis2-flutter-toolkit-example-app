import 'package:dhis2_flutter_toolkit/models/metadata/programRuleAction.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2ProgramRuleActionRepository
    extends BaseRepository<D2ProgramRuleAction> {
  D2ProgramRuleActionRepository(super.db);

  @override
  D2ProgramRuleAction? getByUid(String uid) {
    Query<D2ProgramRuleAction> query =
        box.query(D2ProgramRuleAction_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2ProgramRuleAction mapper(Map<String, dynamic> json) {
    return D2ProgramRuleAction.fromMap(db, json);
  }
}
