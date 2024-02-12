import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityTypeAttribute.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TrackedEntityType implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String description;

  final trackedEntityTypeAttributes = ToMany<TrackedEntityTypeAttribute>();

  TrackedEntityType(
      this.created, this.lastUpdated, this.uid, this.name, this.description);
}
