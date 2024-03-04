import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

import '../../objectbox.g.dart';

class D2TrackedEntityRepository extends BaseRepository<D2TrackedEntity>
    implements SyncableRepository<D2TrackedEntity> {
  D2TrackedEntityRepository(super.db);

  @override
  D2TrackedEntity? getByUid(String uid) {
    Query<D2TrackedEntity> query =
        box.query(D2TrackedEntity_.uid.equals(uid)).build();
    return query.findFirst();
  }

  List<D2TrackedEntity>? getAll() {
    Query query = box.query().build();
    return query.find() as List<D2TrackedEntity>;
  }

  @override
  D2TrackedEntity mapper(Map<String, dynamic> json) {
    return D2TrackedEntity.fromMap(db, json);
  }

  D2TrackedEntityRepository byIdentifiableToken(String keyword) {
    final trackedEntities = box.getAll();

    final matchingEntities = trackedEntities.where((trackedEntity) {
      final attributeEntities = D2TrackedEntityAttributeValueRepository(db)
          .byTrackedEntity(trackedEntity.id)
          .find();

      final nameAttributes = attributeEntities.where((attribute) =>
          (attribute.trackedEntityAttribute.target?.name == "First name") ||
          (attribute.trackedEntityAttribute.target?.name == "Last name"));

      return nameAttributes.any((attribute) =>
          attribute.value.toLowerCase().contains(keyword.toLowerCase()));
    });

    final uidList = matchingEntities.map((entity) => entity.uid).toList();

    queryConditions = D2TrackedEntity_.uid
        .oneOf(uidList.isNotEmpty ? uidList : ["null"], caseSensitive: false);

    return this;
  }

  @override
  Future syncMany(DHIS2Client client) async {
    //TODO: Pagination
    //TODO: Handle import summary

    queryConditions = D2TrackedEntity_.synced.equals(false);
    List<D2TrackedEntity> unSyncedTrackedEntities = await query.findAsync();
    List<Map<String, dynamic>> trackedEntitiesPayload = await Future.wait(
        unSyncedTrackedEntities
            .map((trackedEntity) => trackedEntity.toMap(db: db)));
    Map<String, List<Map<String, dynamic>>> payload = {
      "trackedEntities": trackedEntitiesPayload
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
  Future syncOne(DHIS2Client client, D2TrackedEntity entity) async {
    Map<String, dynamic> trackedEntityPayload = await entity.toMap(db: db);

    Map<String, List<Map<String, dynamic>>> payload = {
      "trackedEntities": [trackedEntityPayload]
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
