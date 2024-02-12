import 'dart:html';

import 'package:objectbox/objectbox.dart';

import 'attribute.dart';

class DHIS2AttributeValue {
  final attribute = ToOne<DHIS2Attribute>();
  final dataElement = ToOne<DataElement>();
  dynamic value;

  DHIS2AttributeValue(this.value);
}
