import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/widgets.dart';

class D2HttpClientProvider extends ChangeNotifier {
  D2ClientService? _client;

  get client {
    if (_client == null) {
      throw "You need to call init first before accessing client";
    }
    return _client;
  }

  init(D2UserCredential credentials) {
    _client = D2ClientService(credentials);
  }
}
