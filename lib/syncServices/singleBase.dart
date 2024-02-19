import 'dart:async';

import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';

import '../models/base.dart';
import '../objectbox.g.dart';

abstract class BaseSingleSyncService<T extends DHIS2Resource> {
  String resource;
  List<String>? fields = [];
  List<String>? filters = [];
  T? entity;
  Box<T> box;
  String label;
  StreamController<SyncStatus> controller = StreamController<SyncStatus>();

  BaseSingleSyncService(
      {required this.resource,
      this.fields,
      this.filters,
      required this.box,
      required this.label});

  get url {
    return resource;
  }

  get stream {
    return controller.stream;
  }

  get queryParams {
    Map<String, String> params = {};
    if (fields != null) {
      params["fields"] = fields!.isNotEmpty ? fields!.join(",") : "";
    }
    if (filters != null) {
      params["filters"] = filters!.isNotEmpty ? filters!.join(",") : "";
    }

    return params;
  }

  //Currently just checks if there is any data on the specific data model
  bool isSynced() {
    List<T> entity = box.getAll();
    return entity.isNotEmpty;
  }

  Future<D?> getData<D>() async {
    return await dhis2client?.httpGet<D>(url, queryParameters: queryParams);
  }

  T mapper(Map<String, dynamic> json);

  void sync() async {
    SyncStatus status = SyncStatus(
        synced: 0, total: 1, status: Status.initialized, label: label);
    controller.add(status);
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>();
    if (data == null) {
      controller.addError("Could not get $label");
      return;
    }
    T entity = mapper(data);
    box.put(entity);
    status.increment();
    controller.add(status.complete());
    controller.close();
  }
}
