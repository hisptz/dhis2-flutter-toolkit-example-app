import 'package:dhis2_flutter_toolkit/models/metadata/attributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageDataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStageSection.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProgramStage extends D2MetadataResource {
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
  int sortOrder;
  String validationStrategy;
  String featureType;
  String reportDateToUse;

  final program = ToOne<D2Program>();

  final programStageDataElements = ToMany<ProgramStageDataElement>();

  final attributeValues = ToMany<DHIS2AttributeValue>();

  final programStageSections = ToMany<ProgramStageSection>();

  ProgramStage({
    required this.created,
    required this.lastUpdated,
    required this.uid,
    required this.name,
    required this.sortOrder,
    required this.validationStrategy,
    required this.reportDateToUse,
    required this.featureType,
    required this.description,
  });

  ProgramStage.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        sortOrder = json["sortOrder"],
        validationStrategy = json["validationStrategy"],
        reportDateToUse = json["reportDateToUse"],
        featureType = json["featureType"],
        description = json["description"] {
    List<ProgramStageDataElement> programStageDataElements =
        json["programStageDataElements"].map(ProgramStageDataElement.fromMap);

    programStageDataElements.addAll(programStageDataElements);

    List<DHIS2AttributeValue> attributeValues =
        json["attributeValues"].map(DHIS2AttributeValue.fromMap);

    attributeValues.addAll(attributeValues);

    List<ProgramStageSection> programSections =
        json["programStageSections"].map(ProgramStageSection.fromMap);

    programStageSections.addAll(programSections);
  }
}
