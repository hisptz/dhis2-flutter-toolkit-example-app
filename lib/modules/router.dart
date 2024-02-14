import 'package:dhis2_flutter_toolkit/modules/login.dart';
import 'package:dhis2_flutter_toolkit/modules/sync.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    DHIS2Credentials? credentials = DHIS2Credentials.fromPreferences();

    if (credentials == null) {
      return const Login();
    }

    return const SyncPage();
  }
}
