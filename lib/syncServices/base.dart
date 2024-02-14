import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

import '../models/base.dart';

abstract class BaseSyncService<T extends DHIS2Resource> {
  String resource;
  List<String> fields = [];
  List<String> filters = [];
  Function mapper;
  T? entity;
  List<T>? entities;

  BaseSyncService(
      {required this.resource, required this.fields, required this.mapper});

  get url {
    return resource;
  }

  get queryParams {
    return {"fields": fields.isEmpty ? fields.join(",") : ":owner"};
  }

  Future<D?> getData<D>() async {
    return await dhis2client?.httpGet<D>(url, queryParameters: queryParams);
  }

  Future<BaseSyncService<T>> get();

  Future<BaseSyncService<T>> save();
}
