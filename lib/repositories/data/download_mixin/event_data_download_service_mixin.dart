import 'package:dhis2_flutter_toolkit/models/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/models/data/event.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/dataValue.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/download_mixin/base_tracker_data_download_service_mixin.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

mixin D2EventDataDownloadServiceMixin
    on BaseTrackerDataDownloadServiceMixin<D2Event> {
  @override
  String label = "Events";

  @override
  String downloadResource = "tracker/events";

  D2EventDataDownloadServiceMixin setupDownload(DHIS2Client client) {
    setClient(client);
    setFields(["*"]);
    return this;
  }

  @override
  Future downloadPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }

    List<Map<String, dynamic>> entityData =
        data[dataKey ?? downloadResource].cast<Map<String, dynamic>>();

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
    await downloadRelationships(entityData);
  }
}
