import 'package:dhis2_flutter_toolkit/models/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
import 'package:objectbox/objectbox.dart';

final trackedEntityAttributeBox = db.store.box<D2TrackedEntityAttribute>();

@Entity()
class D2TrackedEntityAttribute extends D2MetadataResource {
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
  String? code;

  String? formName;
  String shortName;
  String? description;
  String aggregationType;
  String valueType;
  bool? zeroIsSignificant;
  final legendSets = ToMany<D2LegendSet>();
  final optionSet = ToOne<D2OptionSet>();

  D2TrackedEntityAttribute(
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
      this.zeroIsSignificant});

  D2TrackedEntityAttribute.fromMap(Map json)
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
    id = D2TrackedEntityAttributeRepository().getIdByUid(json["id"]) ?? 0;
    List<D2LegendSet> legendSet = json["attributeValues"]
        .cast<Map>()
        .map<D2LegendSet>(D2LegendSet.fromMap)
        .toList();

    legendSets.addAll(legendSet);
    if (json["optionSet"] != null) {
      optionSet.target =
          D2OptionSetRepository().getByUid(json["optionSet"]["id"]);
    }
  }
}
