import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/services/preferences.dart';

class AppAuth {
  List<D2Credential> getUsers() {
    List<String> users = preferences?.getStringList("users") ?? [];
    if (users.isEmpty) {
      return [].cast<D2Credential>();
    }
    return users.map<D2Credential>(D2Credential.fromPreferences).toList() ?? [];
  }

  Future loginUser(D2Credential credentials) async {
    return await preferences?.setString("loggedInUser", credentials.id);
  }

  Future logoutUser() async {
    return await preferences?.setString("loggedInUser", "");
  }

  Future saveUser(D2Credential credentials) async {
    List<D2Credential> users = getUsers();
    D2Credential? updatedUser = users
        .firstWhereOrNull((credential) => credentials.id == credentials.id);
    if (updatedUser != null) {
      int index = users.indexOf(credentials);
      users[index] = credentials;
    }
    users.add(credentials);
    List<String> usersPayload =
        users.map((e) => jsonEncode(e.toMap())).toList();

    return await preferences?.setStringList("users", usersPayload);
  }

  D2Credential? getLoggedInUser() {
    String? loggedInUserId = preferences?.getString("loggedInUser");
    if (loggedInUserId == null) {
      return null;
    }

    if (loggedInUserId.isEmpty) {
      return null;
    }

    List<D2Credential> users = getUsers();
    D2Credential? user =
        users.firstWhereOrNull((element) => element.id == loggedInUserId);
    return user;
  }
}
