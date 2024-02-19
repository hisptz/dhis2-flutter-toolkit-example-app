import 'package:dhis2_flutter_toolkit/models/base.dart';

import '../objectbox.g.dart';

abstract class BaseRepository<T extends DHIS2Resource> {
  Box<T> box;

  BaseRepository(this.box);

  int? getIdByUid(String uid);

  T? getByUid(String uid);
}
