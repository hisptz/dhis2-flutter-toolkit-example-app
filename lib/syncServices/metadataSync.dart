import 'dart:async';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnit.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/syncServices/enrollmentSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/eventsSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/orgUnitSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/programSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/relationshipSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';
import 'package:dhis2_flutter_toolkit/syncServices/systemInfo.dart';

import 'package:dhis2_flutter_toolkit/syncServices/trackedEntitySync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/userRepository.dart';

import 'package:dhis2_flutter_toolkit/syncServices/userSync.dart';


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

  isSynced() {
    //Currently just checks if there is any data on the specific data model
    List orgUnits = d2OrgUnitBox.getAll();
    List programs = d2ProgramBox.getAll();
    List events = d2EventBox.getAll();
    List enrollments = d2EnrollmentBox.getAll();
    List teis = trackedEntityBox.getAll();
    List relationships = relationshipBox.getAll();
    return userSyncService.isSynced() &&
        systemInfoSync.isSynced() &&
        orgUnits.isNotEmpty &&
        programs.isNotEmpty &&
        events.isNotEmpty &&
        enrollments.isNotEmpty &&
        teis.isNotEmpty &&
        relationships.isNotEmpty;
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

    D2OrganisationUnit defaultOrg = D2OrgUnitRepository().getDefaultOrgUnit();

    for (final program in programs) {
      TrackedEntitySync trackedEntitySync =
          TrackedEntitySync(program, defaultOrg.uid);
      trackedEntitySync.sync();
      await controller.addStream(trackedEntitySync.stream);
    }

    for (final program in programs) {
      D2EnrollmentSync enrollmentsSync =
          D2EnrollmentSync(program, defaultOrg.uid);
      enrollmentsSync.sync();
      await controller.addStream(enrollmentsSync.stream);
    }

    for (final program in programs) {
      D2EventSync eventsSync = D2EventSync(program, defaultOrg.uid);
      eventsSync.sync();
      await controller.addStream(eventsSync.stream);
    }

    List<D2Event>? events = D2EventRepository().getAll();
    List<D2Enrollment>? enrollments = D2EnrollmentRepository().getAll();
    List<TrackedEntity>? teis = TrackedEntityRepository().getAll();

    List<String> eventUid = events?.map((e) => e.uid).toList() ?? [];

    List<String> teiUid = teis?.map((e) => e.uid).toList() ?? [];

    List<String> enrollmentUid = enrollments?.map((e) => e.uid).toList() ?? [];

    for (final tei in teiUid) {
      RelationshipSync relationshipSync =
          RelationshipSync("trackedEntity", tei);
      relationshipSync.sync();
      await controller.addStream(relationshipSync.stream);
    }

    for (final enrollment in enrollmentUid) {
      RelationshipSync relationshipSync =
          RelationshipSync("enrollment", enrollment);
      relationshipSync.sync();
      await controller.addStream(relationshipSync.stream);
    }

    for (final event in eventUid) {
      RelationshipSync relationshipSync = RelationshipSync("event", event);
      relationshipSync.sync();
      await controller.addStream(relationshipSync.stream);
    }

    controller.add(
        SyncStatus(synced: 0, total: 0, status: Status.complete, label: "All"));
    controller.close();
  }

  Future<void> sync() async {
    await setupSync();
  }
}
