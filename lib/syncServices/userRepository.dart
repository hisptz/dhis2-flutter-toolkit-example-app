import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class UserRepository extends BaseSyncService<DHIS2MeUser> {
  UserRepository()
      : super(resource: "me", fields: ["*"], mapper: DHIS2MeUser.fromMap);

  @override
  Future<BaseSyncService<DHIS2MeUser>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<BaseSyncService<DHIS2MeUser>> save() {
    // TODO: implement save
    throw UnimplementedError();
  }
}
