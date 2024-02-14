import 'package:dhis2_flutter_toolkit/services/preferences.dart';

class DHIS2Credentials {
  String username;
  String password;
  String baseURL;

  DHIS2Credentials(this.username, this.password, this.baseURL);

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
      return DHIS2Credentials(username, password, baseURL);
    }
    return null;
  }
}
