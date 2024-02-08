import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2User extends DHIS2MetadataResource {
  int id = 0;

  String username;
  String firstName;
  String lastName;
  String email;

  final userRoles = ToMany<DHIS2UserRole>();
  final userGroups = ToMany<DHIS2UserGroup>();
  final organisationUnits = ToMany<OrganisationUnit>();

  DHIS2User(this.username, this.firstName, this.lastName, this.email);
}
