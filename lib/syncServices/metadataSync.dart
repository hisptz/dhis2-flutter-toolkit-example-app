import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/orgUnit.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/relationshipType.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/utils/download_status.dart';

class D2MetadataDownloadService {
  ObjectBox db;
  DHIS2Client client;
  StreamController<DownloadStatus> controller =
      StreamController<DownloadStatus>();

  late D2UserRepository userRepository;
  late D2SystemInfoRepository sysInfoRepository;
  late D2OrgUnitRepository orgUnitRepository;
  late D2TrackedEntityTypeRepository teiTypeRepository;
  late D2ProgramRepository programRepository;
  late D2RelationshipTypeRepository relationshipTypeRepository;

  get stream {
    return controller.stream;
  }

  D2MetadataDownloadService(this.db, this.client) {
    userRepository = D2UserRepository(db);
    sysInfoRepository = D2SystemInfoRepository(db);
    orgUnitRepository = D2OrgUnitRepository(db);
    teiTypeRepository = D2TrackedEntityTypeRepository(db);
    programRepository = D2ProgramRepository(db);
    relationshipTypeRepository = D2RelationshipTypeRepository(db);
  }

  /*
  * Basically checks if the user info and system info is synced. To be used when the app starts. Maybe later it will check for all the metadata.
  *
  * */

  isSynced() {
    return userRepository.isSynced();
  }

  Future setupUserMetadataDownload(D2User user) async {
    List<String> programs = user.programs;
    programRepository.setupDownload(client, programs).download();
    await controller.addStream(programRepository.downloadStream);
  }

  Future setupMetadataDownload() async {
    userRepository.setupDownload(client).download();
    await controller.addStream(userRepository.downloadStream);
    sysInfoRepository.setupDownload(client).download();
    await controller.addStream(sysInfoRepository.downloadStream);
    orgUnitRepository.setupDownload(client).download();
    await controller.addStream(orgUnitRepository.downloadStream);
    teiTypeRepository.setupDownload(client).download();
    await controller.addStream(teiTypeRepository.downloadStream);
    relationshipTypeRepository.setupDownload(client).download();
    await controller.addStream(relationshipTypeRepository.downloadStream);

    D2User? user = userRepository.get();
    if (user == null) {
      controller.addError("Could not get user");
      return;
    }
    await setupUserMetadataDownload(user);
  }

  Future setupSync() async {
    await setupMetadataDownload();
    controller.add(DownloadStatus(status: Status.complete, label: "All"));
    controller.close();
  }

  Future<void> download() async {
    await setupSync();
  }
}
