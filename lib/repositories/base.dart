class BaseSingleRepository<T> {
  String resource;
  String? id;
  List<String> fields;
  late T entity;

  BaseSingleRepository({required this.resource, required this.fields, this.id});
}
