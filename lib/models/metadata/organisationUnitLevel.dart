import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

import 'organisationUnit.dart';

@Entity()
class OrganisationUnitLevel extends DHIS2MetadataResource {
  int id = 0;

  String name;
  @override
  @Unique()
  String uid;
  int level;

  final organisationUnits = ToMany<OrganisationUnit>();

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  OrganisationUnitLevel(
      this.id, this.name, this.uid, this.level, this.created, this.lastUpdated);
}
