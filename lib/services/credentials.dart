import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/services/preferences.dart';

class D2Credential {
  String username;
  String password;
  String baseURL;
  String? systemId;

  D2Credential(
      {required this.username,
      required this.password,
      required this.baseURL,
      this.systemId});

  Future saveToPreference() async {
    await preferences?.setString("baseURL", baseURL);
    await preferences?.setString("username", username);
    await preferences?.setString("password", password);
    await preferences?.setString("systemId", systemId!);
  }

  static fromPreferences() {
    String? baseURL = preferences?.getString("baseURL");
    String? username = preferences?.getString("username");
    String? password = preferences?.getString("password");
    String? systemId = preferences?.getString("systemId");

    if (baseURL != null && username != null && password != null) {
      return D2Credential(
          username: username,
          password: password,
          baseURL: baseURL,
          systemId: systemId);
    }
    return null;
  }

  Future<void> logout() async {
    await preferences?.remove("username");
    await preferences?.remove("baseURL");
    await preferences?.remove("password");
    await preferences?.remove("systemId");
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
    return true;
  }
}
