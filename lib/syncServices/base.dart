import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

import '../models/base.dart';
import '../objectbox.g.dart';

abstract class BaseSyncService<T extends DHIS2Resource> {
  String resource;
  List<String>? fields = [];
  List<String> filters = [];
  T? entity;
  List<T>? entities;
  Box<T> box;
  String label;

  BaseSyncService(
      {required this.resource,
      this.fields,
      required this.box,
      required this.label});

  get url {
    return resource;
  }

  get queryParams {
    if (fields != null) {
      return {"fields": fields!.isNotEmpty ? fields!.join(",") : ""};
    }
  }

  //Currently just checks if there is any data on the specific data model
  Future<bool> isSynced() async {
    List<T> entity = await box.getAllAsync();
    return entity.isNotEmpty;
  }

  Future<D?> getData<D>() async {
    return await dhis2client?.httpGet<D>(url, queryParameters: queryParams);
  }

  Future<BaseSyncService<T>> get();

  Future<BaseSyncService<T>> save() async {
    if (entity == null) {
      throw "Entity not found. Make sure get is called first";
    }
    entity = await box.putAndGetAsync(entity!);
    return this;
  }

  Future<BaseSyncService<T>> sync() async {
    await get();
    await save();
    return this;
  }
}
