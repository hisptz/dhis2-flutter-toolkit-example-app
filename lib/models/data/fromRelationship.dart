import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/fromRelationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class FromRelationship {
  int id = 0;

  String uid;

  final trackedEntity = ToOne<TrackedEntity>();
  final enrollment = ToOne<D2Enrollment>();
  final event = ToOne<D2Event>();

  FromRelationship({required this.uid});

  FromRelationship.fromMap(Map json, String type, String relationshipId)
      : uid = json[type] {
    if (type == "trackedEntity") {
      id = FromRelationshipRepository().getIdByUid(json["trackedEntity"]) ?? 0;
      trackedEntity.target =
          TrackedEntityRepository().getByUid(json["trackedEntity"]);
    }

    if (type == "enrollment") {
      id = FromRelationshipRepository().getIdByUid(json["enrollment"]) ?? 0;
      enrollment.target = D2EnrollmentRepository().getByUid(json["enrollment"]);
    }

    if (type == "event") {
      id = FromRelationshipRepository().getIdByUid(json["event"]) ?? 0;
      event.target = D2EventRepository().getByUid(json["event"]);
    }
  }
}
