import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class UserRepository extends BaseSingleRepository<DHIS2MeUser> {
  UserRepository() : super(resource: "me", fields: ["*"]);
}
