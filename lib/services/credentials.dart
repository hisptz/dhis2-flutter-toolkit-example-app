import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/services/preferences.dart';

class D2Credential {
  String username;
  String password;
  String baseURL;

  D2Credential(
      {required this.username, required this.password, required this.baseURL});

  Future saveToPreference() async {
    await preferences?.setString("baseURL", baseURL);
    await preferences?.setString("username", username);
    await preferences?.setString("password", password);
  }

  static fromPreferences() {
    String? baseURL = preferences?.getString("baseURL");
    String? username = preferences?.getString("username");
    String? password = preferences?.getString("password");

    if (baseURL != null && username != null && password != null) {
      return D2Credential(
          username: username, password: password, baseURL: baseURL);
    }
    return null;
  }

  Future<bool> verify() async {
    DHIS2Client client = DHIS2Client(this);
    Map? data = await client.httpGet<Map>("me");
    if (data == null) {
      throw "Error logging in.";
    }
    if (data["httpStatusCode"] == 401) {
      throw "Invalid username or password";
    }
    await saveToPreference();
    return true;
  }
}
