import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStageDataElement.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2ProgramStageDataElement extends D2MetadataResource {
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

  final programStage = ToOne<D2ProgramStage>();
  final dataElement = ToOne<D2DataElement>();

  D2ProgramStageDataElement(this.created, this.id, this.lastUpdated, this.uid,
      this.compulsory, this.sortOrder);

  D2ProgramStageDataElement.fromMap(ObjectBox db, Map json)
      : uid = json["id"],
        created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        compulsory = json["compulsory"],
        sortOrder = json["sortOrder"] {
    id = D2ProgramStageDataElementRepository(db).getIdByUid(json["id"]) ?? 0;
    dataElement.target =
        D2DataElementRepository(db).getByUid(json["dataElement"]["id"]);
    programStage.target =
        D2ProgramStageRepository(db).getByUid(json["programStage"]["id"]);
  }

  @override
  String? displayName;
}
