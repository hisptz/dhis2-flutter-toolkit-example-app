import 'package:dhis2_flutter_toolkit/models/metadata/option.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2OptionBox = db.store.box<D2Option>();

class D2OptionRepository extends BaseRepository<D2Option> {
  D2OptionRepository(super.box);

  @override
  D2Option? getByUid(String uid) {
    Query<D2Option> query =
        d2OptionBox.query(D2Option_.uid.equals(uid)).build();
    return query.findFirst();
  }
}
