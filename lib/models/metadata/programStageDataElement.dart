import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProgramStageDataElement extends D2MetadataResource {
  @override
  DateTime created;

  @override
  int id = 0;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  bool compulsory;
  int? sortOrder;

  final programStage = ToOne<ProgramStage>();
  final dataElement = ToOne<DataElement>();

  ProgramStageDataElement(this.created, this.id, this.lastUpdated, this.uid,
      this.compulsory, this.sortOrder);

  ProgramStageDataElement.fromMap(Map json)
      : uid = json["id"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        compulsory = json["compulsory"],
        sortOrder = json["sortOrder"] {
    dataElement.target = DataElement.fromMap(json["dataElement"]);
  }
}
