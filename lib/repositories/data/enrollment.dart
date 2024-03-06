import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/download_mixin/base_tracker_data_download_service_mixin.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/upload_mixin/base_tracker_data_upload_service_mixin.dart';

import '../../objectbox.g.dart';
import 'download_mixin/enrollment_data_download_service_mixin.dart';

class D2EnrollmentRepository extends BaseDataRepository<D2Enrollment>
    with
        BaseTrackerDataDownloadServiceMixin<D2Enrollment>,
        D2EnrollmentDownloadServiceMixin,
        BaseTrackerDataUploadServiceMixin<D2Enrollment> {
  D2EnrollmentRepository(super.db);

  @override
  D2Enrollment? getByUid(String uid) {
    Query<D2Enrollment> query =
        box.query(D2Enrollment_.uid.equals(uid)).build();
    return query.findFirst();
  }

  List<D2Enrollment>? getAll() {
    Query query = box.query().build();
    return query.find() as List<D2Enrollment>;
  }

  @override
  D2Enrollment mapper(Map<String, dynamic> json) {
    return D2Enrollment.fromMap(db, json);
  }

  D2EnrollmentRepository byTrackedEntity(int id) {
    queryConditions = D2Enrollment_.trackedEntity.equals(id);
    return this;
  }

  @override
  String uploadDataKey = "enrollments";

  @override
  setUnSyncedQuery() {
    if (queryConditions != null) {
      queryConditions!.and(D2Enrollment_.synced.equals(true));
    } else {
      queryConditions = D2Enrollment_.synced.equals(true);
    }
  }
}
