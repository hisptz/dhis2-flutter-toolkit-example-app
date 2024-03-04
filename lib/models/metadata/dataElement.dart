import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/optionSet.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2DataElement extends D2MetadataResource {
  @override
  DateTime created;
  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String? code;
  String? displayFormName;
  @override
  String? displayName;

  String? formName;
  String shortName;
  String? description;
  String aggregationType;
  String valueType;
  String domainType;
  bool? zeroIsSignificant;
  final legendSets = ToMany<D2LegendSet>();
  final optionSet = ToOne<D2OptionSet>();

  final dataValues = ToMany<D2DataValue>();

  D2DataElement(
      this.created,
      this.lastUpdated,
      this.uid,
      this.name,
      this.code,
      this.formName,
      this.shortName,
      this.description,
      this.aggregationType,
      this.valueType,
      this.domainType,
      this.zeroIsSignificant,
      this.displayFormName,
      this.displayName);

  D2DataElement.fromMap(ObjectBox db, Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"],
        formName = json["formName"],
        shortName = json["shortName"],
        description = json["description"],
        aggregationType = json["aggregationType"],
        valueType = json["valueType"],
        domainType = json["domainType"],
        displayFormName = json["displayFormName"],
        displayName = json["displayName"],
        zeroIsSignificant = json["zeroIsSignificant"] {
    id = D2DataElementRepository(db).getIdByUid(json["id"]) ?? 0;

    if (json["optionSet"] != null) {
      optionSet.target =
          D2OptionSetRepository(db).getByUid(json["optionSet"]["id"]);
    }
  }

  @override
  int id = 0;
}
