import 'package:dhis2_flutter_toolkit/models/base.dart';

abstract class DHIS2MetadataResource extends DHIS2Resource {
  abstract DateTime created;
  abstract DateTime lastUpdated;
  abstract String uid;
}
