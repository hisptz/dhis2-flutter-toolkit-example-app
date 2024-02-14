import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2Attribute extends DHIS2MetadataResource {
  @Id()
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;
  @Index()
  String name;
  String valueType;
  List<String> objectTypes;
  bool? mandatory;
  bool? unique;

  DHIS2Attribute(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.valueType,
      required this.objectTypes,
      this.mandatory,
      this.unique});

  DHIS2Attribute.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        objectTypes = json["objectTypes"],
        valueType = json["valueType"];
}
