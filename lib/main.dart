import 'package:dhis2_flutter_toolkit/utils/init.dart';
import 'package:flutter/material.dart';

import 'modules/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await D2Utils.initialize();
  runApp(const App());
}
