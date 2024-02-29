import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class TrackedEntitySync extends BaseTrackerSyncService<D2TrackedEntity> {
  TrackedEntitySync(ObjectBox db, DHIS2Client client, {required super.program})
      : super(
            label: "Tracked Entities",
            fields: [
              "*",
            ],
            db: db,
            resource: "tracker/trackedEntities",
            extraParams: {
              "program": program.uid,
              "ouMode": "ACCESSIBLE",
            },
            client: client,
            dataKey: "instances");

  @override
  D2TrackedEntity mapper(Map<String, dynamic> json) {
    return D2TrackedEntity.fromMap(db, json);
  }

  @override
  Future syncPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }

    List<Map<String, dynamic>> entityData =
        data[dataKey ?? resource].cast<Map<String, dynamic>>();

    List<D2TrackedEntity> entities = entityData.map(mapper).toList();

    await box.putManyAsync(entities);

    List<D2TrackedEntityAttributeValue> attributeValues = [];
    for (var element in entityData) {
      List<D2TrackedEntityAttributeValue> attributeValue = element["attributes"]
          ?.map<D2TrackedEntityAttributeValue>((attributeValue) =>
              D2TrackedEntityAttributeValue.fromMap(
                  db, attributeValue, element["trackedEntity"]))
          .toList();
      attributeValues.addAll(attributeValue);
    }
    await D2TrackedEntityAttributeValueRepository(db)
        .saveEntities(attributeValues);
    await syncRelationships(entityData);
  }

  @override
  void sync() {
    if (program.programType != "WITH_REGISTRATION") {
      return;
    }
    super.sync();
  }
}
