import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

class DHIS2UserRole implements DHIS2MetadataResource {
  int id = 0;

  @Unique()
  String uid;
  String code;
  String name;
  List<String> authorities;

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DHIS2UserRole(this.id, this.uid, this.code, this.name, this.authorities,
      this.created, this.lastUpdated);
}
