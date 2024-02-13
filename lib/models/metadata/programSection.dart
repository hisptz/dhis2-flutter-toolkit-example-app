import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';

class ProgramSection implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  ProgramSection(this.created, this.lastUpdated, this.uid);
}
