import 'package:dhis2_flutter_toolkit/services/preferences.dart';
import 'package:dhis2_flutter_toolkit/state/client.dart';
import 'package:dhis2_flutter_toolkit/state/db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'modules/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePreference();
  Intl.defaultLocale = "en";
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DBProvider()),
      ChangeNotifierProvider(create: (_) => D2HttpClientProvider()),
    ],
    child: const App(),
  ));
}
