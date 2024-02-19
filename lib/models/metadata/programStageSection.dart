import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProgramStageSection extends D2MetadataResource {
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
  int sortOrder;

  final programStage = ToOne<ProgramStage>();

  final dataElements = ToMany<DataElement>();

  ProgramStageSection(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.sortOrder});

  ProgramStageSection.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        sortOrder = json["sortOrder"] {
    List<DataElement?> dataElementObjects = json["dataElements"]
        .cast<Map>()
        .map<DataElement?>(
            (Map de) => D2DataElementRepository().getByUid(de["id"]))
        .toList();

    List<DataElement> des = dataElementObjects
        .where((DataElement? element) => element != null)
        .toList()
        .cast<DataElement>();
    dataElements.addAll(des);
  }
}
