import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class FromRelationship {
  int id = 0;

  final trackedEntityInstance = ToOne<TrackedEntity>();

  FromRelationship();

  FromRelationship.fromMap(Map json);
}
