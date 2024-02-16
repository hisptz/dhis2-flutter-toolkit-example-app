import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';

import '../../objectbox.g.dart';

@Entity()
class D2Enrollment extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DateTime createdAtClient;

  @Unique()
  String enrollment;
  String program;
  String trackedEntityInstance;
  String trackedEntityType;
  String orgUnit;
  String orgUnitName;
  DateTime enrollmentDate;
  bool deleted;
  bool followup;
  DateTime incidentDate;
  String status;
  List notes;

  final events = ToMany<D2Event>();
  final relationships = ToMany<Relationship>();
  final attributes = ToMany<D2TrackedEntityAttributeValues>();

  D2Enrollment({
    required this.enrollment,
    required this.program,
    required this.lastUpdated,
    required this.created,
    required this.createdAtClient,
    required this.orgUnit,
    required this.orgUnitName,
    required this.trackedEntityInstance,
    required this.trackedEntityType,
    required this.enrollmentDate,
    required this.followup,
    required this.deleted,
    required this.incidentDate,
    required this.status,
    required this.notes,
  });

  D2Enrollment.fromMap(Map json)
      : enrollment = json["enrollment"],
        program = json["program"],
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        created = DateTime.parse(json["created"]),
        createdAtClient = DateTime.parse(json["createdAtClient"]),
        orgUnit = json["orgUnit"],
        orgUnitName = json["orgUnitName"],
        trackedEntityInstance = json["trackedEntityInstance"],
        trackedEntityType = json["trackedEntityType"],
        enrollmentDate = DateTime.parse(json["enrollmentDate"]),
        followup = json["followup"],
        deleted = json["deleted"],
        incidentDate = DateTime.parse(json["incidentDate"]),
        status = json["status"],
        notes = json["notes"] {
    List<D2Event> event = json["events"].map(D2Event.fromMap);

    events.addAll(event);

    List<Relationship> relationship =
        json["relationships"].map(Relationship.fromMap);

    relationships.addAll(relationship);

    List<D2TrackedEntityAttributeValues> attributeValue =
        json["attributes"].map(D2TrackedEntityAttributeValues.fromMap);

    attributes.addAll(attributeValue);
  }
}
