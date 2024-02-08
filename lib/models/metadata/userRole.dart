import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

class DHIS2UserRole extends DHIS2MetadataResource {
  int id = 0;

  @Unique()
  String uid;
  String code;
  String name;
  List<String> authorities;

  DHIS2UserRole(this.uid, this.code, this.name, this.authorities);
}
