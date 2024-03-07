import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:flutter/foundation.dart';

Admin? admin;

class DBProvider extends ChangeNotifier {
  D2ObjectBox? _db;

  get db {
    if (_db == null) {
      throw "You need to call init before accessing db";
    }
    return _db;
  }

  close() {
    _db?.store.close();
    _db = null;
  }

  Future init(D2UserCredential credentials) async {
    if (_db != null) {
      if (kDebugMode) {
        print("STORE already initialized");
      }
      return;
    }
    _db = await D2ObjectBox.create(credentials);
    if (kDebugMode && Admin.isAvailable() && _db != null) {
      admin = Admin(_db!.store);
    }
  }
}
