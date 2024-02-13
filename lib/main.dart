import 'package:flutter/material.dart';

import 'modules/app.dart';
import 'services/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePreference();
  runApp(const App());
}
