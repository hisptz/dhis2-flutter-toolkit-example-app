import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2AttributeValue {
  int id = 0;

  final dataElement = ToOne<D2DataElement>();
  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();
  dynamic value;

  D2AttributeValue({this.value});

  D2AttributeValue.fromMap(Map json) : value = json["value"];
}
