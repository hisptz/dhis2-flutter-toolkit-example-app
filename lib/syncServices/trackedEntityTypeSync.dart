import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class D2TrackedEntityTypeSync extends BaseSyncService<D2TrackedEntityType> {
  D2TrackedEntityTypeSync({required super.db, required super.client})
      : super(
            resource: "trackedEntityTypes",
            fields: ["*"],
            label: "Tracked entity Types");

  @override
  D2TrackedEntityType mapper(Map<String, dynamic> json) {
    return D2TrackedEntityType.fromMap(db, json);
  }
}
