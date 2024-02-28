import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/singleBase.dart';

import '../objectbox.dart';

class UserSyncService extends BaseSingleSyncService<D2User> {
  UserSyncService(ObjectBox db, DHIS2Client client)
      : super(
            resource: "me",
            fields: ["*", "userRoles[*],userGroups[*],organisationUnits[id]"],
            db: db,
            client: client,
            label: "User");

  @override
  D2User mapper(Map<String, dynamic> json) {
    return D2User.fromMap(db, json);
  }
}
