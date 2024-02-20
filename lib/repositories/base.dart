import 'package:dhis2_flutter_toolkit/models/base.dart';
<<<<<<< HEAD
import 'package:objectbox/objectbox.dart';
=======
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
>>>>>>> feature/metadata-models

abstract class BaseRepository<T extends DHIS2Resource> {
  Box<T> box;

  BaseRepository(this.box);

  T mapper(Map<String, dynamic> json);

  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  T? getByUid(String uid);

  Future<List<T>> saveOffline(List<Map<String, dynamic>> json) async {
    List<T> entities = json.map(mapper).toList();
    return box.putAndGetManyAsync(entities);
  }
}
