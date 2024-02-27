import 'package:dhis2_flutter_toolkit/models/data/dataBase.dart';
import 'package:dhis2_flutter_toolkit/models/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityAttributes.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/trackedEntity.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class D2TrackedEntityAttributeValue extends D2DataResource {
  @override
  int id = 0;
  @override
  DateTime createdAt;

  @override
  DateTime updatedAt;

  String value;

  final trackedEntityAttribute = ToOne<D2TrackedEntityAttribute>();
  final trackedEntity = ToOne<TrackedEntity>();

  D2TrackedEntityAttributeValue({
    required this.createdAt,
    required this.updatedAt,
    required this.value,
  });

  D2TrackedEntityAttributeValue.fromMap(Map json, String trackedEntityId)
      : createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = DateTime.parse(json["updatedAt"]),
        value = json["value"] {
    print(trackedEntityId);
    trackedEntityAttribute.target =
        D2TrackedEntityAttributeRepository().getByUid(json["attribute"]);

    trackedEntity.target = TrackedEntityRepository().getByUid(trackedEntityId);
  }
}
