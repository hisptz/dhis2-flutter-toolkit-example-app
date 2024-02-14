import 'package:dhis2_flutter_toolkit/models/metadata/attributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TrackedEntityAttribute implements DHIS2MetadataResource {
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
  bool zeroIsSignificant;
  final attributeValues = ToMany<DHIS2AttributeValue>();
  final legendSets = ToMany<LegendSet>();
  final optionSet = ToOne<DHIS2OptionSet>();

  TrackedEntityAttribute(
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
      required this.zeroIsSignificant});

  TrackedEntityAttribute.fromMap(Map json)
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
        zeroIsSignificant = json["zeroIsSignificant"] {
    List<DHIS2AttributeValue> attributeValue =
        json["attributeValues"].map(DHIS2AttributeValue.fromMap);

    attributeValues.addAll(attributeValue);

    List<LegendSet> legendSet = json["attributeValues"].map(LegendSet.fromMap);

    legendSets.addAll(legendSet);
  }
}
