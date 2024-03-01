import 'dart:convert';

import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/services/users.dart';

class D2Credential {
  String username;
  String password;
  String baseURL;

  get id {
    String systemId = baseURL.replaceAll("/", "-");
    return "${username}_$systemId";
  }

  D2Credential({
    required this.username,
    required this.password,
    required this.baseURL,
  });

  Future saveToPreference() async {
    await AppAuth().saveUser(this);
  }

  Map<String, String> toMap() {
    return {"username": username, "password": password, "baseURL": baseURL};
  }

  static D2Credential fromPreferences(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    String baseURL = map["baseURL"]!;
    String username = map["username"]!;
    String password = map["password"]!;
    return D2Credential(
      username: username,
      password: password,
      baseURL: baseURL,
    );
  }

  Future<void> logout() async {
    return AppAuth().logoutUser();
  }

  Future<bool> verifyOnline() async {
    DHIS2Client client = DHIS2Client(this);
    Map? data = await client.httpGet<Map>("system/info");
    if (data == null) {
      throw "Error logging in.";
    }
    if (data["httpStatusCode"] == 401) {
      throw "Invalid username or password";
    }
    await saveToPreference();
    await AppAuth().loginUser(this);
    return true;
  }

  Future<bool> verifyOffline() async {
    return AppAuth().verifyUser(this);
  }

  Future<bool> verify() async {
    bool verified = await verifyOffline();
    if (!verified) {
      return await verifyOnline();
    }
    await AppAuth().loginUser(this);
    return true;
  }
}
