import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2MeUser {
  String username;
  String firstName;
  String lastName;
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
      required this.lastName,
      this.email,
      required this.authorities,
      required this.uid});

  DHIS2MeUser.fromMap(Map json) {
    uid = json["id"];
    username = json["username"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    authorities = json["authorities"];

    List<DHIS2UserRole> roles =
        json["userRoles"].map(DHIS2UserRole.fromMap);
    userRoles.addAll(roles);
  }
}
