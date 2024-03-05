import 'dart:async';

import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/utils/download_status.dart';

import '../../objectbox.g.dart';

class RelationshipRepository extends BaseDataRepository<D2Relationship>
    implements SyncableRepository<D2Relationship> {
  RelationshipRepository(super.db);

  StreamController<DownloadStatus> controller =
      StreamController<DownloadStatus>();

  @override
  D2Relationship? getByUid(String uid) {
    Query<D2Relationship> query =
        box.query(D2Relationship_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Relationship mapper(Map<String, dynamic> json) {
    return D2Relationship.fromMap(db, json);
  }

  @override
  Future syncMany(DHIS2Client client) async {
    //TODO: Handle import summary

    queryConditions = D2Relationship_.synced.equals(false);
    List<D2Relationship> unSyncedRelationships = await query.findAsync();
    List<Map<String, dynamic>> responses = [];
    int chunkSize = 50;
    int currentIndex = 0;

    DownloadStatus status = DownloadStatus(
        synced: 0,
        total: (unSyncedRelationships.length / chunkSize).ceil(),
        status: Status.initialized,
        label: "Events");
    controller.add(status);

    while (currentIndex < unSyncedRelationships.length) {
      int endIndex = currentIndex + chunkSize;
      if (endIndex > unSyncedRelationships.length) {
        endIndex = unSyncedRelationships.length;
      }

      List<D2Relationship> currentChunk =
          unSyncedRelationships.sublist(currentIndex, endIndex);

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
        controller.addError("Could not upload Relationships");
        return;
      }

      currentIndex += chunkSize;
    }

    controller.add(status.complete());
    controller.close();
    return responses;
  }

  @override
  Future syncOne(DHIS2Client client, D2Relationship entity) async {
    Map<String, dynamic> relationshipPayload = await entity.toMap(db: db);

    Map<String, List<Map<String, dynamic>>> payload = {
      "relationships": [relationshipPayload]
    };

    Map<String, dynamic> response = {};

    DownloadStatus status = DownloadStatus(
        synced: 0, total: 1, status: Status.initialized, label: "Relationship");
    controller.add(status);

    Map<String, String> params = {
      "async": "false",
    };

    try {
      response = await client.httpPost<Map<String, dynamic>>("tracker", payload,
          queryParameters: params);
    } catch (e) {
      controller.addError("Could not upload relationship");
      return;
    }

    controller.add(status.increment());
    controller.add(status.complete());
    controller.close();

    return response;
  }
}
