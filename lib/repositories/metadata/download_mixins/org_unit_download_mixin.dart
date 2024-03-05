import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2OrgUnitDownloadServiceMixin on BaseMetaDownloadServiceMixin<D2OrgUnit> {
  @override
  String label = "Organisation Units";

  @override
  String resource = "organisationUnits";

  @override
  Map<String, dynamic>? extraParams = {"withinUserHierarchy": "true"};

  D2OrgUnitDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*"]);
    return this;
  }
}
