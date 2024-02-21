import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

abstract class BaseRepository<T extends DHIS2Resource> {
  Box<T> box;

  BaseRepository(this.box);

  T mapper(Map<String, dynamic> json);

  Condition<T>? queryConditions;

  int? getIdByUid(String uid) {
    return getByUid(uid)?.id;
  }

  QueryBuilder<T> get queryBuilder {
    return box.query(queryConditions);
  }

  Query<T> get query {
    return queryBuilder.build();
  }

  List<T> find() {
    return query.find();
  }

  T? getByUid(String uid);

  Future<List<T>> saveOffline(List<Map<String, dynamic>> json) async {
    List<T> entities = json.map(mapper).toList();
    return box.putAndGetManyAsync(entities);
  }

  BaseRepository<T> clearQuery() {
    queryConditions = null;
    return this;
  }
}
