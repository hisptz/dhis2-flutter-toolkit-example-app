import 'package:dhis2_flutter_toolkit/modules/login.dart';
import 'package:dhis2_flutter_toolkit/modules/sync.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final DHIS2Credentials? credentials = DHIS2Credentials.fromPreferences();

  @override
  Widget build(BuildContext context) {
    if (credentials == null) {
      return const Login();
    }

    return const SyncPage();
  }
}
