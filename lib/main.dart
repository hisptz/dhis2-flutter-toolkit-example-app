import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:flutter/material.dart';

import 'modules/app.dart';
import 'services/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePreference();
  DHIS2Credentials? credentials = await DHIS2Credentials.fromPreferences();
  if (credentials != null) {
    initializeClient(credentials);
  }
  runApp(const App());
}
