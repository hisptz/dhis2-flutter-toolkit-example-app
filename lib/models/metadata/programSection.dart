import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

class ProgramSection implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;
  int sortOrder;
  String name;

  final program = ToOne<Program>();
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
    List<TrackedEntityAttribute> tei =
        json["trackedEntityAttributes"].map(TrackedEntityAttribute.fromMap);

    trackedEntityAttributes.addAll(tei);
  }
}
