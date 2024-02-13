import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';

class Program implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  Program(this.created, this.lastUpdated, this.uid);
}
