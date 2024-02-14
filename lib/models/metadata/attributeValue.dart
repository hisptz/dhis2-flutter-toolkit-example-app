import 'dart:html';

import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'attribute.dart';

class DHIS2AttributeValue {
  //TODO: Add the one 2 one relationships to the constructor
  final attribute = ToOne<DHIS2Attribute>();
  final dataElement = ToOne<DataElement>();
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();
  dynamic value;

  DHIS2AttributeValue({this.value});

  DHIS2AttributeValue.fromMap(Map json) : value = json["value"];
}
