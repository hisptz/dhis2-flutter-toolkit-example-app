import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class UserRepository extends BaseSingleRepository {
  UserRepository.name() : super(resource: "me", fields: ["*"]);
}
