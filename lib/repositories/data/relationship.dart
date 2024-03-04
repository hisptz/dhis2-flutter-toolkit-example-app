import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

import '../../objectbox.g.dart';

class RelationshipRepository extends BaseRepository<D2Relationship>
    implements SyncableRepository<D2Relationship> {
  RelationshipRepository(super.db);

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
    //TODO: Pagination
    //TODO: Handle import summary

    queryConditions = D2Relationship_.synced.equals(false);
    List<D2Relationship> unSyncedRelationships = await query.findAsync();
    List<Map<String, dynamic>> relationshipsPayload = await Future.wait(
        unSyncedRelationships
            .map((relationship) => relationship.toMap(db: db)));
    Map<String, List<Map<String, dynamic>>> payload = {
      "relationships": relationshipsPayload
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
  Future syncOne(DHIS2Client client, D2Relationship entity) async {
    Map<String, dynamic> relationshipPayload = await entity.toMap(db: db);

    Map<String, List<Map<String, dynamic>>> payload = {
      "relationships": [relationshipPayload]
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
