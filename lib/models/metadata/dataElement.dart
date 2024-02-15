import 'package:dhis2_flutter_toolkit/models/metadata/attributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

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
  String code;

  String formName;
  String shortName;
  String description;
  String aggregationType;
  String valueType;
  String domainType;
  bool zeroIsSignificant;
  final attributeValues = ToMany<DHIS2AttributeValue>();
  final legendSets = ToMany<LegendSet>();
  final optionSet = ToOne<DHIS2OptionSet>();

  DataElement(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.code,
      required this.formName,
      required this.shortName,
      required this.description,
      required this.aggregationType,
      required this.valueType,
      required this.domainType,
      required this.zeroIsSignificant});

  static DataElement? getByUid(String id) {
    Query query = dataElementBox.query(DataElement_.uid.equals(id)).build();
    return query.findFirst();
  }

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
    List<DHIS2AttributeValue> value =
        json["attributeValues"].map(DHIS2AttributeValue.fromMap);
    attributeValues.addAll(value);

    List<LegendSet> set = json["legendSets"].map(LegendSet.fromMap);
    legendSets.addAll(set);
  }

  @override
  int id = 0;
}
