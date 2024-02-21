import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final relationshipBox = db.store.box<Relationship>();

class RelationshipRepository extends BaseRepository<Relationship> {
  RelationshipRepository() : super(relationshipBox);

  @override
  Relationship? getByUid(String uid) {
    Query<Relationship> query =
        relationshipBox.query(Relationship_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  Relationship mapper(Map<String, dynamic> json) {
    return Relationship.fromMap(json);
  }
}
