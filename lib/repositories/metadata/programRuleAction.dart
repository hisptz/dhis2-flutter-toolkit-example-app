import 'package:dhis2_flutter_toolkit/models/metadata/programRuleAction.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramBox = db.store.box<D2ProgramRuleAction>();

class D2ProgramRuleActionRepository
    extends BaseRepository<D2ProgramRuleAction> {
  D2ProgramRuleActionRepository(super.box);

  @override
  D2ProgramRuleAction? getByUid(String uid) {
    Query<D2ProgramRuleAction> query =
        d2ProgramBox.query(D2ProgramRuleAction_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
