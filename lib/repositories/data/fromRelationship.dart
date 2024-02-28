import 'package:dhis2_flutter_toolkit/models/data/fromRelationship.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';

import '../../objectbox.g.dart';

final fromRelationshipBox = db.store.box<FromRelationship>();

class FromRelationshipRepository {
  FromRelationshipRepository() : super();

  FromRelationship? getByUid(String uid) {
    Query<FromRelationship> query =
        fromRelationshipBox.query(FromRelationship_.uid.equals(uid)).build();
    return query.findFirst();
  }

  FromRelationship mapper(Map<String, dynamic> json) {
    return FromRelationship.fromMap(json, "", "");
  }
}
