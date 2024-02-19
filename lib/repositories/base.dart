import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';

abstract class BaseRepository<T extends DHIS2Resource> {
  Box<T> box;

  BaseRepository(this.box);

  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  T? getByUid(String uid);
}
