import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnitGroup.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2OrgUnitGroupDownloadServiceMixin
    on BaseMetaDownloadServiceMixin<D2OrgUnitGroup> {
  @override
  String label = "Organisation Unit Groups";

  @override
  String resource = "organisationUnitGroups";

  @override
  Map<String, dynamic>? extraParams = {"withinUserHierarchy": "true"};

  D2OrgUnitGroupDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*"]);
    return this;
  }
}
