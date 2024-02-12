import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/optionSet.dart';
import 'package:objectbox/objectbox.dart';

class DHIS2Option implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String name;
  String code;
  int sortOrder;

  final optionSet = ToOne<DHIS2OptionSet>();

  DHIS2Option(this.created, this.lastUpdated, this.uid, this.name, this.code,
      this.sortOrder);
}
