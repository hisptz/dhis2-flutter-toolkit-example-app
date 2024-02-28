import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntityAttributeValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntityAttributeValue.dart';

import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class TrackedEntitySync extends BaseTrackerSyncService<TrackedEntity> {
  String program;
  String defaultOrgUnit;

  TrackedEntitySync(this.program, this.defaultOrgUnit)
      : super(
            label: "Tracked Entity Instances",
            fields: [
              "*",
            ],
            box: trackedEntityBox,
            resource: "tracker/trackedEntities",
            extraParams: {
              "program": program,
              "ouMode": "DESCENDANTS",
              "orgUnit": defaultOrgUnit
            },
            dataKey: "instances");

  @override
  TrackedEntity mapper(Map<String, dynamic> json) {
    return TrackedEntity.fromMap(json);
  }

  @override
  Future syncPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }

    List<Map<String, dynamic>> entityData =
        data[dataKey ?? resource].cast<Map<String, dynamic>>();

    List<Map<String, dynamic>> attributeData = entityData
        .map((data) =>
            {"teiId": data["trackedEntity"], "attributes": data["attributes"]})
        .toList();

    List<TrackedEntity> entities = entityData.map(mapper).toList();

    await box.putManyAsync(entities);

    final attributes = attributeData
        .cast<Map>()
        .map((data) => data["attributes"]
            .cast<Map>()
            .map<D2TrackedEntityAttributeValue>((attributeMap) =>
                D2TrackedEntityAttributeValue.fromMap(
                    attributeMap, data["teiId"]))
            .toList()
            .cast<D2TrackedEntityAttributeValue>())
        .toList();

    await Future.wait(attributes.map((data) async {
      await d2TrackedEntityAttributeValueBox.putAndGetManyAsync(data);
    }));
  }
}
