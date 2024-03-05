import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_single_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2UserDownloadServiceMixin on BaseSingleMetaDownloadServiceMixin<D2User> {
  @override
  String label = "User";

  @override
  String resource = "me";

  D2UserDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*", "userRoles[*],userGroups[*],organisationUnits[id]"]);
    return this;
  }
}
