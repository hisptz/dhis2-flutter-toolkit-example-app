import 'package:dhis2_flutter_toolkit/models/base.dart';

abstract class DHIS2MetadataResource extends DHIS2Resource {
  DateTime created;
  DateTime lastUpdated;

  DHIS2MetadataResource(this.created, this.lastUpdated);
}
