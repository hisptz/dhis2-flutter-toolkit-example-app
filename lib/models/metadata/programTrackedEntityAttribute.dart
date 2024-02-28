import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programTrackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2ProgramTrackedEntityAttribute extends D2MetadataResource {
  @override
  DateTime created;

  @override
  int id = 0;

  @override
  DateTime lastUpdated;

  @override
  String uid;
  int sortOrder;
  bool? displayInList;
  bool mandatory;
  bool? searchable;
  bool? renderOptionAsRadio;

  final program = ToOne<D2Program>();
  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();

  D2ProgramTrackedEntityAttribute(
    this.created,
    this.id,
    this.lastUpdated,
    this.uid,
    this.sortOrder,
    this.displayInList,
    this.mandatory,
    this.searchable,
    this.renderOptionAsRadio,
  );

  D2ProgramTrackedEntityAttribute.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        sortOrder = json["sortOrder"],
        displayInList = json["displayInList"],
        mandatory = json["mandatory"],
        searchable = json["searchable"],
        renderOptionAsRadio = json["renderOptionAsRadio"] {
    id = D2ProgramTrackedEntityAttributeRepository(db).getIdByUid(json["id"]) ??
        0;
    D2TrackedEntityAttribute? attribute = D2TrackedEntityAttributeRepository(db)
        .getByUid(json["trackedEntityAttribute"]["id"]);
    trackedEntityAttribute.target = attribute;
    program.target = D2ProgramRepository(db).getByUid(json["program"]["id"]);
  }
}
