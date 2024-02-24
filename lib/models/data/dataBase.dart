import 'package:dhis2_flutter_toolkit/models/base.dart';

abstract class D2DataResource extends DHIS2Resource {
  abstract int id;
  abstract DateTime createdAt;
  abstract DateTime updatedAt;
  abstract String uid;
}
