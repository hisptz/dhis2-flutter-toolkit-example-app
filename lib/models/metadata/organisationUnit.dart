import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

class OrganisationUnit extends DHIS2MetadataResource {
  int id = 0;

  String name;
  String shortName;
  @Unique()
  String uid;
  String path;
  int level;

  OrganisationUnit(this.name, this.shortName, this.uid, this.path, this.level);
}
