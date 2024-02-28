import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageDataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
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

  @Backlink("programStage")
  final programStageDataElements = ToMany<D2ProgramStageDataElement>();

  @Backlink("programStage")
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

  D2ProgramStage.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        sortOrder = json["sortOrder"],
        validationStrategy = json["validationStrategy"],
        reportDateToUse = json["reportDateToUse"],
        featureType = json["featureType"],
        description = json["description"] {
    id = D2ProgramStageRepository(db).getIdByUid(json["id"]) ?? 0;
    program.target =
        D2ProgramRepository(db).getByUid(json["program"]?["id"] ?? "");
  }
}
