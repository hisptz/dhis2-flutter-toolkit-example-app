import 'package:dhis2_flutter_toolkit/syncServices/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/syncServices/userRepository.dart';

import 'base.dart';

class MetadataSync {
  List<BaseSyncService> metadataToSync = [UserSyncService(), SystemInfoSync()];

  Future<List<BaseSyncService>> checkUnSynced() async {
    List<Map<String, dynamic>> syncStatus =
        await Future.wait(metadataToSync.map((BaseSyncService metaSync) async {
      bool status = await metaSync.isSynced();

      return {"object": metaSync, "synced": status};
    }));

    return syncStatus
        .where((element) => !element["synced"])
        .map((element) => element["object"] as BaseSyncService)
        .toList();
  }
}
