import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox.g.dart';

class BaseRepository<T extends DHIS2Resource> {
  Box<T> box;

  BaseRepository(this.box);

  Future<T?> getByUid(String uid) async {
    return null;
  }
}
