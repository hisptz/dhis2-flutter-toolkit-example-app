import 'dart:html';

import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'attribute.dart';

@Entity()
class DHIS2AttributeValue {
  int id = 0;
  final attribute = ToOne<DHIS2Attribute>();
  final dataElement = ToOne<DataElement>();
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();
  dynamic value;
}
