import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/option.dart';
import 'package:objectbox/objectbox.dart';

class DHIS2OptionSet implements DHIS2MetadataResource {
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

  DHIS2OptionSet(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.code,
      required this.valueType});

  DHIS2OptionSet.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"],
        valueType = json["valueType"] {
    List<DHIS2Option> option = json["options"].map(DHIS2Option.fromMap);
    options.addAll(option);
  }
}
