import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/syncServices/orgUnitSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/programSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';
import 'package:dhis2_flutter_toolkit/syncServices/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/syncServices/userRepository.dart';

class MetadataSync {
  UserSyncService userSyncService = UserSyncService();
  SystemInfoSync systemInfoSync = SystemInfoSync();
  StreamController<SyncStatus> controller = StreamController<SyncStatus>();

  get stream {
    return controller.stream;
  }

  /*
  * Basically checks if the user info and system info is synced. To be used when the app starts. Maybe later it will check for all the metadata.
  *
  * */
  isSynced() async {
    return userSyncService.isSynced() && systemInfoSync.isSynced();
  }

  Future setupSync() async {
    userSyncService.sync();
    await controller.addStream(userSyncService.stream);
    systemInfoSync.sync();
    await controller.addStream(systemInfoSync.stream);
    D2User? user = D2UserRepository().get();

    if (user == null) {
      controller.addError("Could not get user");
      return;
    }
    D2OrgUnitSync orgUnitSync = D2OrgUnitSync(user.organisationUnits);
    orgUnitSync.sync();
    await controller.addStream(orgUnitSync.stream);
    List<String> programs = user.programs;
    D2ProgramSync programSync = D2ProgramSync(programs);
    programSync.sync();
    await controller.addStream(programSync.stream);
    controller.add(
        SyncStatus(synced: 0, total: 0, status: Status.complete, label: "All"));
    controller.close();
  }

  Future<void> sync() async {
    await setupSync();
  }
}
