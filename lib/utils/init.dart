import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/state/client.dart';
import 'package:dhis2_flutter_toolkit/state/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Admin? admin;

class D2Utils {
  static Future initialize(BuildContext context) async {
    D2Credential? credentials = D2Credential.fromPreferences();
    if (credentials != null) {
      initializeClient(context, credentials);
      await initializeDb(context, credentials);
    }
  }

  static initializeDb(BuildContext context, D2Credential credentials) async {
    await Provider.of<DBProvider>(context, listen: false).init(credentials);
  }

  static void initializeClient(BuildContext context, D2Credential credentials) {
    Provider.of<D2HttpClientProvider>(context, listen: false).init(credentials);
  }
}
