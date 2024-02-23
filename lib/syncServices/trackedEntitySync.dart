import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';

import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class TrackedEntitySync extends BaseTrackerSyncService<TrackedEntity> {
  String program;
  String defaultOrgUnit;

  TrackedEntitySync(this.program, this.defaultOrgUnit)
      : super(
            label: "Tracked Entity Instances",
            fields: [
              "*",
            ],
            box: trackedEntityBox,
            resource: "tracker/trackedEntities",
            extraParams: {
              "program": program,
              "ouMode": "DESCENDANTS",
              "orgUnit": defaultOrgUnit
            },
            dataKey: "instances");

  @override
  TrackedEntity mapper(Map<String, dynamic> json) {
    return TrackedEntity.fromMap(json);
  }
}
