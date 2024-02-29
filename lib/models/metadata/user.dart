import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userGroup.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/userRole.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
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

  final userRoles = ToMany<D2UserRole>();
  final userGroups = ToMany<D2UserGroup>();

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

  D2User.fromMap(ObjectBox db, Map<String, dynamic> json)
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
    id = D2UserRepository(db).getIdByUid(json["id"]) ?? 0;
    List<D2UserRole> roles = json["userRoles"]
        .cast<Map>()
        .map<D2UserRole>((Map json) => D2UserRole.fromMap(db, json))
        .toList()
        .cast<D2UserRole>();
    userRoles.addAll(roles);
    List<D2UserGroup> groups = json["userGroups"]
        .cast<Map>()
        .map<D2UserGroup>((Map json) => D2UserGroup.fromMap(db, json))
        .toList()
        .cast<D2UserGroup>();
    userGroups.addAll(groups);
  }

  @override
  String toString() {
    return "Username: $username, First Name: $firstName, Last Name: $surname, ID: $uid ";
  }
}
