import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2User extends DHIS2Resource {
  int id = 0;
  String username;
  String firstName;
  String surname;
  String? email;
  List<String> authorities;
  List<String> programs;
  List<String> organisationUnits;

  final userRoles = ToMany<DHIS2UserRole>();
  final userGroups = ToMany<DHIS2UserGroup>();

  @Unique()
  String uid;

  D2User(
      {required this.username,
      required this.firstName,
      required this.surname,
      this.email,
      required this.authorities,
      required this.uid,
      required this.programs,
      required this.organisationUnits});

  D2User.fromMap(Map<String, dynamic> json)
      : uid = json["id"],
        username = json["username"],
        firstName = json["firstName"],
        surname = json["surname"],
        email = json["email"],
        authorities = json["authorities"].cast<String>(),
        programs = json["programs"].cast<String>(),
        organisationUnits = json["organisationUnits"]
            .map((orgUnit) => orgUnit["id"])
            .toList()
            .cast<String>() {
    id = D2UserRepository().getIdByUid(json["id"]) ?? 0;
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
  }

  @override
  String toString() {
    return "Username: $username, First Name: $firstName, Last Name: $surname, ID: $uid ";
  }
}
