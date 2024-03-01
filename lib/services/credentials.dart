import 'dart:convert';

import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/services/users.dart';

class D2Credential {
  String username;
  String password;
  String baseURL;
  String? systemId;

  get id {
    return "${username}_$systemId";
  }

  D2Credential(
      {required this.username,
      required this.password,
      required this.baseURL,
      this.systemId});

  Future saveToPreference() async {
    await AppAuth().saveUser(this);
  }

  Map<String, String> toMap() {
    return {
      "username": username,
      "password": password,
      "systemId": systemId ?? "",
      "baseURL": baseURL
    };
  }

  static D2Credential fromPreferences(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    String baseURL = map["baseURL"]!;
    String username = map["username"]!;
    String password = map["password"]!;
    String systemId = map["systemId"]!;
    return D2Credential(
        username: username,
        password: password,
        baseURL: baseURL,
        systemId: systemId);
  }

  Future<void> logout() async {
    return AppAuth().logoutUser();
  }

  Future<bool> verify() async {
    DHIS2Client client = DHIS2Client(this);
    Map? data = await client.httpGet<Map>("system/info");
    if (data == null) {
      throw "Error logging in.";
    }
    if (data["httpStatusCode"] == 401) {
      throw "Invalid username or password";
    }
    systemId = data["systemId"];
    await saveToPreference();
    await AppAuth().loginUser(this);
    return true;
  }
}
