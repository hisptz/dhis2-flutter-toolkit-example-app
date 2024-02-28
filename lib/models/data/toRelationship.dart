import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/toRelationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class ToRelationship {
  int id = 0;

  String uid;
  final trackedEntity = ToOne<TrackedEntity>();
  final enrollment = ToOne<D2Enrollment>();
  final event = ToOne<D2Event>();

  ToRelationship({required this.uid});

  ToRelationship.fromMap(Map json, String type, String relationshipId)
      : uid = json[type] {
    if (type == "trackedEntity") {
      id = ToRelationshipRepository().getIdByUid(json["trackedEntity"]) ?? 0;
      trackedEntity.target =
          TrackedEntityRepository().getByUid(json["trackedEntity"]);
    }

    if (type == "enrollment") {
      id = ToRelationshipRepository().getIdByUid(json["enrollment"]) ?? 0;
      enrollment.target = D2EnrollmentRepository().getByUid(json["enrollment"]);
    }

    if (type == "event") {
      id = ToRelationshipRepository().getIdByUid(json["event"]) ?? 0;
      event.target = D2EventRepository().getByUid(json["event"]);
    }
  }
}
