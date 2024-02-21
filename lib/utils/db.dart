import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

int? getIdByUid<T extends Entity>(
    {required Box<T> box,
    required Condition<T> condition,
    required String uid}) {
  Query<T> query = box.query(condition).build();
  return query.findFirst()?.uid;
}
