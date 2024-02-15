import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityTypeAttribute.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TrackedEntityType extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String description;

  final trackedEntityTypeAttributes = ToMany<TrackedEntityTypeAttribute>();

  TrackedEntityType(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.description});

  TrackedEntityType.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        description = json["description"] {
    List<TrackedEntityTypeAttribute> attributes =
        json["trackedEntityTypeAttributes"]
            .map(TrackedEntityTypeAttribute.fromMap);

    trackedEntityTypeAttributes.addAll(attributes);
  }
}
