import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

final fromRelationshipBox = db.store.box<FromRelationship>();

@Entity()
class FromRelationship {
  int id = 0;

  final trackedEntityInstance = ToOne<TrackedEntity>();
  final enrollment = ToOne<D2Enrollment>();
  final event = ToOne<D2Event>();

  FromRelationship();

  FromRelationship.fromMap(Map json) {
    trackedEntityInstance.target = TrackedEntityRepository()
        .getByUid(json["trackedEntity"]["trackedEntity"]);
    enrollment.target =
        D2EnrollmentRepository().getByUid(json["enrollment"]["enrollment"]);
    //  event.target = D2Event().getByUid(json["event"]["event"]);
  }
}
