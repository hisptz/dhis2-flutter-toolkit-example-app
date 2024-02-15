import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'trackedEntityType.dart';

@Entity()
class TrackedEntityTypeAttribute extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  final trackedEntityType = ToOne<TrackedEntityType>();
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();

  String valueType;
  String displayName;
  String displayShortName;
  bool mandatory;

  TrackedEntityTypeAttribute(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.valueType,
      required this.displayName,
      required this.displayShortName,
      required this.mandatory});

  TrackedEntityTypeAttribute.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        valueType = json["valueType"],
        displayName = json["displayName"],
        displayShortName = json["displayShortName"],
        mandatory = json["mandatory"];
}
