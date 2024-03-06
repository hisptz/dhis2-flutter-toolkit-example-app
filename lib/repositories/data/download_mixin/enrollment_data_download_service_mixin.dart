import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/download_mixin/base_tracker_data_download_service_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2EnrollmentDownloadServiceMixin
    on BaseTrackerDataDownloadServiceMixin<D2Enrollment> {
  @override
  String label = "Enrollments";

  @override
  String downloadResource = "tracker/enrollments";

  D2EnrollmentDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*"]);
    return this;
  }

  @override
  Future<void> download() async {
    if (program!.programType != "WITH_REGISTRATION") {
      return;
    }
    await super.download();
  }
}
