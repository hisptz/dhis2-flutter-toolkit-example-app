import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';

import '../../objectbox.g.dart';

class D2EnrollmentRepository extends BaseRepository<D2Enrollment>
    implements SyncableRepository<D2Enrollment> {
  D2EnrollmentRepository(super.db);

  StreamController<SyncStatus> controller = StreamController<SyncStatus>();

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
  Future syncMany(DHIS2Client client) async {
    //TODO: Handle import summary

    queryConditions = D2Enrollment_.synced.equals(false);
    List<D2Enrollment> unSyncedEnrollments = await query.findAsync();
    List<Map<String, dynamic>> responses = [];
    int chunkSize = 50;
    int currentIndex = 0;

    SyncStatus status = SyncStatus(
        synced: 0,
        total: (unSyncedEnrollments.length / chunkSize).ceil(),
        status: Status.initialized,
        label: "Enrollments");
    controller.add(status);

    while (currentIndex < unSyncedEnrollments.length) {
      int endIndex = currentIndex + chunkSize;
      if (endIndex > unSyncedEnrollments.length) {
        endIndex = unSyncedEnrollments.length;
      }

      List<D2Enrollment> currentChunk =
          unSyncedEnrollments.sublist(currentIndex, endIndex);

      List<Map<String, dynamic>> chunkPayload = await Future.wait(
          currentChunk.map((trackedEntity) => trackedEntity.toMap(db: db)));

      Map<String, List<Map<String, dynamic>>> payload = {
        "enrollments": chunkPayload
      };

      Map<String, String> params = {
        "async": "false",
      };

      try {
        Map<String, dynamic> response =
            await client.httpPost<Map<String, dynamic>>("tracker", payload,
                queryParameters: params);
        responses.add(response);
      } catch (e) {
        controller.addError("Could not upload Enrollments");
        return;
      }

      currentIndex += chunkSize;
    }

    controller.add(status.complete());

    return responses;
  }

  @override
  Future syncOne(DHIS2Client client, D2Enrollment entity) async {
    Map<String, dynamic> enrollmentPayload = await entity.toMap(db: db);

    Map<String, List<Map<String, dynamic>>> payload = {
      "enrollments": [enrollmentPayload]
    };
    Map<String, dynamic> response = {};

    SyncStatus status = SyncStatus(
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

    return response;
  }
}
