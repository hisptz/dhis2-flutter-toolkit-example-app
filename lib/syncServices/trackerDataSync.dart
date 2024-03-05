import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/utils/download_status.dart';

class D2TrackerDataDownload {
  ObjectBox db;
  DHIS2Client client;
  StreamController<DownloadStatus> downloadController =
      StreamController<DownloadStatus>();

  late D2TrackedEntityRepository trackedEntityRepository;
  late D2EnrollmentRepository enrollmentRepository;
  late D2EventRepository eventRepository;

  D2TrackerDataDownload(this.db, this.client) {
    trackedEntityRepository = D2TrackedEntityRepository(db);
    enrollmentRepository = D2EnrollmentRepository(db);
    eventRepository = D2EventRepository(db);
  }

  get downloadStream {
    return downloadController.stream;
  }

  isSynced() {
    return trackedEntityRepository.isSynced();
  }

  Future setupDataDownload() async {
    D2User? user = D2UserRepository(db).get();
    if (user == null) {
      downloadController.addError("Could not get user");
      return;
    }
    List<String> programs = user.programs;

    for (final programId in programs) {
      D2Program? program = D2ProgramRepository(db).getByUid(programId);
      if (program == null) {
        continue;
      }
      if (program.programType == "WITH_REGISTRATION") {
        trackedEntityRepository.setProgram(program);
        enrollmentRepository.setProgram(program);
        trackedEntityRepository.setupDownload(client).download();
        await downloadController
            .addStream(trackedEntityRepository.downloadStream);
        enrollmentRepository.setupDownload(client).download();
        await downloadController.addStream(enrollmentRepository.downloadStream);
      }

      eventRepository.setProgram(program);
      eventRepository.setupDownload(client).download();
      await downloadController.addStream(eventRepository.downloadStream);
    }
  }

  Future<void> download() async {
    await setupDataDownload();
    downloadController
        .add(DownloadStatus(status: Status.complete, label: "All"));
    downloadController.close();
  }
}
