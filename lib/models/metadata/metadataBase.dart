import 'package:dhis2_flutter_toolkit/models/metadata/base.dart';

abstract class D2MetadataResource extends D2MetaResource {
  abstract DateTime created;
  abstract DateTime lastUpdated;
  abstract String uid;
  abstract String? displayName;
}
