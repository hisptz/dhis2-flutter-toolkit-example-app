import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2Attribute implements DHIS2MetadataResource {
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
}
