import 'dart:async';

import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';

import '../models/metadata/base.dart';

abstract class BaseSingleSyncService<T extends D2MetaResource> {
  ObjectBox db;
  DHIS2Client client;
  String resource;
  List<String>? fields = [];
  List<String>? filters = [];
  T? entity;
  String label;
  StreamController<DownloadStatus> controller =
      StreamController<DownloadStatus>();

  BaseSingleSyncService(
      {required this.resource,
      this.fields,
      this.filters,
      required this.db,
      required this.label,
      required this.client});

  get url {
    return resource;
  }

  get box {
    return db.store.box<T>();
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
    return await client.httpGet<D>(url, queryParameters: queryParams);
  }

  T mapper(Map<String, dynamic> json);

  void sync() async {
    DownloadStatus status = DownloadStatus(
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
