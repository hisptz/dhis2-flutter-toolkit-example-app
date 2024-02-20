import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:objectbox/objectbox.dart';

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
