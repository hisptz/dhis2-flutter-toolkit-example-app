import 'package:dhis2_flutter_toolkit/models/data/toRelationship.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';

import '../../objectbox.g.dart';

final toRelationshipBox = db.store.box<ToRelationship>();

class ToRelationshipRepository {
  ToRelationshipRepository() : super();

  ToRelationship? getByUid(String uid) {
    Query<ToRelationship> query =
        toRelationshipBox.query(ToRelationship_.uid.equals(uid)).build();
    return query.findFirst();
  }

  ToRelationship mapper(Map<String, dynamic> json) {
    return ToRelationship.fromMap(json, "", "");
  }
}
