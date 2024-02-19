import 'package:dhis2_flutter_toolkit/models/metadata/attributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

final dataElementBox = db.store.box<DataElement>();

@Entity()
class DataElement extends D2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String? code;

  String? formName;
  String shortName;
  String? description;
  String aggregationType;
  String valueType;
  String domainType;
  bool? zeroIsSignificant;
  final attributeValues = ToMany<DHIS2AttributeValue>();
  final legendSets = ToMany<LegendSet>();
  final optionSet = ToOne<DHIS2OptionSet>();

  DataElement(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      this.code,
      this.formName,
      required this.shortName,
      this.description,
      required this.aggregationType,
      required this.valueType,
      required this.domainType,
      this.zeroIsSignificant});

  DataElement.fromMap(Map json)
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
        zeroIsSignificant = json["zeroIsSignificant"] {
    List<DHIS2AttributeValue> value = json["attributeValues"]
        .cast<Map>()
        .map<DHIS2AttributeValue>(DHIS2AttributeValue.fromMap)
        .toList();
    attributeValues.addAll(value);

    List<LegendSet> set = json["legendSets"]
        .cast<Map>()
        .map<LegendSet>(LegendSet.fromMap)
        .toList();
    legendSets.addAll(set);
  }

  @override
  int id = 0;
}
