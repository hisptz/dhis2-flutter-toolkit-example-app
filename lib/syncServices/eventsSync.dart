import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class D2EventSync extends BaseTrackerSyncService<D2Event> {
  D2EventSync(ObjectBox db, DHIS2Client client, {required super.program})
      : super(
          label: "Events",
          fields: [
            "*",
          ],
          db: db,
          client: client,
          resource: "tracker/events",
          dataKey: "instances",
        );

  @override
  D2Event mapper(Map<String, dynamic> json) {
    return D2Event.fromMap(db, json);
  }

  @override
  Future syncPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }

    List<Map<String, dynamic>> entityData =
        data[dataKey ?? resource].cast<Map<String, dynamic>>();

    List<D2Event> entities = entityData.map(mapper).toList();

    await box.putManyAsync(entities);

    List<D2DataValue> dValues = [];
    for (Map element in entityData) {
      List<D2DataValue> dataValues = element["dataValues"]
          .map<D2DataValue>((dataValue) =>
              D2DataValue.fromMap(db, dataValue, element["event"]))
          .toList();
      dValues.addAll(dataValues);
    }

    await D2DataValueRepository(db).saveEntities(dValues);
    await syncRelationships(entityData);
  }
}
