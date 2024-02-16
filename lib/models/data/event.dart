import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';

import '../../objectbox.g.dart';

@Entity()
class D2Event extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  DateTime createdAtClient;

  @override
  @Unique()
  String uid;
  DateTime dueDate;
  String program;
  String programStage;
  String orgUnit;
  String enrollment;
  String trackedEntityInstance;
  String enrollmentStatus;
  DateTime eventDate;
  String orgUnitName;
  String status;
  String attributeCategoryOptions;
  bool deleted;
  bool followup;
  String attributeOptionCombo;
  List notes;

  final relationships = ToMany<Relationship>();
  final dataValues = ToMany<D2DataValue>();

  D2Event(
      {required this.attributeCategoryOptions,
      required this.attributeOptionCombo,
      required this.enrollment,
      required this.program,
      required this.lastUpdated,
      required this.created,
      required this.createdAtClient,
      required this.orgUnit,
      required this.orgUnitName,
      required this.trackedEntityInstance,
      required this.followup,
      required this.deleted,
      required this.status,
      required this.notes,
      required this.dueDate,
      required this.enrollmentStatus,
      required this.uid,
      required this.programStage,
      required this.eventDate});

  D2Event.fromMap(Map json)
      : attributeCategoryOptions = json["attributeCategoryOptions"],
        attributeOptionCombo = json["attributeOptionCombo"],
        enrollment = json["enrollment"],
        program = json["program"],
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        created = DateTime.parse(json["created"]),
        createdAtClient = DateTime.parse(json["createdAtClient"]),
        orgUnit = json["orgUnit"],
        orgUnitName = json["orgUnitName"],
        trackedEntityInstance = json["trackedEntityInstance"],
        followup = json["followup"],
        deleted = json["deleted"],
        status = json["status"],
        notes = json["notes"],
        dueDate = DateTime.parse(json["dueDate"]),
        enrollmentStatus = json["enrollmentStatus"],
        uid = json["event"],
        programStage = json["programStage"],
        eventDate = DateTime.parse(json["eventDate"]) {
    List<Relationship> relationship =
        json["relationships"].map(Relationship.fromMap);

    relationships.addAll(relationship);

    List<D2DataValue> dataValue = json["dataValues"].map(D2DataValue.fromMap);

    dataValues.addAll(dataValue);
  }
}
