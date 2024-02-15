import 'package:dhis2_flutter_toolkit/models/base.dart';

abstract class D2MetadataResource extends DHIS2Resource {
  abstract int id;
  abstract DateTime created;
  abstract DateTime lastUpdated;
  abstract String uid;
}
