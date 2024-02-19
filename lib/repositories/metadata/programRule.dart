import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programRule.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2ProgramRuleBox = db.store.box<D2ProgramRule>();

class D2ProgramRuleRepository extends BaseRepository<D2ProgramRule> {
  D2ProgramRuleRepository(super.box);

  @override
  D2ProgramRule? getByUid(String uid) {
    Query<D2ProgramRule> query =
        d2ProgramRuleBox.query(D2ProgramRule_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
