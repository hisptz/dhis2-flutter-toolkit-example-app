import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2OptionSetBox = db.store.box<D2OptionSet>();

class D2OptionSetRepository extends BaseRepository<D2OptionSet> {
  D2OptionSetRepository(super.box);

  @override
  D2OptionSet? getByUid(String uid) {
    Query<D2OptionSet> query =
        d2OptionSetBox.query(D2OptionSet_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
