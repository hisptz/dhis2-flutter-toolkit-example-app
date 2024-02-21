import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/services/preferences.dart';
import 'package:flutter/foundation.dart';

Admin? admin;

class D2Utils {
  static Future initialize() async {
    db = await ObjectBox.create();
    await initializePreference();
    D2Credential? credentials = D2Credential.fromPreferences();
    if (credentials != null) {
      initializeClient(credentials);
    }
    if (kDebugMode && Admin.isAvailable()) {
      admin = Admin(db.store);
    }
  }
}
