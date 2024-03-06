import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_single_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2SystemInfoDownloadServiceMixin
    on BaseSingleMetaDownloadServiceMixin<D2SystemInfo> {
  @override
  String label = "System information";

  @override
  String resource = "system/info";

  D2SystemInfoDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    return this;
  }
}
