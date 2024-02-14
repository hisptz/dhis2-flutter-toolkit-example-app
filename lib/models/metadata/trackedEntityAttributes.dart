import 'package:dhis2_flutter_toolkit/models/metadata/attributeValue.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TrackedEntityAttribute extends DHIS2MetadataResource {
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
      this.zeroIsSignificant);
}
