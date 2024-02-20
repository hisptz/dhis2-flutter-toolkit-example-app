import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox.g.dart';

class UserRepository extends BaseRepository<DHIS2MeUser> {
  UserRepository() : super(dhis2MeUserBox);

  DHIS2MeUser? get() {
    Query query = box.query().build();
    return query.findFirst();
  }
}
