import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:flutter/widgets.dart';

class D2HttpClientProvider extends ChangeNotifier {
  DHIS2Client? _client;

  get client {
    if (_client == null) {
      throw "You need to call init first before accessing client";
    }
    return _client;
  }

  init(D2Credential credentials) {
    _client = DHIS2Client(credentials);
  }
}
