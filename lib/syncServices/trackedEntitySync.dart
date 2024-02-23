import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class TrackedEntitySync extends BaseSyncService<TrackedEntity> {
  String program;
  String defaultOrgUnit;

  TrackedEntitySync(this.program, this.defaultOrgUnit)
      : super(
          label: "Tracked Entity Instances",
          fields: [
            "*",
          ],
          box: trackedEntityBox,
          resource: "trackedEntityInstances",
          extraParams: {
            "program": program,
            "ouMode": "DESCENDANTS",
            "orgUnit": defaultOrgUnit
          },
        );

  @override
  TrackedEntity mapper(Map<String, dynamic> json) {
    return TrackedEntity.fromMap(json);
  }
}
