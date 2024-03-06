import 'package:dhis2_flutter_toolkit/models/metadata/programRule.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/base.dart';

class D2ProgramRuleRepository extends BaseMetaRepository<D2ProgramRule> {
  D2ProgramRuleRepository(super.db);

  @override
  D2ProgramRule? getByUid(String uid) {
    Query<D2ProgramRule> query =
        box.query(D2ProgramRule_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2ProgramRule mapper(Map<String, dynamic> json) {
    return D2ProgramRule.fromMap(db, json);
  }
}
