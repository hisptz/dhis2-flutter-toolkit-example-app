import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:objectbox/objectbox.dart';

import 'trackedEntityType.dart';

@Entity()
class TrackedEntityTypeAttribute extends DHIS2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  final trackedEntityType = ToOne<TrackedEntityType>();
  final trackedEntityAttribute = ToOne<TrackedEntityAttribute>();

  String valueType;
  String displayName;
  String displayShortName;
  bool mandatory;

  TrackedEntityTypeAttribute(this.created, this.lastUpdated, this.uid,
      this.valueType, this.displayName, this.displayShortName, this.mandatory);
}
