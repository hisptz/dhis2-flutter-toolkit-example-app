import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStageSection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2ProgramStageSection extends D2MetadataResource {
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

  final programStage = ToOne<D2ProgramStage>();

  final dataElements = ToMany<D2DataElement>();

  D2ProgramStageSection(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.sortOrder});

  D2ProgramStageSection.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        sortOrder = json["sortOrder"] {
    id = D2ProgramStageSectionRepository().getIdByUid(json["id"]) ?? 0;
    List<D2DataElement?> dataElementObjects = json["dataElements"]
        .cast<Map>()
        .map<D2DataElement?>(
            (Map de) => D2DataElementRepository().getByUid(de["id"]))
        .toList();

    List<D2DataElement> des = dataElementObjects
        .where((D2DataElement? element) => element != null)
        .toList()
        .cast<D2DataElement>();
    dataElements.addAll(des);
    programStage.target =
        D2ProgramStageRepository().getByUid(json["programStage"]["id"]);
  }
}
