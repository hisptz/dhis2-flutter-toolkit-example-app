import 'dart:async';

import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';
import 'package:objectbox/objectbox.dart';

import '../models/base.dart';
import '../objectbox.g.dart';

class Pagination {
  int total;
  int pageSize;
  int pageCount;

  Pagination(this.total, this.pageSize, this.pageCount);

  Pagination.fromMap(Map json)
      : total = json["total"],
        pageSize = json["pageSize"],
        pageCount = json["pageCount"];
}

abstract class BaseSyncService<T extends DHIS2Resource> {
  StreamController<SyncStatus> controller = StreamController();
  String resource;
  List<String>? fields = [];
  List<String>? filters = [];
  Map<String, dynamic>? extraParams;
  Box<T> box;
  String label;
  String?
      dataKey; //Accessor to the JSON payload from the server. If absent, the resource will be used

  BaseSyncService(
      {required this.resource,
      this.fields,
      this.filters,
      this.dataKey,
      this.extraParams,
      required this.box,
      required this.label});

  get url {
    return resource;
  }

  get queryParams {
    Map<String, String> params = {
      ...(extraParams ?? {}),
      "page": "1",
      "pageSize": "50",
      "totalPages": "true"
    };
    if (fields != null) {
      params["fields"] = fields!.isNotEmpty ? fields!.join(",") : "";
    }
    if (filters != null) {
      params["filters"] = filters!.isNotEmpty ? filters!.join(",") : "";
    }
    return params;
  }

  get stream {
    return controller.stream;
  }

  //Currently just checks if there is any data on the specific data model
  bool isSynced() {
    List<T> entity = box.getAll();
    return entity.isNotEmpty;
  }

  T mapper(Map<String, dynamic> json);

  Future<Pagination> getPagination() async {
    Map<String, dynamic>? response =
        await dhis2client?.httpGetPagination<Map<String, dynamic>>(url,
            queryParameters: queryParams);
    if (response == null) {
      throw "Error getting pagination for data sync";
    }
    return Pagination.fromMap(response["pager"]);
  }

  Future<D?> getData<D>(int page) async {
    Map<String, String> updatedParams = {
      ...queryParams,
      "page": page.toString()
    };
    return await dhis2client?.httpGet<D>(url, queryParameters: updatedParams);
  }

  Future syncPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }
    List<Map<String, dynamic>> entityData =
        data[dataKey ?? resource].cast<Map<String, dynamic>>();
    List<T> entities = entityData.map(mapper).toList();

    await box.putManyAsync(entities);
  }

  Future setupSync() async {
    Pagination pagination = await getPagination();
    SyncStatus status = SyncStatus(
        synced: 0,
        total: pagination.pageCount,
        status: Status.initialized,
        label: label);
    controller.add(status);

    for (int page = 1; page <= pagination.pageCount; page++) {
      await syncPage(page);
      controller.add(status.increment());
    }
    controller.add(status.complete());
    controller.close();
  }

  /*
  * So apparently there is some metadata that comes with pagination and stuff. So we have to make sure we accommodate for that.
  * To enable this service to provide status of the operation, we are going to use a stream. The sync method will return a stream with progress data.
  *
  * How it works:
  *
  * 1. Get data pagination.
  * 2. Send the first sync status with status initialized and total count
  * 3. For each page, get the data, map into dart objects of type T and save to the box. Then update status by incrementing synced
  * 4. When done send a complete sync status
  * 5. Close the stream
  *

  ** */

  void sync() {
    setupSync();
  }
}
