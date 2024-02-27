import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

final toRelationshipBox = db.store.box<ToRelationship>();

@Entity()
class ToRelationship {
  int id = 0;

  final trackedEntityInstance = ToOne<TrackedEntity>();
  final enrollment = ToOne<D2Enrollment>();
  final event = ToOne<D2Event>();

  ToRelationship();

  ToRelationship.fromMap(Map json);
}
