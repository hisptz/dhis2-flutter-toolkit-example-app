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

  DHIS2Option(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.code,
      required this.sortOrder});

  DHIS2Option.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"],
        sortOrder = json["sortOrder"];
}
