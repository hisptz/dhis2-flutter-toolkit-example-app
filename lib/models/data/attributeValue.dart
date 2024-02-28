import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DHIS2AttributeValue {
  int id = 0;

  final dataElement = ToOne<D2DataElement>();
  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();
  dynamic value;

  DHIS2AttributeValue({this.value});

  DHIS2AttributeValue.fromMap(Map json) : value = json["value"];
}
