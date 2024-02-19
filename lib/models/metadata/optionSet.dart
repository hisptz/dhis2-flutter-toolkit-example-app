import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/option.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2OptionSet extends D2MetadataResource {
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

  final options = ToMany<D2Option>();

  D2OptionSet(
      {required this.created,
      required this.lastUpdated,
      required this.uid,
      required this.name,
      required this.code,
      required this.valueType});

  D2OptionSet.fromMap(Map json)
      : created = DateTime.parse(json["created"]),
        lastUpdated = DateTime.parse(json["lastUpdated"]),
        uid = json["id"],
        name = json["name"],
        code = json["code"],
        valueType = json["valueType"] {
    List<D2Option> option = json["options"].map(D2Option.fromMap);
    options.addAll(option);
  }
}
