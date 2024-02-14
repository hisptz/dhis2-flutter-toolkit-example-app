import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/option.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2OptionSet extends DHIS2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String name;
  String code;

  String valueType;

  final options = ToMany<DHIS2Option>();

  DHIS2OptionSet(this.created, this.lastUpdated, this.uid, this.name, this.code,
      this.valueType);
}
