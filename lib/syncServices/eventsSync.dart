import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/dataValue.dart';

import 'package:dhis2_flutter_toolkit/repositories/data/event.dart';

import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class D2EventSync extends BaseTrackerSyncService<D2Event> {
  String program;
  String defaultOrgUnit;

  D2EventSync(this.program, this.defaultOrgUnit)
      : super(
          label: "Events",
          fields: [
            "*",
          ],
          box: d2EventBox,
          resource: "tracker/events",
          extraParams: {
            "ouMode": "DESCENDANTS",
            "orgUnit": defaultOrgUnit,
            "program": program,
          },
          dataKey: "instances",
        );

  @override
  D2Event mapper(Map<String, dynamic> json) {
    return D2Event.fromMap(json);
  }

  @override
  Future syncPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }

    List<Map<String, dynamic>> entityData =
        data[dataKey ?? resource].cast<Map<String, dynamic>>();

    List<Map<String, dynamic>> dataValues = entityData
        .map((data) =>
            {"event": data["event"], "dataValues": data["dataValues"]})
        .toList();

    List<D2Event> entities = entityData.map(mapper).toList();

    await box.putManyAsync(entities);

    final values = dataValues
        .cast<Map>()
        .map((data) => data["dataValues"]
            .cast<Map>()
            .map<D2DataValue>((attributeMap) =>
                D2DataValue.fromMap(attributeMap, data["event"]))
            .toList()
            .cast<D2DataValue>())
        .toList();

    await Future.wait(values.map((data) async {
      await d2DataValueBox.putAndGetManyAsync(data);
    }));
  }
}
