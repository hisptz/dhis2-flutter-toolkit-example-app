import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

final toRelationshipBox = db.store.box<ToRelationship>();

@Entity()
class ToRelationship {
  int id = 0;

  final trackedEntityInstance = ToOne<TrackedEntity>();

  ToRelationship();

  ToRelationship.toMap(Map json);
}
