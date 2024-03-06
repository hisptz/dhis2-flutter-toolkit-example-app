import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnitLevel.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2OrgUnitLevelDownloadServiceMixin
    on BaseMetaDownloadServiceMixin<D2OrganisationUnitLevel> {
  @override
  String label = "Organisation Unit Levels";

  @override
  String resource = "organisationUnitLevels";

  @override
  Map<String, dynamic>? extraParams = {"withinUserHierarchy": "true"};

  D2OrgUnitLevelDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*"]);
    return this;
  }
}
