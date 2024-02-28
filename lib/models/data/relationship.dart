import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/models/data/fromRelationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/toRelationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/fromRelationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/toRelationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class Relationship extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  @Unique()
  String uid;
  String relationshipName;
  bool bidirectional;
  String relationshipType;

  final to = ToOne<ToRelationship>();
  final from = ToOne<FromRelationship>();
  final trackedEntity = ToOne<TrackedEntity>();
  final enrollment = ToOne<D2Enrollment>();
  final event = ToOne<D2Event>();

  Relationship({
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
    required this.relationshipName,
    required this.relationshipType,
    required this.bidirectional,
  });

  Relationship.fromMap(Map json, String type)
      : createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        uid = json["relationship"],
        relationshipName = json["relationshipName"],
        relationshipType = json["relationshipType"],
        bidirectional = json["bidirectional"] {
    if (type == "trackedEntity") {
      trackedEntity.target =
          TrackedEntityRepository().getByUid(json["from"][type][type]);
    }

    if (type == "enrollment") {
      enrollment.target =
          D2EnrollmentRepository().getByUid(json["from"][type][type]);
    }

    if (type == "event") {
      event.target = D2EventRepository().getByUid(json["from"][type][type]);
    }

    from.target =
        FromRelationshipRepository().getByUid(json["from"][type][type]);
    to.target = ToRelationshipRepository().getByUid(json["to"][type][type]);
  }
}
