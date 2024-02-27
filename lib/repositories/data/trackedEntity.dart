import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final trackedEntityBox = db.store.box<TrackedEntity>();

class TrackedEntityRepository extends BaseRepository<TrackedEntity> {
  TrackedEntityRepository() : super(trackedEntityBox);

  @override
  TrackedEntity? getByUid(String uid) {
    Query<TrackedEntity> query =
        trackedEntityBox.query(TrackedEntity_.uid.equals(uid)).build();
    return query.findFirst();
  }

  List<TrackedEntity>? getAll() {
    Query query = box.query().build();
    return query.find() as List<TrackedEntity>;
  }

  @override
  TrackedEntity mapper(Map<String, dynamic> json) {
    return TrackedEntity.fromMap(json);
  }

  TrackedEntityRepository byIdentifiableToken(String keyword) {
    final trackedEntities = trackedEntityBox.getAll();

    final matchingEntities = trackedEntities.where((trackedEntity) {
      final attributeEntities = trackedEntity.attributes.toList();

      final nameAttributes = attributeEntities.where((attribute) =>
          (attribute.trackedEntityAttribute.target?.name == "First name") ||
          (attribute.trackedEntityAttribute.target?.name == "Last name"));

      return nameAttributes.any((attribute) =>
          attribute.value.toLowerCase().contains(keyword.toLowerCase()));
    });
    final uidList = matchingEntities.map((entity) => entity.uid).toList();

    queryConditions = TrackedEntity_.uid
        .oneOf(uidList.isNotEmpty ? uidList : ["null"], caseSensitive: false);

    return this;
  }
}
