import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';

import 'package:dhis2_flutter_toolkit/repositories/data/enrollment.dart';

import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class D2EnrollmentSync extends BaseSyncService<D2Enrollment> {
  String program;
  String defaultOrgUnit;

  D2EnrollmentSync(this.program, this.defaultOrgUnit)
      : super(
          label: "Enrollments",
          fields: ["*", "events[*]"],
          box: d2EnrollmentBox,
          resource: "tracker/enrollments",
          extraParams: {
            "ouMode": "DESCENDANTS",
            "orgUnit": defaultOrgUnit,
            "program": program,
          },
          dataKey: "instances",
        );

  @override
  D2Enrollment mapper(Map<String, dynamic> json) {
    return D2Enrollment.fromMap(json);
  }
}
