import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dhis2_flutter_toolkit/models/data/base.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';

class Pagination {
  int total;
  int pageSize;
  int pageCount;

  Pagination(
      {required this.total, required this.pageSize, required this.pageCount});
}

abstract class BaseTrackerSyncService<T extends D2DataResource> {
  ObjectBox db;
  D2Program program;
  DHIS2Client client;
  StreamController<DownloadStatus> controller =
      StreamController<DownloadStatus>();
  String resource;
  List<String>? fields = [];
  List<String>? filters = [];
  Map<String, dynamic>? extraParams;
  String label;
  String?
      dataKey; //Accessor to the JSON payload from the server. If absent, the resource will be used

  BaseTrackerSyncService(
      {required this.resource,
      this.fields,
      this.filters,
      this.dataKey,
      this.extraParams,
      required this.program,
      required this.db,
      required this.label,
      required this.client});

  get url {
    return resource;
  }

  get box {
    return db.store.box<T>();
  }

  get queryParams {
    Map<String, String> params = {
      ...(extraParams ?? {}),
      "page": "1",
      "pageSize": "200",
      "totalPages": "true",
      "program": program.uid,
      "ouMode": "ACCESSIBLE",
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
        await client.httpGetPagination<Map<String, dynamic>>(url,
            queryParameters: queryParams);
    if (response == null) {
      throw "Error getting pagination for data sync";
    }

    final pagination = Pagination(
        total: response["total"],
        pageSize: response["pageSize"],
        pageCount: response["pageCount"]);

    return pagination;
  }

  Future<D?> getData<D>(int page) async {
    Map<String, String> updatedParams = {
      ...queryParams,
      "page": page.toString()
    };
    return await client.httpGet<D>(url, queryParameters: updatedParams);
  }

  Future syncRelationships(List<Map<String, dynamic>> entityData) async {
    List<D2Relationship> relationships = [];
    for (final entity in entityData) {
      List<D2Relationship> relations = entity["relationships"]
          .map<D2Relationship>((rel) => D2Relationship.fromMap(db, rel))
          .toList()
          .where((rel) =>
              relationships
                  .firstWhereOrNull((element) => element.uid == rel.uid) ==
              null)
          .toList();
      relationships.addAll(relations);
    }

    await RelationshipRepository(db).saveEntities(relationships);
  }

  Future syncPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }

    List<Map<String, dynamic>> entityData =
        data[dataKey ?? resource].cast<Map<String, dynamic>>();

    final entities = entityData.map<T>(mapper).toList();
    await box.putManyAsync(entities);
    await syncRelationships(entityData);
  }

  Future setupSync() async {
    Pagination pagination = await getPagination();
    DownloadStatus status = DownloadStatus(
        synced: 0,
        total: pagination.pageCount,
        status: Status.initialized,
        label: "$label for ${program.name} program");
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
