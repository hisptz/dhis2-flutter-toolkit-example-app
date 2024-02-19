import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageDataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2ProgramStage extends D2MetadataResource {
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
  String? description;
  int sortOrder;
  String? validationStrategy;
  String? featureType;
  String? reportDateToUse;

  final program = ToOne<D2Program>();

  final programStageDataElements = ToMany<D2ProgramStageDataElement>();

  final programStageSections = ToMany<D2ProgramStageSection>();

  D2ProgramStage({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.name,
    required this.sortOrder,
    this.validationStrategy,
    this.reportDateToUse,
    this.featureType,
    this.description,
  });

  D2ProgramStage.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        sortOrder = json["sortOrder"],
        validationStrategy = json["validationStrategy"],
        reportDateToUse = json["reportDateToUse"],
        featureType = json["featureType"],
        description = json["description"] {
    List<D2ProgramStageDataElement> psde = json["programStageDataElements"]
        .cast<Map>()
        .map<D2ProgramStageDataElement>(D2ProgramStageDataElement.fromMap)
        .toList();

    programStageDataElements.addAll(psde);

    List<D2ProgramStageSection> ps = json["programStageSections"]
        .cast<Map>()
        .map<D2ProgramStageSection>(D2ProgramStageSection.fromMap)
        .toList();

    programStageSections.addAll(ps);
  }
}
