import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2User implements DHIS2MetadataResource {
  int id = 0;

  String username;
  String firstName;
  String lastName;
  String email;

  final userRoles = ToMany<DHIS2UserRole>();
  final userGroups = ToMany<DHIS2UserGroup>();
  final organisationUnits = ToMany<OrganisationUnit>();

  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DHIS2User(this.id, this.username, this.firstName, this.lastName, this.email,
      this.created, this.lastUpdated);
}
