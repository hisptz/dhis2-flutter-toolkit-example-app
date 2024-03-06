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

class D2TrackerDataUpload {
  ObjectBox db;
  DHIS2Client client;
  StreamController<DownloadStatus> uploadController =
      StreamController<DownloadStatus>();

  D2TrackerDataUpload(this.db, this.client);

  get uploadStream {
    return uploadController.stream;
  }

  isSynced() {
    return true;
  }

  Future setupDataUpload() async {
    D2User? user = D2UserRepository(db).get();
    if (user == null) {
      uploadController.addError("Could not get user");
      return;
    }
    List<String> programs = user.programs;

    for (final programId in programs) {
      D2Program? program = D2ProgramRepository(db).getByUid(programId);
      if (program == null) {
        continue;
      }
      if (program.programType == "WITH_REGISTRATION") {
        D2TrackedEntityRepository trackedEntityRepository =
            D2TrackedEntityRepository(db);
        D2EnrollmentRepository enrollmentRepository =
            D2EnrollmentRepository(db);
        trackedEntityRepository.setProgram(program);
        enrollmentRepository.setProgram(program);
        trackedEntityRepository.setupUpload(client).upload();
        await uploadController.addStream(trackedEntityRepository.uploadStream);
        enrollmentRepository.setupUpload(client).upload();
        await uploadController.addStream(enrollmentRepository.uploadStream);
      }
      D2EventRepository eventRepository = D2EventRepository(db);
      eventRepository.setProgram(program);
      eventRepository.setupUpload(client).upload();
      await uploadController.addStream(eventRepository.uploadStream);
    }
  }

  Future<void> upload() async {
    await setupDataUpload();
    uploadController.add(DownloadStatus(status: Status.complete, label: "All"));
    uploadController.close();
  }
}
