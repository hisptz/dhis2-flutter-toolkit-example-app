import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/repositories/trackedEntityAttribute.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProgramSection extends D2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;
  int sortOrder;
  String name;

  final program = ToOne<D2Program>();
  final trackedEntityAttributes = ToMany<TrackedEntityAttribute>();

  ProgramSection(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.sortOrder});

  ProgramSection.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        sortOrder = json["sortOrder"] {
    List<TrackedEntityAttribute?> tei = json["trackedEntityAttributes"]
        .cast<Map>()
        .map<TrackedEntityAttribute?>((Map tea) =>
            D2TrackedEntityAttributeRepository().getByUid(tea["id"]))
        .toList();

    List<TrackedEntityAttribute> actualTea = tei
        .where((element) => element != null)
        .toList()
        .cast<TrackedEntityAttribute>();
    trackedEntityAttributes.addAll(actualTea);
  }
}
