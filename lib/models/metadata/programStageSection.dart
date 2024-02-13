import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';

class ProgramStageSection implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  ProgramStageSection(this.created, this.lastUpdated, this.uid);
}
