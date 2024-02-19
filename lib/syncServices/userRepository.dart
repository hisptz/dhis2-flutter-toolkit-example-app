import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/syncServices/singleBase.dart';

class UserSyncService extends BaseSingleSyncService<D2User> {
  UserSyncService()
      : super(
            resource: "me",
            fields: ["*", "userRoles[*],userGroups[*],organisationUnits[id]"],
            box: dhis2MeUserBox,
            label: "User");

  @override
  D2User mapper(Map<String, dynamic> json) {
    return D2User.fromMap(json);
  }
}
