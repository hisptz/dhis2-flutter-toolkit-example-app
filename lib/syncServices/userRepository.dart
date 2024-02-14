import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class UserSyncService extends BaseSyncService<DHIS2MeUser> {
  UserSyncService()
      : super(
            resource: "me",
            fields: ["*", "userRoles[*],userGroups[*],organisationUnits[*]"],
            box: dhis2MeUserBox,
            label: "User");

  @override
  Future<BaseSyncService<DHIS2MeUser>> get() async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>();
    if (data == null) {
      return this;
    }
    entity = DHIS2MeUser.fromMap(data);
    return this;
  }
}
