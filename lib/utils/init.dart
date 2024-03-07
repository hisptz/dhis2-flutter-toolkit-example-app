import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../state/client.dart';
import '../state/db.dart';

Admin? admin;

class D2Utils {
  static Future initialize(BuildContext context) async {
    D2UserCredential? credentials = await D2AuthService().currentUser();
    if (credentials != null) {
      initializeClient(context, credentials);
      await initializeDb(context, credentials);
    }
  }

  static initializeDb(
      BuildContext context, D2UserCredential credentials) async {
    await Provider.of<DBProvider>(context, listen: false).init(credentials);
  }

  static void initializeClient(
      BuildContext context, D2UserCredential credentials) {
    Provider.of<D2HttpClientProvider>(context, listen: false).init(credentials);
  }
}
