import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

final dhis2MeUserBox = db.store.box<DHIS2MeUser>();

@Entity()
class DHIS2MeUser extends DHIS2Resource {
  int id = 0;
  String username;
  String firstName;
  String surname;
  String? email;
  List<String> authorities;

  final userRoles = ToMany<DHIS2UserRole>();
  final userGroups = ToMany<DHIS2UserGroup>();
  final organisationUnits = ToMany<OrganisationUnit>();

  @Unique()
  String uid;

  DHIS2MeUser(
      {required this.username,
      required this.firstName,
      required this.surname,
      this.email,
      required this.authorities,
      required this.uid});

  DHIS2MeUser.fromMap(Map<String, dynamic> json)
      : uid = json["id"],
        username = json["username"],
        firstName = json["firstName"],
        surname = json["surname"],
        email = json["email"],
        authorities = json["authorities"].cast<String>() {
    List<DHIS2UserRole> roles = json["userRoles"]
        .cast<Map>()
        .map(DHIS2UserRole.fromMap)
        .toList()
        .cast<DHIS2UserRole>();
    userRoles.addAll(roles);
    List<DHIS2UserGroup> groups = json["userGroups"]
        .cast<Map>()
        .map(DHIS2UserGroup.fromMap)
        .toList()
        .cast<DHIS2UserGroup>();
    userGroups.addAll(groups);
    List<OrganisationUnit> orgUnits = json["organisationUnits"]
        .cast<Map>()
        .map(OrganisationUnit.fromMap)
        .toList()
        .cast<OrganisationUnit>();
    organisationUnits.addAll(orgUnits);
  }

  @override
  String toString() {
    return "Username: $username, First Name: $firstName, Last Name: $surname, ID: $uid ";
  }
}
