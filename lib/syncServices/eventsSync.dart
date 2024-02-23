import 'package:dhis2_flutter_toolkit/models/data/event.dart';

import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';

import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class D2EventSync extends BaseTrackerSyncService<D2Event> {
  String program;
  String defaultOrgUnit;

  D2EventSync(this.program, this.defaultOrgUnit)
      : super(
          label: "Events",
          fields: [
            "*",
          ],
          box: d2EventBox,
          resource: "tracker/events",
          extraParams: {
            "ouMode": "DESCENDANTS",
            "orgUnit": defaultOrgUnit,
            "program": program,
          },
          dataKey: "instances",
        );

  @override
  D2Event mapper(Map<String, dynamic> json) {
    return D2Event.fromMap(json);
  }
}
