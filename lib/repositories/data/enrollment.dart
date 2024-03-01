import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

import '../../objectbox.g.dart';

class D2EnrollmentRepository extends BaseRepository<D2Enrollment>
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
  Future syncMany(DHIS2Client client, List<D2Enrollment> entities) async {
    //TODO: Pagination
    //TODO: Handle import summary

    queryConditions = D2Enrollment_.synced.equals(true);
    List<D2Enrollment> unSyncedEnrollments = await query.findAsync();
    List<Map<String, dynamic>> enrollmentPayload = await Future.wait(
        unSyncedEnrollments.map((enrollemnt) => enrollemnt.toMap(db: db)));
    Map<String, List<Map<String, dynamic>>> payload = {
      "enrollments": enrollmentPayload
    };

    Map<String, String> params = {
      "async": "false",
    };

    Map<String, dynamic> response = await client.httpPost<Map<String, dynamic>>(
        "tracker", payload,
        queryParameters: params);

    return response;
  }

  @override
  Future syncOne(DHIS2Client client, D2Enrollment entity) async {
    Map<String, dynamic> enrollmentPayload = await entity.toMap(db: db);

    Map<String, List<Map<String, dynamic>>> payload = {
      "enrollments": [enrollmentPayload]
    };

    Map<String, String> params = {
      "async": "false",
    };

    Map<String, dynamic> response = await client.httpPost<Map<String, dynamic>>(
        "tracker", payload,
        queryParameters: params);

    return response;
  }
}
