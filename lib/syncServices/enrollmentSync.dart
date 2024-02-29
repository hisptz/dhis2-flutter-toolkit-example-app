import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class D2EnrollmentSync extends BaseTrackerSyncService<D2Enrollment> {
  D2EnrollmentSync(ObjectBox db, DHIS2Client client, {required super.program})
      : super(
          label: "Enrollments",
          fields: [
            "*",
          ],
          db: db,
          client: client,
          resource: "tracker/enrollments",
          dataKey: "instances",
        );

  @override
  D2Enrollment mapper(Map<String, dynamic> json) {
    return D2Enrollment.fromMap(db, json);
  }

  @override
  void sync() {
    if (program.programType != "WITH_REGISTRATION") {
      return;
    }
    super.sync();
  }
}
