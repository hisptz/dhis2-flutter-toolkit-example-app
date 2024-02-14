import 'package:dhis2_flutter_toolkit/models/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'attribute.dart';

@Entity()
class DHIS2AttributeValue {


  final attribute = ToOne<DHIS2Attribute>();
  final dataElement = ToOne<DataElement>();
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();
  dynamic value;


  DHIS2AttributeValue({this.value});

  DHIS2AttributeValue.fromMap(Map json) : value = json["value"];

}
