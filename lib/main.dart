import 'package:dhis2_flutter_toolkit_example_app/state/client.dart';
import 'package:dhis2_flutter_toolkit_example_app/state/db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'modules/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = "en";
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DBProvider()),
      ChangeNotifierProvider(create: (_) => D2HttpClientProvider()),
    ],
    child: const App(),
  ));
}
