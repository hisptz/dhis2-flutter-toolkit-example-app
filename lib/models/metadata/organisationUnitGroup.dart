import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class OrganisationUnitGroup implements DHIS2MetadataResource {
  int id = 0;

  String name;
  @override
  @Unique()
  String uid;

  final organisationUnits = ToMany<OrganisationUnit>();

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  OrganisationUnitGroup(
      this.id, this.name, this.uid, this.created, this.lastUpdated);
}
