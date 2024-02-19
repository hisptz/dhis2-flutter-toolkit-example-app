import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
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
  String name;
  int sortOrder;
  bool displayInList;
  bool mandatory;
  String valueType;
  String displayName;

  final program = ToOne<D2Program>();
  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();

  D2ProgramTrackedEntityAttribute(
      this.created,
      this.id,
      this.lastUpdated,
      this.uid,
      this.name,
      this.sortOrder,
      this.displayInList,
      this.mandatory,
      this.valueType,
      this.displayName);

  D2ProgramTrackedEntityAttribute.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        sortOrder = json["sortOrder"],
        displayInList = json["displayInList"],
        mandatory = json["mandatory"],
        valueType = json["valueType"],
        displayName = json["displayName"] {
    D2TrackedEntityAttribute attribute =
        D2TrackedEntityAttribute.fromMap(json["trackedEntityAttribute"]);
    trackedEntityAttribute.target = attribute;
  }
}
