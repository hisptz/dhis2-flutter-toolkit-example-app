import 'package:dhis2_flutter_toolkit/modules/home.dart';
import 'package:dhis2_flutter_toolkit/modules/login.dart';
import 'package:dhis2_flutter_toolkit/modules/sync.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/syncServices/metadataSync.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final metadataSync = MetadataSync();
  final D2Credential? credentials = D2Credential.fromPreferences();

  @override
  Widget build(BuildContext context) {
    if (credentials == null) {
      return const Login();
    }

    if (metadataSync.isSynced()) {
      return const Home();
    }

    return const SyncPage();
  }
}
