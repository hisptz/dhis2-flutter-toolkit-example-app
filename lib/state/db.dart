import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:flutter/foundation.dart';

Admin? admin;

class DBProvider extends ChangeNotifier {
  ObjectBox? _db;

  get db {
    if (_db == null) {
      throw "You need to call init before accessing db";
    }
    return _db;
  }

  close() {
    _db?.store.close();
  }

  Future init(D2Credential credentials) async {
    _db = await ObjectBox.create(credentials);
    if (kDebugMode && Admin.isAvailable() && _db != null) {
      admin = Admin(_db!.store);
    }
  }
}
