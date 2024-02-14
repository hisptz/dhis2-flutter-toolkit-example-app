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

  DHIS2Attribute(this.created, this.lastUpdated, this.uid, this.name,
      this.valueType, this.objectTypes, this.mandatory, this.unique);

  DHIS2Attribute.fromMap(Map json)
      : created = DateTime(json["created"]),
        lastUpdated = DateTime(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        objectTypes = json["objectTypes"],
        valueType = json["valueType"];
}
