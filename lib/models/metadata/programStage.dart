import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';

class ProgramStage implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  ProgramStage(this.created, this.lastUpdated, this.uid);
}
