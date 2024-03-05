import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/download_mixin/base_tracker_data_download_service_mixin.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/utils/download_status.dart';

import '../../objectbox.g.dart';
import 'download_mixin/enrollment_data_download_service_mixin.dart';

class D2EnrollmentRepository extends BaseDataRepository<D2Enrollment>
    with
        BaseTrackerDataDownloadServiceMixin<D2Enrollment>,
        D2EnrollmentDownloadServiceMixin
    implements SyncableRepository<D2Enrollment> {
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
  Future syncOne(DHIS2Client client, D2Enrollment entity) async {
    Map<String, dynamic> enrollmentPayload = await entity.toMap(db: db);

    Map<String, List<Map<String, dynamic>>> payload = {
      "enrollments": [enrollmentPayload]
    };
    Map<String, dynamic> response = {};

    DownloadStatus status = DownloadStatus(
        synced: 0, total: 1, status: Status.initialized, label: "Enrollment");
    controller.add(status);

    Map<String, String> params = {
      "async": "false",
    };

    try {
      response = await client.httpPost<Map<String, dynamic>>("tracker", payload,
          queryParameters: params);
    } catch (e) {
      controller.addError("Could not upload enrollment");
      return;
    }

    controller.add(status.increment());
    controller.add(status.complete());
    controller.close();

    return response;
  }
}
