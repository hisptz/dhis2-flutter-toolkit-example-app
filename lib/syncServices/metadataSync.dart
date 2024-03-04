import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/enrollmentSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/eventsSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/orgUnitSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/programSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/relationshipTypeSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';
import 'package:dhis2_flutter_toolkit/syncServices/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/syncServices/trackedEntitySync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/trackedEntityTypeSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/userSync.dart';

class MetadataSync {
  ObjectBox db;
  DHIS2Client client;
  late UserSyncService userSyncService;
  late SystemInfoSync systemInfoSync;
  StreamController<SyncStatus> controller = StreamController<SyncStatus>();

  get stream {
    return controller.stream;
  }

  MetadataSync(this.db, this.client) {
    systemInfoSync = SystemInfoSync(db, client);
    userSyncService = UserSyncService(db, client);
  }

  /*
  * Basically checks if the user info and system info is synced. To be used when the app starts. Maybe later it will check for all the metadata.
  *
  * */

  isSynced() {
    return userSyncService.isSynced() && systemInfoSync.isSynced();
  }

  Future setupMetadataSync() async {
    userSyncService.sync();
    await controller.addStream(userSyncService.stream);
    systemInfoSync.sync();
    await controller.addStream(systemInfoSync.stream);
    D2User? user = D2UserRepository(db).get();
    if (user == null) {
      controller.addError("Could not get user");
      return;
    }
    D2OrgUnitSync orgUnitSync =
        D2OrgUnitSync(db, client, orgUnitIds: user.organisationUnits);
    orgUnitSync.sync();
    await controller.addStream(orgUnitSync.stream);
    D2TrackedEntityTypeSync trackedEntityTypeSync =
        D2TrackedEntityTypeSync(db: db, client: client);
    trackedEntityTypeSync.sync();
    await controller.addStream(trackedEntityTypeSync.stream);
    List<String> programs = user.programs;
    D2ProgramSync programSync = D2ProgramSync(db, client, programIds: programs);
    programSync.sync();
    await controller.addStream(programSync.stream);
    D2RelationshipTypeSync relationshipTypeSync =
        D2RelationshipTypeSync(db: db, client: client);
    relationshipTypeSync.sync();
    await controller.addStream(relationshipTypeSync.stream);
  }

  Future setupDataSync() async {
    D2User? user = D2UserRepository(db).get();
    if (user == null) {
      controller.addError("Could not get user");
      return;
    }
    List<String> programs = user.programs;

    for (final programId in programs) {
      D2Program? program = D2ProgramRepository(db).getByUid(programId);

      if (program == null) {
        continue;
      }

      if (program.programType == "WITH_REGISTRATION") {
        TrackedEntitySync trackedEntitySync =
            TrackedEntitySync(db, client, program: program);
        trackedEntitySync.sync();
        await controller.addStream(trackedEntitySync.stream);

        D2EnrollmentSync enrollmentsSync =
            D2EnrollmentSync(db, client, program: program);
        enrollmentsSync.sync();
        await controller.addStream(enrollmentsSync.stream);
      }

      D2EventSync eventsSync = D2EventSync(db, client, program: program);
      eventsSync.sync();
      await controller.addStream(eventsSync.stream);
    }
  }

  Future setupSync() async {
    await setupMetadataSync();
    await setupDataSync();
    controller.add(
        SyncStatus(synced: 0, total: 0, status: Status.complete, label: "All"));
    controller.close();
  }

  Future<void> sync() async {
    await setupSync();
  }
}
