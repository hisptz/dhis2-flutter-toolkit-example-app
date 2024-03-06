import 'package:dhis2_flutter_toolkit/models/metadata/relationshipType.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2RelationshipTypeDownloadMixin
    on BaseMetaDownloadServiceMixin<D2RelationshipType> {
  @override
  String label = "Relationship Types";

  @override
  String resource = "relationshipTypes";

  D2RelationshipTypeDownloadMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*"]);
    return this;
  }
}
