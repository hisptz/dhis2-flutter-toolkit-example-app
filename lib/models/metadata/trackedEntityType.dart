import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityTypeAttribute.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityType.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2TrackedEntityType extends D2MetadataResource {
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

  final trackedEntityTypeAttributes = ToMany<D2TrackedEntityTypeAttribute>();

  D2TrackedEntityType(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.description});

  D2TrackedEntityType.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        description = json["description"] {
    id = D2TrackedEntityTypeRepository().getIdByUid(json["id"]) ?? 0;
    List<D2TrackedEntityTypeAttribute> attributes =
        json["trackedEntityTypeAttributes"]
            .map(D2TrackedEntityTypeAttribute.fromMap);

    trackedEntityTypeAttributes.addAll(attributes);
  }
}
