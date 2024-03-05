import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2TrackedEntityTypeDownloadServiceMixin
    on BaseMetaDownloadServiceMixin<D2TrackedEntityType> {
  late List<String> programIds;

  @override
  String label = "Tracked Entity Types";

  @override
  String resource = "trackedEntityTypes";

  D2TrackedEntityTypeDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*"]);
    return this;
  }
}
