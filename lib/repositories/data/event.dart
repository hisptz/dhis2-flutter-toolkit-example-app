import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';

import '../../objectbox.g.dart';

class D2EventRepository extends BaseRepository<D2Event>
    implements SyncableRepository<D2Event> {
  D2EventRepository(super.db);

  StreamController<SyncStatus> controller = StreamController<SyncStatus>();

  @override
  D2Event? getByUid(String uid) {
    Query<D2Event> query = box.query(D2Event_.uid.equals(uid)).build();
    return query.findFirst();
  }

  List<D2Event>? getAll() {
    Query query = box.query().build();
    return query.find() as List<D2Event>;
  }

  @override
  D2Event mapper(Map<String, dynamic> json) {
    return D2Event.fromMap(db, json);
  }

  D2EventRepository byTrackedEntity(int id) {
    queryConditions = D2Event_.trackedEntity.equals(id);
    return this;
  }

  D2EventRepository byEnrollment(int id) {
    queryConditions = D2Event_.enrollment.equals(id);
    return this;
  }

  @override
  Future syncMany(DHIS2Client client) async {
    //TODO: Handle import summary

    queryConditions = D2Event_.synced.equals(false);
    List<D2Event> unSyncedEvents = await query.findAsync();
    List<Map<String, dynamic>> responses = [];
    int chunkSize = 50;
    int currentIndex = 0;

    SyncStatus status = SyncStatus(
        synced: 0,
        total: (unSyncedEvents.length / chunkSize).ceil(),
        status: Status.initialized,
        label: "Events");
    controller.add(status);

    while (currentIndex < unSyncedEvents.length) {
      int endIndex = currentIndex + chunkSize;
      if (endIndex > unSyncedEvents.length) {
        endIndex = unSyncedEvents.length;
      }

      List<D2Event> currentChunk =
          unSyncedEvents.sublist(currentIndex, endIndex);

      List<Map<String, dynamic>> chunkPayload = await Future.wait(
          currentChunk.map((trackedEntity) => trackedEntity.toMap(db: db)));

      Map<String, List<Map<String, dynamic>>> payload = {
        "events": chunkPayload
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
        controller.addError("Could not upload Events");
        return;
      }

      currentIndex += chunkSize;
    }

    controller.add(status.complete());

    return responses;
  }

  @override
  Future syncOne(DHIS2Client client, D2Event entity) async {
    Map<String, dynamic> eventPayload = await entity.toMap(db: db);

    Map<String, List<Map<String, dynamic>>> payload = {
      "events": [eventPayload]
    };

    Map<String, dynamic> response = {};

    SyncStatus status = SyncStatus(
        synced: 0, total: 1, status: Status.initialized, label: "Events");
    controller.add(status);

    Map<String, String> params = {
      "async": "false",
    };

    try {
      response = await client.httpPost<Map<String, dynamic>>("tracker", payload,
          queryParameters: params);
    } catch (e) {
      controller.addError("Could not upload event");
      return;
    }

    controller.add(status.increment());
    controller.add(status.complete());

    return response;
  }
}
